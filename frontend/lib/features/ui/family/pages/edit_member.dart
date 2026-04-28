import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/form_section.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/features/ui/auth/widgets/form_buttons.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/services/api/models/family/family_api_requests.dart';
import 'package:frontend/utils/exceptions.dart';
import 'package:go_router/go_router.dart';

class EditMemberView extends ConsumerStatefulWidget {
  const EditMemberView({super.key, required this.member});

  final Member member;

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
    (previous, next) {next.whenOrNull(
        data: (_) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Successfully updated family information'), backgroundColor: Color(0xFF20B62A)),
            );
            context.canPop() ? context.pop() : context.go('/family/members/${widget.member.id}');
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
    });
  }

  void _delete() async {
    await ref.read(familyMembersProvider.notifier).removeFamilyMember(
      widget.member.family.id,
      widget.member.id
    );
    context.go('/family');
  }

  void _update() async {
    if (_formKey.currentState!.validate()){
      final nextRiskLevel = _selectedRisk?.trim();
      final currentRiskLevel = widget.member.riskLevel.trim();

      if (nextRiskLevel == currentRiskLevel) {
        context.pop();
        return;
      }

      await ref.read(familyMembersProvider.notifier).updateFamilyMember(
        widget.member.family.id,
        widget.member.id,
        FamilyMemberUpdate(riskLevel: nextRiskLevel)
      );
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
                    const SizedBox(height: 50),
                    FormButton(
                      label: 'Update Member Information',
                      weight: FontWeight.w400,
                      radius: AppRadius.borderRadiusXl,
                      onPressed: _update
                    ),
                    const SizedBox(height: 18),
                    FormButton(
                      label: 'Remove Family Member',
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
