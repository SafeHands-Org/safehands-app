import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/form_section.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/providers/family/family_providers.dart';
import 'package:frontend/features/ui/auth/widgets/form_buttons.dart';
import 'package:frontend/utils/exceptions.dart';
import 'package:go_router/go_router.dart';

class EditFamilyView extends ConsumerStatefulWidget {
  const EditFamilyView({
    super.key,
    required this.fid,
    required this.familyName,
  });

  final String fid;
  final String familyName;

  @override
  ConsumerState<EditFamilyView> createState() => _EditFamilyViewState();
}

class _EditFamilyViewState extends ConsumerState<EditFamilyView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;

  @override
  void initState() {
    super.initState();

    _nameCtrl = TextEditingController(text: widget.familyName);
    ref.listenManual(familiesProvider, (previous, next) {
      next.whenOrNull(
        data: (_) {
          if (mounted) context.go('/');
        },
        error: (error, stackTrace) {
          if (!mounted) return;
          final message = switch (error) {
            NotFoundException() => 'Family not found.',
            ServerException() => 'Request timed out. Try again.',
            _ => 'Something went wrong. Please try again.',
          };
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Color(0xFFB62320),
            ),
          );
        },
      );
    });
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  void _delete() async {
    await ref.read(familiesProvider.notifier).deleteFamily(fid: widget.fid);
    context.go('/');
  }

  void _update() async {
    if (_formKey.currentState!.validate()) {
      final nextName = _nameCtrl.text.trim();
      final currentName = widget.familyName.trim();

      if (nextName == currentName) {
        context.pop();
        return;
      }

      await ref
          .read(familiesProvider.notifier)
          .updateFamily(fid: widget.fid, data: _nameCtrl.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully updated family information'),
        ),
      );
      context.canPop() ? context.pop() : context.go('/family');
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.base),
      child: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: SizedBox(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    FormSection(
                      title: 'Family Name',
                      child: EditableFormField(
                        ctrl: _nameCtrl,
                        validators: (v) => (v == null || v.trim().isEmpty) ? 'Please enter a name' : null,
                        hintText: 'Enter family name',
                      )
                    ),
                    const SizedBox(height: 50),
                    FormButton(
                      label: 'Update Family Information',
                      weight: FontWeight.w400,
                      radius: AppRadius.borderRadiusXl,
                      onPressed: _update,
                    ),
                    const SizedBox(height: 18),
                    FormButton(
                      label: 'Delete Family',
                      onPressed: () => _showDialog(context),
                      weight: FontWeight.w400,
                      radius: AppRadius.borderRadiusXl,
                      buttonColor: cs.errorContainer,
                      borderColor: cs.error,
                      textColor: cs.error,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _showDialog(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    if (isIOS) {
      CupertinoAlertDialog(
        title: const Text('Are you sure?'),
        actions: [
          CupertinoDialogAction(
            onPressed: () => {},
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            onPressed: () => _delete(),
            child: const Text('Confirm'),
          ),
        ],
      );
    }
    else {
      AlertDialog(
        title: const Text('Are you sure?'),
        actions: [
          TextButton(
            onPressed: (){},
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => _delete(),
            child: const Text('Confirm'),
          ),
        ],
      );
    }
  }
}
