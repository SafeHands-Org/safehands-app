import 'package:flutter/material.dart';
import 'package:frontend/features/components/shared/avatar_profile.dart';
import 'package:frontend/features/components/shared/primary_action_button.dart';
import 'package:frontend/features/components/shared/section_header.dart';
import 'package:frontend/features/components/shared/state_widget.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/ui/family/pages/family_invite.dart';
import 'package:frontend/models/models.dart';
import 'package:go_router/go_router.dart';

class FamilyMembersDetailSection extends StatelessWidget {
  const FamilyMembersDetailSection({
    super.key,
    required this.members,
    required this.family,
  });

  final List<Member> members;
  final Family family;

  @override
  Widget build(BuildContext context) {
    final List<Member> admins = members.where((e) => e.isAdmin).toList();
    final List<Member> nonAdmins = members
        .where((e) => e.isAdmin == false)
        .toList();

    return Scaffold(
      appBar:  AppBar(
        flexibleSpace: Container(decoration: BoxDecoration(gradient: context.palette.header)),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 16),
            constraints: BoxConstraints(),
            icon: Icon(Icons.person_add, color: ColorScheme.of(context).onInverseSurface),
            onPressed: () => _showAddSheet(context),
          ),
          IconButton(
            padding: EdgeInsets.only(right: 16),
            constraints: BoxConstraints(),
            icon: Icon(Icons.settings, color: ColorScheme.of(context).onInverseSurface),
            onPressed: () => context.push('/family/edit/${family.id}/${family.name}'),
          ),
        ],
        toolbarHeight: 70,
        scrolledUnderElevation: 5.0,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 70),
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                FamilyAvatar(radius: 40),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      family.name,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (members.isNotEmpty)...[
                          AvatarStack(names: [...members.map((v) => v.name)]),
                        ],
                        Text(
                          "${members.length} members",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: members.isEmpty
      ? EmptyBody(type: 'members', role: UserRole.caregiver)
      : ListView(
          padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
          children: [
            Column(
              children: [
                SizedBox(height: 12),
                PrimaryActionButton(
                  onPressed: () => context.go('/assignment/create'),
                  buttonText: 'Assign Medication',
                  buttonIcon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  borderRadiusGeometry: AppRadius.borderRadiusMd
                ),
                if (admins.isNotEmpty) ...[
                  const SectionHeader(title: 'Administrators'),
                  Card(
                    child: SizedBox(
                      width: double.infinity,
                      child: _buildList(admins),
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                if (nonAdmins.isNotEmpty) ...[
                  const SectionHeader(title: 'Members'),
                  Card(
                    child: SizedBox(
                      width: double.infinity,
                      child: _buildList(nonAdmins),
                    ),
                  ),
                ],
              ],
            )
          ]
        ),
    );
  }
  Widget _buildList(List<Member> members) {
   return Column(
    children: [
      SizedBox(height: 8),
      for (final (index, member) in members.indexed) ...[
        Padding(
          padding: EdgeInsetsGeometry.symmetric(vertical: 8),
          child: _FamilyMemberSlot(member: member),
        ),
        if (index < members.length - 1)
          Divider(thickness: 1),
      ],
      SizedBox(height: 8)
    ]
   );
  }
}

void _showAddSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: AppRadius.card,
        topRight: AppRadius.card,
      ),
    ),
    backgroundColor: context.palette.categoryBlue,
    builder: (_) => DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.35,
      maxChildSize: 0.45,
      expand: false,
      builder: (_, scrollController) => InviteView(),
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

class _MemberFamilySlot extends StatelessWidget {
  const _MemberFamilySlot({required this.member});
  final Member member;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return ListTile(
      contentPadding: EdgeInsets.only(left: 16, right: 16),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusCard),
      leading: Container(
        width: 28 * 2,
        height: 28 * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: ColorScheme.of(context).secondary,
            width: 1,
          ),
        ),
        child: UserAvatar(name: member.name, radius: 28),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            member.name,
            style: tt.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
          ),
          Text("Since ${member.joinDate}", style: tt.labelSmall),
        ],
      ),
    );
  }
}

class MembersFamilyDetailSection extends StatelessWidget {
  const MembersFamilyDetailSection({
    super.key,
    required this.members,
    required this.family,
  });

  final List<Member> members;
  final Family family;

  @override
  Widget build(BuildContext context) {
    final List<Member> admins = members.where((e) => e.isAdmin).toList();
    final List<Member> nonAdmins = members
        .where((e) => e.isAdmin == false)
        .toList();

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: context.palette.header),
        ),
        scrolledUnderElevation: 5.0,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 70),
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                FamilyAvatar(radius: 40),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      family.name,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AvatarStack(names: [...members.map((v) => v.name)]),
                        Text(
                          "${members.length} members",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          Column(
            children: [
              if (admins.isNotEmpty) ...[
                const SectionHeader(title: 'Administrators'),
                Card(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: admins
                          .map((admin) => _MemberFamilySlot(member: admin))
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
              if (nonAdmins.isNotEmpty) ...[
                const SectionHeader(title: 'Family Members'),
                Card(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(height: 8),
                        for (final (index, member) in nonAdmins.indexed) ...[
                          Padding(
                            padding: EdgeInsetsGeometry.symmetric(vertical: 8),
                            child: _MemberFamilySlot(member: member),
                          ),
                          if (index < nonAdmins.length - 1)
                            Divider(thickness: 1),
                        ],
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
