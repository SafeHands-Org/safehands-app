import 'package:frontend/features/auth/controller/auth_controller.dart';
import 'package:frontend/features/dashboard/pages/dashboard_page.dart';
import '../features/auth/pages/auth_page.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/features/family/family_members.dart';
import 'package:frontend/features/medications/pages/member_medications_page.dart';

GoRouter createRouter(AuthController authController) {
  return GoRouter(
    refreshListenable: authController,
    redirect: (context, state) {
      if (authController.state == AuthState.loading) return null;

      if (authController.state == AuthState.unauthenticated) return "/auth";
      
      if (authController.state == AuthState.authenticated && state.matchedLocation == "/auth") return "/dashboard";
      
      return null;
    },
    routes: [
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthPage(),
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
        builder: (context, state) => const MemberMedicationsPage(),
      ),
    ],
  );
}