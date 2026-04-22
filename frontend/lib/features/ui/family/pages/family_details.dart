import 'package:flutter/material.dart';
import 'package:frontend/features/components/shared/primary_action_button.dart';
import 'package:frontend/features/components/shared/section_header.dart';
import 'package:frontend/features/ui/family/widgets/family_section.dart';
import 'package:frontend/features/ui/family/widgets/family_headers.dart';
import 'package:frontend/features/ui/family/widgets/overview_settings.dart';
import 'package:go_router/go_router.dart';

class FamilyView extends StatelessWidget {
  const FamilyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FamilyOverviewHeaderWrapper(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryActionButton(
                    onPressed: () => context.go('/family/invite'),
                    buttonText: 'Invite',
                    buttonIcon: const Icon(Icons.person_add_outlined, color: Colors.white),
                  ),
                  const SizedBox(height: 24),
                  const SectionHeader(title: 'Family Members'),
                  const FamilyMembersDetailSection(),
                  const SizedBox(height: 12),
                  const SectionHeader(title: 'Family Management'),
                  const FamilyOverviewSettings(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}