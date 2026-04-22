import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/state_widget.dart';
import 'package:frontend/features/providers/auth/auth_provider.dart';
import 'package:frontend/features/providers/utils/collection_providers.dart';
import 'package:frontend/features/ui/user/widgets/family_member_account.dart';
import 'package:frontend/models/models.dart';

class UserProfileView extends ConsumerWidget{
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(userRoleProvider);
    if (role == UserRole.caregiver) {
      return CaregiverAccountView();
    } else {
      return MemberAccountView();
    }
  }
}

class CaregiverAccountView extends ConsumerWidget {
  const CaregiverAccountView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familyAsync = ref.watch(aggregateFamilyProvider);
    final currentUser = ref.watch(currentUserProvider);

    return Scaffold(
      body: switch (familyAsync) {
        AsyncLoading() => const Scaffold(body: LoadingCard()),
        AsyncError(:final error) => Scaffold(body: ErrorCard(message: error.toString())),
        AsyncData(:final value) => MemberProfileBody(
          family: value,
          currentUserId: currentUser?.id,
        ),
      },
    );
  }
}

class MemberAccountView extends ConsumerWidget {
  const MemberAccountView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familyAsync = ref.watch(aggregateFamilyProvider);
    final currentUser = ref.watch(currentUserProvider);

    return Scaffold(
      body: switch (familyAsync) {
        AsyncLoading() => const Scaffold(body: LoadingCard()),
        AsyncError(:final error) => Scaffold(body: ErrorCard(message: error.toString())),
        AsyncData(:final value) => MemberProfileBody(
          family: value,
          currentUserId: currentUser?.id,
        ),
      },
    );
  }
}