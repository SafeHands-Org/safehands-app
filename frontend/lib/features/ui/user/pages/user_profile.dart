import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/avatar_profile.dart';
import 'package:frontend/features/components/shared/section_header.dart';
import 'package:frontend/features/components/shared/state_widget.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/models/models.dart';
import 'package:go_router/go_router.dart';

class UserProfileView extends ConsumerWidget{
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(userRoleProvider);

    if (role == UserRole.caregiver) {
      return CaregiverAccountView();
    } else {
      return MemberAccountView();
    }
  }
}

class CaregiverAccountView extends ConsumerWidget {
  const CaregiverAccountView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final currentFamily = ref.watch(currentFamilyObjectProvider);
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(decoration: BoxDecoration(gradient: context.palette.header)),
        title: Text(
          'My Account',
          style: tt.titleMedium?.copyWith(color: cs.onInverseSurface),
          textAlign: TextAlign.center,
        ),
        toolbarHeight: 70,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 70),
          child: PreferredSize(
          preferredSize: Size(double.infinity, 70),
          child: Container(
            padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  UserAvatar(radius: 40),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(currentUser?.name ?? '---',
                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                      Text(currentUser?.namedRole ?? '---',
                        style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),)
                    ],
                  ),
                ],
              ),
            )
          )
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Center(
            child: switch(currentFamily){
              AsyncLoading() => CircularProgressIndicator(),
              AsyncError(:final stackTrace) => ErrorCard(message: stackTrace.toString(), action: () => ref.invalidate(currentFamilyObjectProvider)),
              AsyncData(:final value?) => Column(
                children: [
                  if (value.isEmpty)...[
                    SizedBox.shrink()
                  ] else...[
                    SectionHeader(title: 'Familiy Groups'),
                    Card(
                      child: SizedBox(
                        width: double.infinity,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: AppRadius.borderRadiusCard
                          ),
                          leading: FamilyAvatar(radius: 28),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(value.name, style: tt.bodyLarge!.copyWith(fontWeight: FontWeight.w700)),
                              Text("Created ${value.ageLabel}", style: tt.labelSmall),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () => context.go('/family'),
                            icon: Icon(Icons.chevron_right, size: 20),
                          ),
                        ),
                      ),
                    ),
                  ]
                ]
              ),
              AsyncData<Family?>(value: null) => Text(''),
            }
          )
        )
    );
  }
}

class MemberAccountView extends ConsumerWidget {
  const MemberAccountView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final currentFamily = ref.watch(currentFamilyObjectProvider);
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(decoration: BoxDecoration(gradient: context.palette.header)),
        scrolledUnderElevation: 5.0,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 70),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                UserAvatar(radius: 40),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentUser?.name ?? '---',
                      style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),),
                    Text(
                      currentUser?.namedRole ?? '---',
                      style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),)
                  ],
                ),
              ],
            ),
          )
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Center(
          child: switch(currentFamily){
            AsyncLoading() => CircularProgressIndicator(),
            AsyncError() => ErrorCard(message: 'Could not load data', action: () => ref.invalidate(currentFamilyObjectProvider)),
            AsyncData(:final value?) => Column(
              children: [
                SectionHeader(title: 'Familiy Groups'),
                Card(
                  child: SizedBox(
                    width: double.infinity,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.borderRadiusCard
                      ),
                      leading: FamilyAvatar(radius: 28),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(value.name, style: tt.bodyLarge!.copyWith(fontWeight: FontWeight.w700)),
                          Text("Created ${value.ageLabel}", style: tt.labelSmall),
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton.icon(
                      onPressed: () async {
                        final auth = ref.read(authProvider.notifier);
                        final container = ProviderScope.containerOf(context);
                        final familyRepo = ref.read(familyRepositoryProvider);
                        final invitationRepo = ref.read(invitationRepositoryProvider);
                        final familyMemberRepo = ref.read(familyMemberRepositoryProvider);
                        final assignmentRepo = ref.read(assignmentRepositoryProvider);
                        final medicationRepo = ref.read(medicationRepositoryProvider);
                        final scheduleRepo = ref.read(scheduleRepositoryProvider);
                        final adherenceRepo = ref.read(adherenceRepositoryProvider);

                        await auth.logout();

                        familyRepo.clearCurrentFamily();
                        familyRepo.clearCache();
                        invitationRepo.clearInviteToken();
                        invitationRepo.clearCache();
                        familyMemberRepo.clearCache();
                        assignmentRepo.clearCache();
                        medicationRepo.clearCache();
                        scheduleRepo.clearCache();
                        adherenceRepo.clearCache();

                        container.invalidate(familiesProvider);
                        container.invalidate(invitationsProvider);
                        container.invalidate(familyMembersProvider);
                        container.invalidate(assignmentsProvider);
                        container.invalidate(medicationsProvider);
                        container.invalidate(schedulesProvider);
                        container.invalidate(adherencesProvider);

                        print('Finished Logging out');

                        if (context.mounted) context.go('/login');
                      },
                      icon: Icon(Icons.logout, color: cs.error),
                      label: Text(
                        'Log Out',
                        style: TextStyle(color: cs.error, fontWeight: FontWeight.w600),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: cs.errorContainer,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: cs.error)
                        ),
                      ),
                    ),
                  ),
                ),
              ]
            ),
            AsyncData(value: null) => EmptyCard(message: 'No Family to Show'),
          }
        )
      )
    );
  }
}