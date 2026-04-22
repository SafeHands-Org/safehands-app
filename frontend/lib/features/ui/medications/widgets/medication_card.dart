import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/models/medications/medication.dart';

class MedicationCard extends StatelessWidget {
  const MedicationCard({super.key, required this.med});

  final Medication med;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: AppRadius.borderRadiusCard,
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _MedicationAvatar(
                      name: med.doseForm,
                      radius: 23,
                      color: cs.secondary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${med.names.first} ${med.dosage} ${med.doseForm} ',
                            style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600,
                              color: cs.onSurface,
                            ),
                          ),
                          Text(
                            'Generic name: ${med.names.last}',
                            style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(med.instructions),
                const SizedBox(height: 10,)
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.chevron_right, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MedicationAvatar extends StatelessWidget {
  const _MedicationAvatar({
    required this.name,
    required this.color,
    this.radius = 28,
  });

  final String name;
  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return CircleAvatar(
      radius: radius,
      backgroundColor: cs.secondaryContainer.withValues(alpha: 0.8),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 23, maxWidth: 23),
        child: _doseFormIcon(name, cs.secondary.withValues(alpha: 0.65))
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