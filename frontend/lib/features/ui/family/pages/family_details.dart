import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/primary_action_button.dart';
import 'package:frontend/features/components/shared/state_widget.dart';
import 'package:frontend/features/providers/auth/auth_provider.dart';
import 'package:frontend/features/providers/family/family_providers.dart';
import 'package:frontend/features/providers/utils/collection_providers.dart';
import 'package:frontend/features/ui/family/widgets/family_section.dart';
import 'package:frontend/models/enums/enums.dart';
import 'package:go_router/go_router.dart';

class FamilyView extends ConsumerWidget {
  const FamilyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(userRoleProvider);
    if (role == UserRole.caregiver) {
      return CaregiverFamilyView();
    } else {
      return MemberFamilyView();
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

    final fid = familyAsync.value!.id;
    final membersAsync = ref.watch(aggregateMembershipsProvider(fid));

    switch (membersAsync) {
      case AsyncLoading(): return TemplateStatePage(body: LoadingBody());
      case AsyncError(): return TemplateStatePage(body: RefreshIndicator(
        onRefresh: () => ref.refresh(aggregateMembershipsProvider(fid).future),
        child: ErrorBody()
      ));
      case AsyncData(:final value) when value.isEmpty: return TemplateStatePage(body: EmptyBody(
        action: PrimaryActionButton(
          onPressed: () => context.push('/family/create'),
          buttonText: 'Create a Family',
          buttonIcon: Icon(Icons.add)
        )
      ));
      case AsyncData(:final value): return FamilyMembersDetailSection(members: value, family: familyAsync.value!);
    }
  }
}

class MemberFamilyView extends ConsumerWidget {
  const MemberFamilyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familyAsync = ref.watch(currentFamilyObjectProvider);

    switch (familyAsync) {
      case AsyncData(:final value?): {
        if (value.isEmpty){
          return EmptyCard(message: 'No Family Yet');
        }
        final fid = value.id;
        final membersAsync = ref.watch(aggregateMembershipsProvider(fid));
        switch (membersAsync) {
          case AsyncLoading(): return const LoadingCard();
          case AsyncError(:final error): return ErrorCard(message: error.toString());
          case AsyncData(:final value) when value.isEmpty: return const EmptyCard(message: 'No family members found.', icon: Icons.people_outline);
          case AsyncData(:final value): return MembersFamilyDetailSection(members: value, family: familyAsync.value!);
        }
      }
      case AsyncError(:final error): return ErrorCard(message: error.toString());
      case AsyncLoading(): return const LoadingCard();
      default: return EmptyBody();
    }
  }
}

