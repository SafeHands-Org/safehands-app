import 'package:frontend/controllers/auth_controller.dart';
import 'package:frontend/features/auth/pages/signin_page.dart';
import 'package:frontend/features/auth/pages/signup_page.dart';
import 'package:frontend/features/auth/pages/startup_page.dart';
import 'package:frontend/features/dashboard/pages/dashboard_page.dart';
import 'package:frontend/features/family/family_members.dart';
import 'package:frontend/features/medications/pages/member_medications_page.dart';
import 'package:go_router/go_router.dart';

GoRouter createRouter(AuthController authController) {
  return GoRouter(
    refreshListenable: authController,
    redirect: (context, state) {
      if (authController.state == AuthState.loading) return null;

      final loggingIn = state.matchedLocation == '/signin' || state.matchedLocation == '/signup';

      if (authController.state == AuthState.unauthenticated) return loggingIn ? null : '/auth';
      if (authController.state == AuthState.authenticated && state.matchedLocation == '/auth') return '/dashboard';
      
      return null;
    },
    routes: [
      GoRoute(
        path: '/auth',
        builder: (context, state) => const StartUpPage(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: '/signin',
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: '/family',
        builder: (context, state) => const FamilyMembersPage(),
      ),
      GoRoute(
        path: '/medications',
        builder: (context, state) {
          final data = state.extra as Map<String, String>;

          return MemberMedicationsPage(
            memberId: data['memberId']!,
            memberName: data['memberName']!,
          );
        },
      ),
    ],
  );
}