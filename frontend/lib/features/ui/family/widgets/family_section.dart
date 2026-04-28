import 'package:flutter/material.dart';
import 'package:frontend/features/components/shared/avatar_profile.dart';
import 'package:frontend/features/components/shared/primary_action_button.dart';
import 'package:frontend/features/components/shared/section_header.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/ui/family/pages/edit_family.dart';
import 'package:frontend/features/ui/family/widgets/family_headers.dart';
import 'package:frontend/features/ui/family/widgets/overview_settings.dart';
import 'package:frontend/models/models.dart';
import 'package:go_router/go_router.dart';

class FamilyMembersDetailSection extends StatelessWidget {
  const FamilyMembersDetailSection({
    super.key,
    required this.members,
    required this.family
  });

  final List<Member> members;
  final Family family;

  @override
  Widget build(BuildContext context) {
    final List<Member> admins = members.where((e) => e.isAdmin).toList();
    final List<Member> nonAdmins = members.where((e) => e.isAdmin == false).toList();

    return Scaffold(
      body: Column(
        children: [
          if (family.isNotEmpty)...[
            Container(
              decoration: BoxDecoration(gradient: context.palette.page),
              child: FamilyOverviewHeader(),
            ),
          ],
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Column(
                    children: [
                      if (members.isEmpty)...[
                        Center(
                          child: Text('No Members yet')
                        )
                      ]
                      else...[
                        PrimaryActionButton(
                          onPressed: () => _showAddSheet(context, family.id, family.name),
                          buttonText: 'Invite',
                          buttonIcon: const Icon(
                            Icons.person_add_outlined,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24),
                        if (admins.isNotEmpty)...[
                          const SectionHeader(title: 'Administrators'),
                          Card(
                            child: SizedBox(
                              width: double.infinity,
                              height: 305,
                              child: _buildList(admins)
                            ),
                          ),
                        ],
                        const SizedBox(height: 24),
                        if (nonAdmins.isNotEmpty)...[
                          const SectionHeader(title: 'Members'),
                          Card(
                            child: SizedBox(
                              width: double.infinity,
                              height: 305,
                              child: _buildList(nonAdmins),
                            ),
                          ),
                        ],
                        const SizedBox(height: 24),
                        const SectionHeader(title: 'Family Management'),
                        const SizedBox(height: 24),
                        const SectionHeader(title: 'Family Management'),
                        const FamilyOverviewSettings(),
                      ]
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildList(List<Member> members){
    return ListView.separated(
        padding: EdgeInsets.only(top: 16),
        itemCount: members.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (context, index) {
        return _FamilyMemberSlot(member: members[index]);
      }
    );
  }
}
void _showAddSheet(BuildContext context, String fid, String familyName) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (_) => DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.45,
      maxChildSize: 0.55,
      expand: false,
      builder: (_, scrollController) => EditFamilyView(fid: fid, familyName: familyName)
    ),
  );
}


class _FamilyMemberSlot extends StatelessWidget {
  const _FamilyMemberSlot({required this.member});
  final Member member;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return ListTile(
      contentPadding: EdgeInsets.only(left: 16, right: 16),
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.borderRadiusCard
      ),
      leading: UserAvatar(name: member.name, radius: 28),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(member.name, style: tt.bodyLarge!.copyWith(fontWeight: FontWeight.w700)),
          Text("Since ${member.joinDate}", style: tt.labelSmall),
        ],
      ),
      trailing: IconButton(
        onPressed: () => context.push('/family/members/${member.id}'),
        icon: Icon(Icons.chevron_right, size: 20),
      ),
    );
  }
}

