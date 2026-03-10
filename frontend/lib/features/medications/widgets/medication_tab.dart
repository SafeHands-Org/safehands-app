import 'package:flutter/material.dart';
import 'package:frontend/features/medications/widgets/add_medication_sheet.dart';
import 'package:frontend/features/medications/widgets/medication_card.dart';
import 'package:provider/provider.dart';
import 'package:frontend/styles/app_theme.dart';
import "../../../models/medications/medication_provider.dart";

class MedicationsTab extends StatelessWidget {
  final String memberId;
  final String memberName;
  final String currentUserId;
  const MedicationsTab({
    required this.memberId,
    required this.memberName,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MedicationProvider>(builder: (_, p, _) {
      final meds = p.forMember(memberId);
      return Stack(children: [
        meds.isEmpty
            ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const SizedBox(height: 12),
                Text('No medications for $memberName',
                    style: AppTheme.body.copyWith(color: Colors.grey)),
              ]))
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                itemCount: meds.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (_, i) => MedicationCard(med: meds[i], memberId: memberId),
              ),
        Positioned(
          bottom: 16, right: 16,
          child: FloatingActionButton.extended(
            heroTag: 'add_med',
            onPressed: () => _showAddSheet(context, p),
            backgroundColor: AppTheme.primary,
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text('Add Medication', style: TextStyle(color: Colors.white)),
          ),
        ),
      ]);
    });
  }

  void _showAddSheet(BuildContext context, MedicationProvider p) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => AddMedicationSheet(
        memberId: memberId,
        currentUserId: currentUserId,
        provider: p,
      ),
    );
  }
}