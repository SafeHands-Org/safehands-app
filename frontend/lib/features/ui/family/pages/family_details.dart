import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/state_widget.dart';
import 'package:frontend/features/providers/family/family_providers.dart';
import 'package:frontend/features/providers/utils/collection_providers.dart';
import 'package:frontend/features/ui/family/widgets/family_section.dart';

class FamilyView extends ConsumerWidget {
  const FamilyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familyAsync = ref.watch(currentFamilyObjectProvider);

    if (familyAsync.isLoading) return const LoadingCard();
    if (familyAsync.hasError) return ErrorCard(message: familyAsync.error.toString());

    final fid = familyAsync.value!.id;
    final membersAsync = ref.watch(aggregateMembershipsProvider(fid));

    switch (membersAsync) {
      case AsyncLoading(): return const LoadingCard();
      case AsyncError(:final error): return ErrorCard(message: error.toString());
      case AsyncData(:final value) when value.isEmpty: return const EmptyCard(message: 'No family members found.', icon: Icons.people_outline);
      case AsyncData(:final value): return FamilyMembersDetailSection(members: value, family: familyAsync.value!);
    }
  }
}
