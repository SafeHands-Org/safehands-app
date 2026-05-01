import 'package:flutter/material.dart';
import 'package:frontend/features/components/shared/shell_page.dart';
import 'package:frontend/features/providers/auth/auth_provider.dart';
import 'package:frontend/features/ui/adherences/pages/adherence_overview.dart';
import 'package:frontend/features/ui/assignments/pages/assignment_form.dart';
import 'package:frontend/features/ui/assignments/pages/edit_assignment.dart';
import 'package:frontend/features/ui/auth/pages/login.dart';
import 'package:frontend/features/ui/auth/pages/register.dart';
import 'package:frontend/features/ui/auth/pages/startup.dart';
import 'package:frontend/features/ui/dashboard/pages/dashboard.dart';
import 'package:frontend/features/ui/family/pages/edit_family.dart';
import 'package:frontend/features/ui/family/pages/edit_member.dart';
import 'package:frontend/features/ui/family/pages/family_details.dart';
import 'package:frontend/features/ui/family/pages/family_form.dart';
import 'package:frontend/features/ui/family/pages/member_details.dart';
import 'package:frontend/features/ui/medications/pages/edit_medication.dart';
import 'package:frontend/features/ui/medications/pages/medication_form.dart';
import 'package:frontend/features/ui/medications/pages/medication_overview.dart';
import 'package:frontend/features/ui/user/pages/user_profile.dart';
import 'package:frontend/models/medications/family_member_medication.dart';
import 'package:frontend/models/medications/medication.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter router(Ref ref) => GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  refreshListenable: RouterRefreshNotifier(ref),
  redirect: (context, state) {
    bool isLoggedIn = ref.watch(isLoggedInProvider);
    final onAuthRoute = state.matchedLocation.startsWith('/auth');
    if (!isLoggedIn && !onAuthRoute) return '/auth';
    if (isLoggedIn && onAuthRoute) return '/dashboard';
    return null;
  },
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          ShellView(child: navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => DashboardView(),
          )
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/family',
            builder: (context, state) => FamilyView(),
          )
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/profile',
            builder: (context, state) => UserProfileView(),
          )
        ]),
      ],
    ),
    GoRoute(
      path: '/',
      redirect: (context, state) => '/dashboard',
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => StartupView(),
      routes: [
        GoRoute(
          path: 'login',
          builder: (context, state) => const LoginView(),
        ),
        GoRoute(
          path: 'register',
          builder: (context, state) => const RegistrationView(),
        ),
      ],
    ),
    GoRoute(
      path: '/family/members/:fmId',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) =>
          MemberView(fmid: state.pathParameters['fmId']!),
    ),
    GoRoute(
      path: '/family/members/:fmId/:fid',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => EditMemberView(
        fmid: state.pathParameters['fmId']!,
        fid: state.pathParameters['fid']!,
      ),
    ),
    GoRoute(
      path: '/family/create',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => FamilyFormView()
    ),
    GoRoute(
      path: '/family/edit/:fid/:name',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => EditFamilyView(
        fid: state.pathParameters['fid']!,
        familyName: state.pathParameters['name']!,
      ),
    ),
    GoRoute(
      path: '/assignment/create',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => AssignmentFormView(),
    ),
    GoRoute(
      path: '/assignment/:fmId/logs/:fmmId',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => AdherenceView(
        fmid: state.pathParameters['fmId']!,
        fmmid: state.pathParameters['fmmId']!,
      ),
    ),

    GoRoute(
      path: '/assignment/:fmId/edit',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) {
        final assignment = state.extra as FamilyMemberMedication;
        return EditAssignmentView(assignment: assignment);
      },
    ),

    GoRoute(
      path: '/medications',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => MedicationsView(),
      routes: <RouteBase>[
        GoRoute(
          path: 'create',
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state) => MedicationFormView(),
        ),
        GoRoute(
          path: 'edit',
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state) {
            final medication = state.extra as Medication;
            return EditMedicationView(medication: medication);
          },
        ),
      ],
    ),
  ],
);