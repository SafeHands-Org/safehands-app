import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/features/components/shared/state_widget.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/models/medications/medication.dart';


class MedicationList extends ConsumerWidget {
  const MedicationList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicationsAsync = ref.watch(medicationsProvider);

    switch (medicationsAsync) {
      case AsyncLoading(): return const LoadingCard();
      case AsyncError(:final error): return ErrorCard(message: error.toString());
      case AsyncData(:final value) when value.isEmpty: return const EmptyCard(
        message: 'No family members found.', icon: Icons.people_outline);
      case AsyncData(:final value):
        final medicationList = value.values.toList();
        return ListView.separated(
          padding: EdgeInsets.only(top: 16),
          itemCount: value.values.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemBuilder: (context, index) {

          return MedicationCard(med: medicationList[index]);
        }
      );
    }
  }
}


class MedicationCard extends StatelessWidget {
  const MedicationCard({super.key, required this.med});

  final Medication med;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.borderRadiusCard
      ),
      leading:medicationAvatar(cs, med.doseForm),
      title: Text(
        '${med.names.first} ${med.dosage} ${med.doseForm} ',
        style: tt.titleSmall?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        'Other: ${med.names.last}',
        style: tt.labelMedium
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(Icons.chevron_right, size: 20),
      ),
    );



    //Container(
    //  decoration: BoxDecoration(
    //    color: cs.surface,
    //    borderRadius: AppRadius.borderRadiusCard,
    //    border: Border.all(color: cs.outlineVariant),
    //  ),
    //  child: Stack(
    //    children: [
    //      Padding(
    //        padding: const EdgeInsets.all(16),
    //        child: Column(
    //          crossAxisAlignment: CrossAxisAlignment.start,
    //          children: [
    //            Row(
    //              children: [
    //                _MedicationAvatar(
    //                  name: med.doseForm,
    //                  radius: 23,
    //                  color: cs.secondary,
    //                ),
    //                const SizedBox(width: 12),
    //                Expanded(
    //                  child: Column(
    //                    crossAxisAlignment: CrossAxisAlignment.start,
    //                    children: [
    //                      Text(
    //                        '${med.names.first} ${med.dosage} ${med.doseForm} ',
    //                        style: TextStyle(
    //                          fontSize: 15, fontWeight: FontWeight.w600,
    //                          color: cs.onSurface,
    //                        ),
    //                      ),
    //                      Text(
    //                        'Generic name: ${med.names.last}',
    //                        style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant),
    //                      ),
    //                    ],
    //                  ),
    //                ),
    //              ],
    //            ),
    //            const SizedBox(height: 10),
    //            Text(med.instructions),
    //            const SizedBox(height: 10,)
    //          ],
    //        ),
    //      ),
    //      Positioned(
    //        top: 8,
    //        right: 8,
    //        child: Container(
    //          width: 35,
    //          height: 35,
    //          decoration: BoxDecoration(
    //            color: cs.surface,
    //            borderRadius: BorderRadius.circular(8),
    //          ),
    //          child: IconButton(
    //            onPressed: () {},
    //            icon: Icon(Icons.chevron_right, size: 20),
    //          ),
    //        ),
    //      ),
    //    ],
    //  ),
    //);


  }

  Widget medicationAvatar(ColorScheme scheme, String name) {
    return CircleAvatar(
      radius: 28,
      backgroundColor: scheme.secondaryContainer.withValues(alpha: 0.8),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 23, maxWidth: 23),
        child: _doseFormIcon(name, scheme.secondary.withValues(alpha: 0.65))
      )
    );
  }

   FaIcon _doseFormIcon(String form, Color color) => switch (form) {
    'tablet'       => FaIcon(FontAwesomeIcons.tablets, color: color, size: 20),
    'capsule'      => FaIcon(FontAwesomeIcons.capsules, color: color, size: 20),
    'liquid'       => FaIcon(FontAwesomeIcons.droplet, color: color, size: 20),
    'inhaler'      => FaIcon(FontAwesomeIcons.wind, color: color, size: 20),
    'injection'    => FaIcon(FontAwesomeIcons.syringe, color: color, size: 20),
    'topical'      => FaIcon(FontAwesomeIcons.pumpMedical, color: color, size: 20),
    'drops'        => FaIcon(FontAwesomeIcons.droplet, color: color, size: 20),
    'patch'        => FaIcon(FontAwesomeIcons.bandage, color: color, size: 20),
    _              => FaIcon(FontAwesomeIcons.prescriptionBottleMedical, color: color, size: 20),
  };
}