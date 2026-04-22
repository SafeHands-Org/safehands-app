import 'package:flutter/material.dart';
import 'package:frontend/features/components/shared/shell_page.dart';
import 'package:frontend/features/providers/auth/auth_provider.dart';
import 'package:frontend/features/ui/auth/pages/login.dart';
import 'package:frontend/features/ui/auth/pages/register.dart';
import 'package:frontend/features/ui/auth/pages/startup.dart';
import 'package:frontend/features/ui/dashboard/pages/dashboard.dart';
import 'package:frontend/features/ui/family/pages/family_details.dart';
import 'package:frontend/features/ui/family/pages/family_invite.dart';
import 'package:frontend/features/ui/family/pages/member_details.dart';
import 'package:frontend/features/ui/medications/pages/medication_details.dart';
import 'package:frontend/features/ui/medications/pages/medication_form.dart';
import 'package:frontend/features/ui/medications/pages/medication_overview.dart';
import 'package:frontend/features/ui/user/pages/user_profile.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) => GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  refreshListenable: RouterRefreshNotifier(ref),
  redirect: (context, state) {
    final isLoggedIn = ref.watch(isLoggedInProvider);

    final onAuthRoute = state.matchedLocation.startsWith('/auth');

    if (!isLoggedIn && !onAuthRoute) return '/auth';

    if (isLoggedIn && onAuthRoute) return '/dashboard';

    return null;
  },
  routes: <RouteBase>[
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
      ]
    ),

    GoRoute(
      path: '/family',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => FamilyView(),
      routes: <RouteBase> [
        GoRoute(
          path: 'members/:fmid',
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state) => MemberView(fmid: state.pathParameters['fmid']!),
        ),
      ]
    ),

    GoRoute(
      path: '/family/invite',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => FamilyInviteView()
    ),

    GoRoute(
      path: '/medications',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => MedicationsView(),
      routes: <RouteBase> [
        GoRoute(
          path: 'create',
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state) => MedicationFormView(),
        ),
        GoRoute(
          path: ':id',
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state) => MedicationDetailView(),
        ),
      ]
    ),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => ShellView(child: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => DashboardView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
             path: '/family',
             builder: (context, state) => FamilyView()
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => UserProfileView(),
            ),
          ],
        ),
      ],
    ),
  ]
);