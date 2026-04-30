import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/form_section.dart';
import 'package:frontend/features/components/shared/section_header.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/providers/family/family_providers.dart';
import 'package:frontend/features/providers/utils/collection_providers.dart';
import 'package:frontend/features/ui/auth/widgets/form_buttons.dart';
import 'package:frontend/utils/exceptions.dart';
import 'package:go_router/go_router.dart';

class FamilyFormView extends ConsumerStatefulWidget {
  const FamilyFormView({super.key});

  @override
  ConsumerState<FamilyFormView> createState() => _FamilyFormViewState();
}

class _FamilyFormViewState extends ConsumerState<FamilyFormView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

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

  void _create() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(familiesProvider.notifier)
        .createFamily(data: _nameCtrl.text.trim()
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Updated Family'),
          duration: Duration(milliseconds: 800),
        ),
      );
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!mounted) return;
        context.canPop() ? context.pop() : context.go('/');
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
          'New Family',
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
                  SectionHeader(title: 'Family Details'),
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
                              weight: FontWeight.w400,
                              radius: AppRadius.borderRadiusXl,
                              onPressed: _create
                            ),
                          ),
                        ],
                      )
                    )
                  ),
                ],
              ),
            ),
          )
        )
      ),
    );
  }
}
