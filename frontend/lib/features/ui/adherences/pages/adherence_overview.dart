import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/state_widget.dart';
import 'package:frontend/features/providers/utils/collection_providers.dart';
import 'package:frontend/features/ui/adherences/widgets/adherence_card.dart';


class AdherenceView extends ConsumerWidget {
  const AdherenceView({
    super.key,
    required this.fmid,
    required this.fmmid,
  });

  final String fmid;
  final String fmmid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberAsync = ref.watch(aggregateMemberProvider(fmid));

    return switch (memberAsync) {
      AsyncLoading() => const Scaffold(body: LoadingCard()),
      AsyncError() => TemplateStatePage(body: ErrorBody(callback: () async => ref.refresh(aggregateMemberProvider(fmid)))),
      AsyncData(:final value) => AdherenceLogSection(
        membership: value,
        assigned: value.assignments.firstWhere((v) => v.assignment.id == fmmid)
      )
    };
  }
}