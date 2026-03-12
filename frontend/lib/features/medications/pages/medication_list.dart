import 'package:flutter/material.dart';
import 'package:frontend/controllers/medication_controller.dart';
import 'package:frontend/features/components/styles/app_theme.dart';
import 'package:frontend/features/medications/pages/medication_form.dart';
import 'package:provider/provider.dart';

class MedicationListPage extends StatefulWidget {
  static const routeName = '/medications';
  const MedicationListPage({super.key});

  @override
  State<MedicationListPage> createState() => _MedicationListPageState();
}

class _MedicationListPageState extends State<MedicationListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<MedicationController>().loadMedications(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medications',
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<MedicationController>(builder: (_, p, _) {
        if (p.loading) {
          return Center(child: CircularProgressIndicator(color: AppTheme.primary));
        }
        if (p.error != null) {
          return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(p.error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: p.loadMedications,
                style: AppTheme.buttonStyle, child: const Text('Retry')),
          ]));
        }
        if (p.medications.isEmpty) {
          return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 16),
            const Text('No medications yet', style: AppTheme.subtitle),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _openForm(context),
              icon: const Icon(Icons.add), label: const Text('Add Medication'),
              style: AppTheme.buttonStyle,
            ),
          ]));
        }
        return RefreshIndicator(
          color: AppTheme.primary,
          onRefresh: p.loadMedications,
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: p.medications.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (_, i) => _MedCard(med: p.medications[i]),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(context),
        backgroundColor: AppTheme.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  void _openForm(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (_) => const MedicationForm()),
  );
}

class _MedCard extends StatelessWidget {
  final med;
  const _MedCard({required this.med});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 48, height: 48,
          decoration: BoxDecoration(
            color: AppTheme.inputFill,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        title: Text(med.nameEntered,
            style: AppTheme.body.copyWith(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(
          [med.doseForm, if (med.dosage != null) med.dosage].join(' · '),
          style: AppTheme.body.copyWith(color: Colors.grey),
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (v) async {
            final p = context.read<MedicationController>();
            if (v == 'edit') {
              await Navigator.push(context,
                  MaterialPageRoute(builder: (_) => MedicationForm(medication: med)));
            } else {
              final ok = await _confirm(context, 'Delete "${med.nameEntered}"?');
              if (ok && context.mounted) p.deleteMed(med.id);
            }
          },
          itemBuilder: (_) => [
            const PopupMenuItem(value: 'edit',
                child: Row(children: [Icon(Icons.edit_outlined, size: 18), SizedBox(width: 8), Text('Edit')])),
            const PopupMenuItem(value: 'delete',
                child: Row(children: [Icon(Icons.delete_outline, size: 18, color: Colors.red), SizedBox(width: 8),
                  Text('Delete', style: TextStyle(color: Colors.red))])),
          ],
        ),
      ),
    );
  }

  Future<bool> _confirm(BuildContext ctx, String msg) async => await showDialog<bool>(
    context: ctx,
    builder: (c) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Text(msg),
      actions: [
        TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancel')),
        ElevatedButton(onPressed: () => Navigator.pop(c, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, shape: const StadiumBorder()),
            child: const Text('Delete', style: TextStyle(color: Colors.white))),
      ],
    ),
  ) ?? false;
}