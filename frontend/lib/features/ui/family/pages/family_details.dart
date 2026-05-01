import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/state_widget.dart';
import 'package:frontend/features/providers/auth/auth_provider.dart';
import 'package:frontend/features/providers/family/family_providers.dart';
import 'package:frontend/features/providers/utils/collection_providers.dart';
import 'package:frontend/features/ui/family/widgets/family_section.dart';
import 'package:frontend/models/enums/enums.dart';
import 'package:frontend/models/models.dart';
import 'package:go_router/go_router.dart';

class FamilyView extends ConsumerWidget {
  const FamilyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(userRoleProvider);
    if (role == UserRole.caregiver) {
      return const CaregiverFamilyView();
    } else {
      return const MemberFamilyView();
    }
  }
}

class CaregiverFamilyView extends ConsumerWidget {
  const CaregiverFamilyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familyAsync = ref.watch(currentFamilyObjectProvider);

    if (familyAsync.isLoading) return const LoadingCard();
    if (familyAsync.hasError) return ErrorCard(message: familyAsync.error.toString());

    final family = familyAsync.value;

    if (family == null || family.isEmpty) {
      return TemplateStatePage(
        body: EmptyBody(
          type: 'family',
          role: UserRole.caregiver,
          redirect: () => context.push('/family/create'),
          refresh: () => ref.refresh(currentFamilyObjectProvider.future)
        )
      );
    }

    final membersAsync = ref.watch(aggregateMembershipsProvider(family.id));

    switch (membersAsync) {
      case AsyncLoading():
        return TemplateStatePage(body: LoadingBody());
      case AsyncError():
        return TemplateStatePage(
          body: ErrorBody(callback: () async => ref.refresh(aggregateMembershipsProvider(family.id).future)),
        );
      case AsyncData(:final value):
        return FamilyMembersDetailSection(members: value, family: family);
    }
  }
}

class MemberFamilyView extends ConsumerWidget {
  const MemberFamilyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familyAsync = ref.watch(currentFamilyObjectProvider);

    switch (familyAsync) {
      case AsyncData(:final value):
        if (value == null || value.isEmpty) {
          return TemplateStatePage(body: EmptyBody(
            type: 'family',
            role: UserRole.familyMember,
            refresh: () => ref.refresh(currentFamilyObjectProvider.future)
          ));
        }
        final fid = value.id;
        final membersAsync = ref.watch(aggregateMembershipsProvider(fid));
        switch (membersAsync) {
          case AsyncLoading(): return const LoadingCard();
          case AsyncError(): return TemplateStatePage(body: ErrorBody(callback: () async => aggregateMembershipsProvider(fid)));
          case AsyncData(:final value) when value.isEmpty:
            return TemplateStatePage(body: EmptyBody(
              type: 'members',
              role: UserRole.familyMember,
              refresh: () => ref.refresh(aggregateMembershipsProvider(fid))
            ));
          case AsyncData(:final value):
            return MembersFamilyDetailSection(
              members: value,
              family: familyAsync.value!,
            );
        }
      case AsyncError(): return TemplateStatePage(body: ErrorBody(callback: () async => ref.refresh(currentFamilyObjectProvider)));
      case AsyncLoading(): return const LoadingCard();
    }
  }
}