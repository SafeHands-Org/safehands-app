import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/state_widget.dart';
import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/features/ui/adherences/widgets/adherence_card.dart';

class AdherenceView extends ConsumerWidget{
  const AdherenceView({super.key, required this.fmId, required this.fmmId});

  final String fmId;
  final String fmmId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adherenceAsync = ref.watch(adherencesProvider);

    return switch (adherenceAsync) {
      AsyncError(:final error) => ErrorCard(message: error.toString()),
      AsyncData(:final value) when value.isEmpty => const EmptyCard(message: 'No logs found.'),
      AsyncData(:final value) => Column(
        children: [
          (value[fmId] != null || value[fmId]!.where((v) => v.fmmid == fmmId).isNotEmpty )
          ? const EmptyCard(message: 'No logs found.')
          : ListView.builder(
              itemCount: value[fmId]!.where((v) => v.fmmid == fmmId).length,
              itemBuilder: (context, index) => AdherenceCard(
                log: value[fmId]!
                      .where((v) => v.fmmid == fmmId)
                      .toList()[index],
                fmId: fmId,
                fmmId: fmmId
              ),
            ),
          ]
        ),
      _ => const LoadingCard()
    };
  }
}