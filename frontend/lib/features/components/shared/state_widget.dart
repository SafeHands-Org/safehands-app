import 'package:flutter/material.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/models/enums/enums.dart';

Map<String, (String, String, String?, IconData)> caregiverActions = {
  'dashboard' : (
    'No Information to Show.',
    'View member\'s active medication overview\'s here.',
    'Create a Family',
    Icons.people
  ),
  'family' : (
    'No Family to Show',
    'View your family\'s information here.',
    'Create a Family',
    Icons.diversity_1
  ),
  'members' : (
    'No Members to Show',
    'When people join your family group, they\'ll appear here.',
    'View Family Invite',
    Icons.people
  ),
  'medications' : (
    'No Medications to Show',
    'When a new medication is saved, they\'ll appear here.',
    'Create a New Medication',
    Icons.medication
  ),
  'assignments' : (
    'No Medications to Show',
    'When a medication for this member is assigned, they\'ll appear here.',
    'Assign a New Medication',
    Icons.assignment
  ),
  'adherences' : (
    'No Logs to Show',
    'When an assigned medication has been active, adherence logs will appear here.',
    null,
    Icons.folder
  ),
};

Map<String, (String, String, String?, IconData)> memberActions = {
  'dashboard' : (
    'No Information to Show.',
    'When taking active medications, they\'ll appear here.',
    null,
    Icons.people
  ),
  'family' : (
    'No Family to Show',
    'View your family\'s information here.',
    null,
    Icons.diversity_1
  ),
  'assignments' : (
    'No Medications to Show',
    'When your caregiver assigns you a medication, they\'ll appear here.',
    null,
    Icons.assignment
  ),
  'adherences' : (
    'No Logs to Show',
    'When this medication has been active, adherence logs will appear here.',
    null,
    Icons.folder
  ),
};

class ErrorCard extends StatelessWidget {
  const ErrorCard({super.key, required this.message, this.action});

  final String message;
  final VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.errorContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.errorContainer),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline, color: cs.error, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: TextStyle(fontSize: 13, color: cs.error),
            ),
          ),
        ],
      ),
          IconButton(onPressed: action, icon: Icon(Icons.sync, color: cs.error))
        ]
      )
    );
  }
}

class ErrorBody extends StatelessWidget {
  const ErrorBody({super.key, required this.callback});

  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
          SizedBox.square(
            dimension: 75,
            child: Icon(
              Icons.error_outline_rounded,
              color: cs.outline,
              size: 75,
            ),
          ),
          Text(
            'Request',
            textAlign: TextAlign.center,
            style: TextTheme.of(context).headlineMedium?.copyWith(
              color: cs.outline,
              height: 1.5,
            ),
          ),
          Text(
            'We couldn\'t load this right now. Please try again.',
            textAlign: TextAlign.center,
            style: TextTheme.of(context).bodyLarge?.copyWith(
              color: cs.outline,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
          TextButton.icon(
            onPressed: callback,
            icon: Icon(Icons.refresh_rounded, color: cs.onInverseSurface),
            label: Text(
              'Retry',
              style: TextTheme.of(context).bodyLarge?.copyWith(
                color: cs.onInverseSurface,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(cs.primary),
            ),
          )
        ],
      ),
    );
  }
}

class EmptyCard extends StatelessWidget {
  const EmptyCard({super.key, required this.message, this.icon});

  final String message;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        children: [
          Icon(
            icon ?? Icons.inbox_outlined,
            color: cs.outline,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: cs.outline),
          ),
        ],
      ),
    );
  }
}

class EmptyBody extends StatelessWidget {
  const EmptyBody({
    super.key,
    required this.type,
    required this.role,
    this.redirect,
    this.refresh
  });

  final String type;
  final UserRole role;
  final VoidCallback? redirect;
  final VoidCallback? refresh;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final (String title, String subtitle, String? label, IconData icon) = switch(role){
      UserRole.caregiver => caregiverActions[type] as (String, String, String?, IconData),
      _ => memberActions[type] as (String, String, String?, IconData)
    };

    return RefreshIndicator(
      onRefresh: () async => redirect,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    pageIcon(cs, icon),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: tt.headlineMedium?.copyWith(
                        color: cs.outline,
                        height: 1.5,
                      ),
                    ),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: tt.bodyLarge?.copyWith(
                        color: cs.outline,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                    ),
                    if (redirect != null && label != null) pageButton(cs, tt, label),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget pageIcon(ColorScheme cs, IconData icon) {
    return SizedBox.square(
      dimension: 75,
      child: Icon(
        icon,
        color: cs.outline,
        size: 75,
      ),
    );
  }
  Widget pageButton(ColorScheme cs, TextTheme tt, String label){
    return Padding(
      padding:EdgeInsets.all(16),
      child: FilledButton(
        onPressed: () => redirect,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(cs.primary),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: tt.titleMedium?.copyWith(color: cs.surface, height: 1.5, fontWeight: FontWeight.w500)
        ),
      )
    );
  }
}

class LoadingCard extends StatelessWidget {
  const LoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class LoadingBody extends StatelessWidget {
  const LoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class TemplateStatePage extends StatelessWidget {
  const TemplateStatePage({
    super.key,
    required this.body,
    this.leading,
    this.title,
    this.bottom
  });

  final Widget body;
  final Widget? leading;
  final Text? title;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {

    return Scaffold (
      appBar: AppBar(
        leading: leading,
        flexibleSpace: Container(decoration: BoxDecoration(gradient: context.palette.header)),
        title: title,
        bottom: bottom
      ),
      body: body
    );
  }
}
