
import 'package:flutter/material.dart';
import 'package:frontend/features/components/shared/app_gradient_header.dart';
import 'package:frontend/features/components/shared/section_header.dart';
import 'package:frontend/features/components/shared/state_widget.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AdherenceLogSection extends StatelessWidget {
  const AdherenceLogSection({
    super.key,
    required this.membership,
    required this.assigned
  });

  final Member membership;
  final Assignment assigned;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final palette = context.palette;

    final member = membership.member;
    final medication = assigned.reference;

    final logs = assigned.logs;

    final takenLogs   = assigned.allTakenLogs;
    final missedLogs  = assigned.allMissedLogs;
    final todayLogs   = assigned.todaysLogs;
    final todayTaken  = assigned.todaysTaken;

    final medicationName = medication.isNotEmpty ? medication.names.first : 'Medication';
    final sorted = assigned.sortedLogs;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppGradientHeader(
              leading: HeaderIconButton(icon: Icons.arrow_back, onPressed: () => context.pop()),
              title: medicationName,
              subtitle: member.isNotEmpty ? member.name : 'Member',
              statsRow: Row(
                children: [
                  Expanded(
                    child: StatChipSmall(value: medication.dosage, label: 'Dosage'),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: StatChipSmall(value: medication.doseForm, label: 'Form'),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: StatChipSmall(value: '${logs.length}', label: 'Total Logs'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(title: 'Summary'),
                  Row(
                    children: [
                      Expanded(
                        child: statsChip(
                          context: context,
                          color: palette.categoryGreenContainer,
                          value: statsIndicator(
                            label: '${todayTaken.length}/${todayLogs.isEmpty ? 0 : todayLogs.length}',
                            value: todayLogs.isEmpty ? todayTaken.length/0 : todayTaken.length / todayLogs.length,
                            palette: palette,
                            context: context
                          ),
                          label: 'Today'
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: statsChip(
                          context: context,
                          color: palette.categoryGreenContainer,
                          value: statsIndicator(
                            label: '${takenLogs.isEmpty ? 0 : takenLogs.length}/${logs.isEmpty ? 0 : logs.length}',
                            value: logs.isEmpty ? takenLogs.length/0 : takenLogs.length/logs.length,
                            palette: palette,
                            context: context
                          ),
                          label: 'Taken'
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: statsChip(
                          context: context,
                          color: palette.categoryGreenContainer,
                          value: statsIndicator(
                            label: '${missedLogs.isEmpty ? 0 : missedLogs.length}/${logs.isEmpty ? 0 : logs.length}',
                            value: logs.isEmpty ? missedLogs.length/0 : missedLogs.length/logs.length,
                            palette: palette,
                            context: context
                          ),
                          label: 'Missed'
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const SectionHeader(title: 'Instructions'),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: palette.categoryBlueContainer ,borderRadius: AppRadius.borderRadiusMd),
                            child: Icon(Icons.info_outline,color: palette.categoryBlue,size: 16),
                          ),
                          const SizedBox(width: 12),
                          Expanded(child: Text(medication.instructions, style: tt.bodySmall)),
                        ]
                      )
                    )
                  ),
                  const SizedBox(height: 24),
                  const SectionHeader(title: 'Adherence Logs'),
                  if (logs.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: EmptyCard(
                        message: 'No adherence logs found for this medication.',
                        icon: Icons.history_outlined,
                      ),
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    ...sorted.map((log) =>
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _AdherenceLogCard(log: log),
                        )
                      ),
                    ],
                  )
                ],
              ),
            ),
          ]
        )
      )
    );
  }
  Widget statsChip({required BuildContext context, required Color color, required Widget value, required String label}) {
    return Container(
      width: 108,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            value,
            const SizedBox(height: 20),
            Text(
              label,
              style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface, height: 1.2),
            ),
          ]
        ),
      )
    );
  }
  Widget statsIndicator({
    required String label,
    required double value,
    required PaletteExtension palette,
    required BuildContext context
  }){
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(
            strokeWidth: 5.0,
            value: value,
            backgroundColor: Theme.of(context).colorScheme.outlineVariant,
            valueColor: AlwaysStoppedAnimation<Color>(palette.categoryGreen),
          ),
        ),
        Text(label),
      ],
    );
  }
}

class _AdherenceLogCard extends StatelessWidget {
  const _AdherenceLogCard({required this.log});
  final MedicationAdherenceLog log;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final (bg, border, iconBg, iconColor, iconData, statusLabel) =
      switch (log.status) {
        'taken' => (
          palette.categoryGreen.withValues(alpha: 0.4),
          palette.categoryGreen.withAlpha(220),
          palette.categoryGreen.withAlpha(240),
          palette.categoryGreen.withAlpha(250),
          Icons.check_circle_outline,
          'Taken',
        ),

        'missed' => (
          cs.error,
          cs.error.withAlpha(220),
          cs.error.withAlpha(240),
          cs.error.withAlpha(250),
          Icons.cancel_outlined,
          'Missed',
        ),

        _ => (
          cs.primary,
          cs.primary.withAlpha(220),
          cs.primary.withAlpha(240),
          cs.primary.withAlpha(250),
          Icons.access_time_outlined,
          'Scheduled',
        )
    };

    final scheduledDisplay = timeToDisplay(log.scheduledTime);
    final takenDisplay = log.takenAt != null ? DateFormat('h:mm a').format(log.takenAt!) : null;
    final dateDisplay = log.takenAt != null
      ? DateFormat('M/d/y').format(log.takenAt!)
      : log.scheduledTime;

    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(16, 5, 16, 5),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.borderRadiusCard
        ),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: bg,
          child: Icon(
            iconData,
            size: 28,
            color: iconColor
          )
        ),
        title: Text(dateDisplay.toString(), style: tt.bodyLarge?.copyWith(fontWeight: FontWeight.w500)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Scheduled $scheduledDisplay', style: tt.bodyMedium),
            if (takenDisplay != null) ...[
              const SizedBox(height: 2),
              Text('Taken at $takenDisplay', style: tt.bodySmall),
            ],
          ],
        ),
      )
    );
  }
}


class StatChipSmall extends StatelessWidget {
  const StatChipSmall({super.key, required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final newValue = value[0].toUpperCase() + value.substring(1);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: cs.surface.withValues(alpha: 0.12),
        borderRadius: AppRadius.borderRadiusLg,
        border: Border.all(color: cs.surface.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            newValue,
            style: tt.titleSmall!.copyWith(
              fontWeight: FontWeight.w700,
              color: cs.surface
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: tt.bodySmall!.copyWith(color: cs.surface.withValues(alpha: 0.8)),
          ),
        ],
      ),
    );
  }
}