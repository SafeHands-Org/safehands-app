import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/styles/app_color.dart';
import 'package:frontend/features/ui/dashboard/widgets/family_member_card.dart';
import 'package:frontend/features/ui/dashboard/widgets/medication_card.dart';
import 'package:frontend/models/collections/collections.dart';

class CaregiverDashboardSection extends ConsumerWidget {
  const CaregiverDashboardSection({super.key, required this.members});

  final List<Member> members;

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(gradient: context.palette.page),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FamilyMemberList(members: members),
              SizedBox(height: 6),
              Divider(thickness: 1),
              SizedBox(height: 6),
              CaregiverMedicationCardList(members: members),
              const SizedBox(height: 12),
            ],
          ),
        ),
      )
    );
  }
}