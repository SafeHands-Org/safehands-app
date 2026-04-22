import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/section_header.dart';
import 'package:frontend/features/providers/medication/medication_providers.dart';
import 'package:frontend/features/ui/medications/pages/medication_form.dart';
import 'package:frontend/features/ui/medications/widgets/medication_card.dart';

class MedicationsView extends ConsumerWidget {
  const MedicationsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    return ref.watch(medicationsProvider).when(
      data: (data) {
        final medications = data.values.toSet();
        if (medications.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Nothing to see here...'),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                Spacer(flex: 2),
              ],
            )
          );
        }
        return LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SectionHeader(title: 'Medications'),
                                ...medications.map(
                                  (medication) => (
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: MedicationCard(
                                        med: medication
                                      ),
                                    )
                                  )
                                )
                              ]
                            )
                          )
                        ]
                      )
                    )
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.07,
                  right: MediaQuery.of(context).size.width * 0.07,
                  child: FloatingActionButton(
                    heroTag: 'add_med',
                    onPressed: () => _showAddSheet(context),
                    foregroundColor: cs.onTertiaryContainer,
                    backgroundColor: cs.tertiaryContainer,
                    child: const Icon(Icons.add)
                  ),
                ),
              ],
            );
          },
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(medicationsProvider),
                child: const Text('Retry'),
              ),
            ],
          )
        );
      },
    );
  }
  void _showAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        child: MedicationFormView(),
      ),
    );
  }
}