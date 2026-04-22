import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/app_gradient_header.dart';
import 'package:go_router/go_router.dart';

class MedicationDetailView extends ConsumerStatefulWidget {
  const MedicationDetailView({super.key});

  @override
  ConsumerState<MedicationDetailView> createState() => _MedicationDetailtate();
}

class _MedicationDetailtate extends ConsumerState<MedicationDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppGradientHeader(
            leading: HeaderIconButton(
              icon: Icons.arrow_back,
              onPressed: () => context.pop(),
            ),
            title: 'New Medication',
            subtitle: 'Add to your medication library',
          ),
        ]
      )
    );
  }
}