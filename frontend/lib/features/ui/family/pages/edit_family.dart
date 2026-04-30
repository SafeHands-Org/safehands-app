import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/form_section.dart';
import 'package:frontend/features/components/shared/section_header.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/providers/family/family_providers.dart';
import 'package:frontend/features/providers/providers.dart';
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
    ref.listenManual(familiesProvider,
      (previous, next) {
        if (previous is! AsyncLoading) return;
        next.whenOrNull(
          data: (_) {
            if (mounted) {
              ref.invalidate(familiesProvider);
              ref.invalidate(aggregateMembershipsProvider);
              ref.invalidate(aggregateMemberProvider);
            }
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
      }
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  void _delete() async {
    await ref.read(familiesProvider.notifier).deleteFamily(fid: widget.fid);
    ref.invalidate(familiesProvider);
    ref.invalidate(aggregateMembershipsProvider);
    ref.invalidate(aggregateMemberProvider);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Deleted Family'),
        duration: Duration(milliseconds: 800),
      ),
    );
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      context.canPop() ? context.pop() : context.go('/');
    });
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
          content: Text('Updated Family'),
          duration: Duration(milliseconds: 800),
        ),
      );
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!mounted) return;
        context.canPop() ? context.pop() : context.go('/family');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: cs.onInverseSurface,
          onPressed: () => context.canPop() ? context.pop() : context.go('/family')
        ),
        flexibleSpace: Container(decoration: BoxDecoration(gradient: context.palette.header)),
        title: Text(
          'Edit Information',
          style: tt.titleMedium?.copyWith(color: cs.onInverseSurface),
          textAlign: TextAlign.center
        )
      ),
      body: Container(
        decoration: BoxDecoration(gradient: context.palette.page),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SectionHeader(title: 'Edit Details'),
                  Card(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(5, 16, 5, 16),
                      child: Column(
                        children: [
                          FormSection(
                            title: 'Family Name',
                            child: EditableFormField(
                              ctrl: _nameCtrl,
                              validators: (v) => (v == null || v.trim().isEmpty) ? 'Please enter a name' : null,
                              hintText: 'Enter family name',
                            )
                          ),
                          const SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.only(left:16, right: 16),
                            child: FormButton(
                              label: 'Confirm',
                              weight: FontWeight.w500,
                              radius: AppRadius.borderRadiusXl,
                              onPressed: _update
                            ),
                          ),
                        ],
                      )
                    )
                  ),
                  const SizedBox(height: 24),
                  FormButton(
                    label: 'Delete Family',
                    onPressed: () => _showDialog(context),
                    weight: FontWeight.w500,
                    radius: AppRadius.borderRadiusXl,
                    buttonColor: cs.errorContainer,
                    borderColor: cs.error,
                    textColor: cs.error,
                  ),
                ],
              ),
            ),
          )
        )
      ),
    );
  }
  void _showDialog(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    if (isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
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
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Are you sure?'),
          actions: [
            TextButton(
              onPressed: () => {},
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => _delete(),
              child: const Text('Confirm'),
            ),
          ],
        ),
      );
    }
  }
}
