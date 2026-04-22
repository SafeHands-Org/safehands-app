import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/providers/auth/auth_provider.dart';
import 'package:frontend/features/ui/auth/widgets/register_email.dart';
import 'package:frontend/features/ui/auth/widgets/register_password.dart';
import 'package:frontend/features/ui/auth/widgets/register_profile.dart';
import 'package:go_router/go_router.dart';

class RegistrationView extends ConsumerStatefulWidget {
  const RegistrationView({super.key});

  @override
  ConsumerState<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends ConsumerState<RegistrationView> {
  int _step = 0;
  String _name = '';
  String _email = '';
  String _password = '';
  String _role = '';

  Widget _buildStep() {
    switch (_step) {
      case 0: return RegisterStepEmail(
        key: const ValueKey(0),
        onNext: (email) => setState(() {
          _email = email;
          _step = 1;
        }),
      );
      case 1: return RegisterStepPassword(
        key: const ValueKey(1),
        email: _email,
        onNext: (pw) => setState(() {
          _password = pw;
          _step = 2;
        }),
        onBack: () => setState(() => _step = 0),
      );
      default: return RegisterStepProfile(
        key: const ValueKey(2),
        onNext: (name, role) {
          _role = role;
          _name = name;
          _createAccount();
        },
        onBack: () => setState(() => _step = 1),
      );
    }
  }

  void _createAccount() async {
    try {
      await ref.read(authProvider.notifier).register(
        name: _name,
        email: _email,
        password: _password,
        role: _role,
      );
      context.go('/dashboard');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 448),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _buildStep(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}