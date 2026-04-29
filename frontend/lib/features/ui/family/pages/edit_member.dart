import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/form_section.dart';
import 'package:frontend/features/components/shared/section_header.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/features/ui/auth/widgets/form_buttons.dart';
import 'package:frontend/services/api/models/family/family_api_requests.dart';
import 'package:frontend/utils/exceptions.dart';
import 'package:go_router/go_router.dart';

class EditMemberView extends ConsumerStatefulWidget {
  const EditMemberView({
    super.key,
    required this.fmid,
    required this.fid
  });

  final String fmid;
  final String fid;


  @override
  ConsumerState<EditMemberView> createState() => _EditMemberViewState();
}

class _EditMemberViewState extends ConsumerState<EditMemberView> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedRisk;

  @override
  void initState(){
    super.initState();
    debugPrint(_selectedRisk);

    ref.listenManual(familyMembersProvider,
      (previous, next) {
        if (previous is! AsyncLoading) return;
        next.whenOrNull(
          data: (_) {
            if (mounted) {
              ref.invalidate(familyMembersProvider);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Success!'), backgroundColor: Color(0xFF198820)),
              );
              context.canPop() ? context.pop() : context.go('/family/members/${widget.fmid}');
            }
          },
          error:(error, stackTrace) {
            if (!mounted) return;
            final message = switch (error) {
              NotFoundException() => 'Family Member not found.',
              ServerException() => 'Request timed out. Try again.',
              _ => 'Something went wrong. Please try again.',
            };
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message), backgroundColor: Color(0xFFB62320)),
            );
          }
        );
      }
    );
  }

  void _delete() async {
    await ref.read(familyMembersProvider.notifier).removeFamilyMember(
      widget.fmid
    );
    context.go('/family');
  }

  void _update() async {
    if (_formKey.currentState!.validate()){
      final nextRiskLevel = _selectedRisk?.trim();
      await ref.read(familyMembersProvider.notifier).updateFamilyMember(
        widget.fmid,
        FamilyMemberUpdate(riskLevel: nextRiskLevel)
      );
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
          onPressed: () => context.canPop() ? context.pop() : context.go('/family/members/${widget.fmid}')
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
                          FormSection(title: 'Risk Level',
                            child: EditableDropdownField(
                              value: _selectedRisk,
                              hintText: 'Select role',
                              items: const ['Low', 'Medium', 'High'],
                              validator: (v) => v == null ? 'Please select a level' : null,
                              onChanged: (v) {
                                setState(() => _selectedRisk = v);
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.only(left:16, right: 16),
                            child: FormButton(
                              label: 'Confirm',
                              weight: FontWeight.w400,
                              radius: AppRadius.borderRadiusXl,
                              onPressed: _update
                            ),
                          ),
                        ],
                      )
                    )
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(left:16, right: 16),
                    child: FormButton(
                      label: 'Remove Family Member',
                      onPressed: () => _showDialog(context),
                      weight: FontWeight.w400,
                      radius: AppRadius.borderRadiusXl,
                      buttonColor: cs.errorContainer,
                      borderColor: cs.error,
                      textColor: cs.error,
                    ),
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
