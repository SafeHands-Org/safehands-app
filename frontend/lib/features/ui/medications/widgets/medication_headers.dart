import 'package:flutter/material.dart';
import 'package:frontend/features/components/shared/app_gradient_header.dart';
import 'package:frontend/features/components/shared/stat_chip.dart';
import 'package:go_router/go_router.dart';

class MedicationListHeader extends StatelessWidget {
  const MedicationListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppGradientHeader(
      leading: HeaderIconButton(
        icon: Icons.arrow_back,
        onPressed: () => context.pop(),
      ),
      title: "My Medications",
      statsRow: const Row(
        children: [
          Expanded(
            child: StatChip(value: '4', label: 'Medications'),
          ),
          SizedBox(width: 12),
          Expanded(
            child: StatChip(value: '7', label: 'Active Meds'),
          ),
          SizedBox(width: 12),
          Expanded(
            child: StatChip(value: '2', label: 'Inactive Meds'),
          ),
        ],
      ),
    );
  }
}

class EmptyListHeader extends StatelessWidget {
  const EmptyListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppGradientHeader(
      leading: HeaderIconButton(
        icon: Icons.arrow_back,
        onPressed: () => context.pop(),
      ),
      title: "My Medications",
    );
  }
}

class MemberMedicationHeader extends StatelessWidget {
  const MemberMedicationHeader({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return AppGradientHeader(
      leading: HeaderIconButton(
        icon: Icons.arrow_back,
        onPressed: () => context.pop(),
      ),
      title: "My Medications",
      statsRow: const Row(
        children: [
          Expanded(
            child: StatChip(value: '4', label: 'Medications'),
          ),
          SizedBox(width: 12),
          Expanded(
            child: StatChip(value: '7', label: 'Active Meds'),
          ),
          SizedBox(width: 12),
          Expanded(
            child: StatChip(value: '2', label: 'Inactive Meds'),
          ),
        ],
      ),
    );
  }
}