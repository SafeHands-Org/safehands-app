import 'package:flutter/material.dart';
import 'package:frontend/features/components/shared/primary_action_button.dart';
import 'package:frontend/features/components/styles/styles.dart';

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
  const ErrorBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
          Icon(
            Icons.error_outline,
            color: cs.error,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            'Something went wrong. Please try again later.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: cs.error),
          ),
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
  const EmptyBody({super.key, this.action, this.callback});

  final PrimaryActionButton? action;
  final VoidCallback? callback;
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.image,
            color: cs.outline,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            'Nothing here yet.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: cs.outline, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 24),
          if (action != null) Padding(padding: EdgeInsetsGeometry.only(left: 50, right: 50), child: action)
        ],
      ),
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
