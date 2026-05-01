import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/models/medications/medication.dart';
import 'package:go_router/go_router.dart';

class MedicationList extends ConsumerWidget {
  const MedicationList({super.key, required this.medications});

  final Map<String, Medication> medications;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicationList = medications.values.toList();
    return Column(
      children: [
        for (final (index, med) in medicationList.indexed) ...[
          MedicationCard(med: med),
          if (index != medicationList.length - 1) const Divider(),
        ]
      ],
    );
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
      minTileHeight: 72,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusCard),
      leading: medicationAvatar(cs, med.doseForm),
      title: Text(
        '${med.displayName} ${med.dosage} ${med.doseForm}'.trim(),
        style: tt.titleSmall?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: med.alternateName.isNotEmpty
          ? Text('Other: ${med.alternateName}', style: tt.labelMedium)
          : null,
      trailing: IconButton(
        onPressed: () => context.push('/medications/edit', extra: med),
        icon: const Icon(Icons.more_vert_outlined, size: 20),
      ),
    );
  }

  Widget medicationAvatar(ColorScheme scheme, String name) {
    return CircleAvatar(
      radius: 28,
      backgroundColor: scheme.secondaryContainer.withValues(alpha: 0.8),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 23, maxWidth: 23),
        child: _doseFormIcon(name, scheme.secondary.withValues(alpha: 0.65)),
      ),
    );
  }

  FaIcon _doseFormIcon(String form, Color color) => switch (form) {
    'tablet'    => FaIcon(FontAwesomeIcons.tablets, color: color, size: 20),
    'capsule'   => FaIcon(FontAwesomeIcons.capsules, color: color, size: 20),
    'liquid'    => FaIcon(FontAwesomeIcons.droplet, color: color, size: 20),
    'inhaler'   => FaIcon(FontAwesomeIcons.wind, color: color, size: 20),
    'injection' => FaIcon(FontAwesomeIcons.syringe, color: color, size: 20),
    'topical'   => FaIcon(FontAwesomeIcons.pumpMedical, color: color, size: 20),
    'drops'     => FaIcon(FontAwesomeIcons.droplet, color: color, size: 20),
    'patch'     => FaIcon(FontAwesomeIcons.bandage, color: color, size: 20),
    _           => FaIcon(FontAwesomeIcons.prescriptionBottleMedical, color: color, size: 20),
  };
}