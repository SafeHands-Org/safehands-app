import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/styles/app_theme.dart';
import "../../../models/medications/medication_service.dart";
import "../../../models/medications/medication_provider.dart";

class MedicationCard extends StatelessWidget {
  final MemberMedication med;
  final String memberId;
  const MedicationCard({required this.med, required this.memberId});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: med.active ? Colors.grey.shade200 : Colors.orange.shade100),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(children: [
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(med.nameEntered ?? 'Medication',
                style: AppTheme.body.copyWith(fontWeight: FontWeight.bold, fontSize: 15)),
            if (med.dosage != null)
              Text(med.dosage!, style: AppTheme.body.copyWith(color: Colors.grey)),
            Text('Since ${med.startDate}',
                style: AppTheme.body.copyWith(color: Colors.grey, fontSize: 12)),
          ])),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: (med.active ? Colors.green : Colors.orange).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(med.active ? 'Active' : 'Inactive',
                style: TextStyle(
                    color: med.active ? Colors.green : Colors.orange,
                    fontWeight: FontWeight.w600, fontSize: 12)),
          ),
          if (med.active)
            IconButton(
              icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
              onPressed: () async {
                final ok = await _confirm(context,
                    'Remove "${med.nameEntered ?? 'this medication'}" from this member?');
                if (ok && context.mounted) {
                  context.read<MedicationProvider>().removeAssign(med.id, memberId);
                }
              },
            ),
        ]),
      ),
    );
  }

  Future<bool> _confirm(BuildContext ctx, String msg) async =>
      await showDialog<bool>(
        context: ctx,
        builder: (c) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: Text(msg),
          actions: [
            TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () => Navigator.pop(c, true),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, shape: const StadiumBorder()),
              child: const Text('Remove', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ) ?? false;
}