import 'package:flutter/material.dart';
import 'package:frontend/features/dashboard/pages/hamburger_menu.dart';

import 'package:frontend/features/auth/pages/auth_page.dart';
import 'package:frontend/features/auth/services/auth_service.dart';
import 'package:frontend/features/dashboard/pages/dashboard_page.dart';
import 'package:frontend/routes/app_router.dart';
void main() {
  runApp(const SafeHandsApp());
}

class SafeHandsApp extends StatelessWidget {
  const SafeHandsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeHands',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {

  final AuthService authService = AuthService();

  bool _loading = true;
  bool _loggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {

    final token = await authService.getToken();

    setState(() {
      _loggedIn = token != null;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (_loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_loggedIn) {
      return const DashboardPage();
    }

    return const AuthPage();
  }
}