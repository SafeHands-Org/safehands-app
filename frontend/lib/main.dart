import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/styles/app_theme.dart';
import 'package:frontend/features/auth/pages/auth_page.dart';
import 'package:frontend/features/dashboard/pages/dashboard_page.dart';
import 'package:frontend/models/medications/medication_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SafeHandsApp());
}

class SafeHandsApp extends StatelessWidget {
  const SafeHandsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MedicationProvider(),
      child: MaterialApp(
        title: 'SafeHands',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        initialRoute: AuthPage.routeName,
        routes: {
          AuthPage.routeName:      (_) => const AuthPage(),
          DashboardPage.routeName: (_) => const DashboardPage(),
        },
      ),
    );
  }
}