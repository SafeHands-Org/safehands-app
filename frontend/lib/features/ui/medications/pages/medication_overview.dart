import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/section_header.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/ui/medications/widgets/medication_card.dart';
import 'package:go_router/go_router.dart';

class MedicationsView extends ConsumerWidget {
  const MedicationsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: cs.onInverseSurface,
          onPressed: () => context.canPop() ? context.pop() : context.go('/medications')
        ),
        flexibleSpace: Container(decoration: BoxDecoration(gradient: context.palette.header)),
        title: Text(
          'My Medications',
          style: tt.titleMedium?.copyWith(color: cs.onInverseSurface),
          textAlign: TextAlign.center
        )
      ),
      body: Container(
        decoration: BoxDecoration(gradient: context.palette.page),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
          child: Center(
            child: Column(
              children: [
                SectionHeader(title: 'Active Medications'),
                Expanded(
                  child: Card(
                    child: MedicationList()
                  )
                )
              ],
            )
          )
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/medications/create'),
        foregroundColor: cs.onTertiaryContainer,
        backgroundColor: cs.tertiaryContainer,
        child: const Icon(Icons.add)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}