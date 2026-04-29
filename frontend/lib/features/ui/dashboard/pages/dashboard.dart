import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/app_gradient_header.dart';
import 'package:frontend/features/components/shared/side_drawer.dart';
import 'package:frontend/features/components/shared/state_widget.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/features/ui/dashboard/widgets/caregiver_section.dart';
import 'package:frontend/features/ui/dashboard/widgets/dashboard_header.dart';
import 'package:frontend/features/ui/dashboard/widgets/member_section.dart';
import 'package:frontend/models/models.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('DashboardView build');
    final role = ref.watch(userRoleProvider);
    if (role == UserRole.caregiver) {
      return CaregiverDashboardView();
    } else {
      return MemberDashboardView();
    }
  }
}

class CaregiverDashboardView extends ConsumerWidget {
  const CaregiverDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final fidAsync = ref.watch(currentFamilyProvider);

    final fid = switch (fidAsync) {
      AsyncData(:final value) when value.isNotEmpty => value,
      _ => null,
    };

    if (fid == null) {
      return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (context) => HeaderIconButton(
              icon: Icons.menu,
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          flexibleSpace: Container(decoration: BoxDecoration(gradient: context.palette.header)),
        ),
        drawer: const SideDrawer(),
        body: const LoadingBody()
      );
    }

    final membersAsync = ref.watch(aggregateMembershipsProvider(fid));
    switch (membersAsync) {
      case AsyncLoading<List<Member>>(): {
        return Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (context) => HeaderIconButton(
                icon: Icons.menu,
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            flexibleSpace: Container(decoration: BoxDecoration(gradient: context.palette.header)),
          ),
          drawer: const SideDrawer(),
          body: const LoadingBody()
        );
      }
      case AsyncError<List<Member>>(): {
        return Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (context) => HeaderIconButton(
                icon: Icons.menu,
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            flexibleSpace: Container(decoration: BoxDecoration(gradient: context.palette.header)),
          ),
          drawer: const SideDrawer(),
          body: RefreshIndicator(
            onRefresh: () => ref.refresh(aggregateMembershipsProvider(fid).future),
            child: ErrorBody()
          ),
        );
      }
      case AsyncData<List<Member>>(:final value): {
        if (value.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              leading: Builder(
                builder: (context) => HeaderIconButton(
                  icon: Icons.menu,
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              flexibleSpace: Container(decoration: BoxDecoration(gradient: context.palette.header)),
            ),
            drawer: const SideDrawer(),
            body: RefreshIndicator(
              onRefresh: () => ref.refresh(aggregateMembershipsProvider(fid).future),
              child: EmptyBody()
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (context) => HeaderIconButton(
                icon: Icons.menu,
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            flexibleSpace: Container(decoration: BoxDecoration(gradient: context.palette.header)),
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, 150),
              child: CaregiverDashboardHeader()
            ),
            scrolledUnderElevation: 5.0
          ),
          drawer: const SideDrawer(),
          body: RefreshIndicator(
            onRefresh: () => ref.refresh(aggregateMembershipsProvider(fid).future),
            child: CaregiverDashboardSection(members: value)
          ),
        );
      }
    }
  }
}

class MemberDashboardView extends ConsumerWidget {
  const MemberDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final currentUser = ref.watch(currentUserProvider);
    final membersLoading = ref.watch(currentMembersProvider.select((m) => m.isLoading));
    final membership = ref.watch(currentMembersProvider
      .select((m) => m.value?.values
      .firstWhereOrNull((v) => v.uid == currentUser?.id)
    ));

    if (currentUser == null || membersLoading) {
      return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(decoration: BoxDecoration(gradient: context.palette.header)),
        ),
        body: const LoadingBody()
      );
    }

    if (membership == null) {
      return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(decoration: BoxDecoration(gradient: context.palette.header)),
        ),
        body: const EmptyBody()
      );
    }

    final membersAsync = ref.watch(aggregateMemberProvider(membership.id));

    switch (membersAsync) {
      case AsyncLoading<Member>(): {
        return Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(decoration: BoxDecoration(gradient: context.palette.header)),
          ),
          body: const LoadingBody()
        );
      }
      case AsyncError<Member>(): {
        return Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(decoration: BoxDecoration(gradient: context.palette.header)),
          ),
          body: RefreshIndicator(
            onRefresh: () => ref.refresh(aggregateMemberProvider(membership.id).future),
            child: ErrorBody()
          ),
        );
      }
      case AsyncData<Member>(:final value): {
        return Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(decoration: BoxDecoration(gradient: context.palette.header)),
            scrolledUnderElevation: 5.0
          ),
          body: RefreshIndicator(
            onRefresh: () => ref.refresh(aggregateMemberProvider(membership.id).future),
            child: MemberDashboardSection(member: value)
          ),
        );
      }
    }
  }
}
