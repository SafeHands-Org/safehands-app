import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/providers/auth/auth_provider.dart';
import 'package:frontend/features/ui/auth/widgets/form_buttons.dart';
import 'package:frontend/features/ui/auth/widgets/form_field.dart';
import 'package:frontend/utils/exceptions.dart';
import 'package:go_router/go_router.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  bool hasError = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    ref.listenManual(authProvider,
    (previous, next) {next.whenOrNull(
        data: (_) {
          if (mounted) context.go('/');
        },
        error:(error, stackTrace) {
          if (!mounted) return;
          final message = switch (error) {
            CredentialException() => 'Invalid email or password.',
            NotFoundException() => 'Invalid email or password',
            ServerException() => 'Request timed out. Try again.',
            _ => 'Something went wrong. Please try again.',
          };
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Color(0xFFB62320)),
          );
        }
      );
    });
  }

  void _submit() async {
    if (_formKey.currentState!.validate()){
      await ref.read(authProvider.notifier).login(
        email:  _emailCtrl.text,
        password: _passwordCtrl.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: cs.onSurfaceVariant, size: 24),
          onPressed: () => context.go('/auth'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 448),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome Back', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: cs.onSurface)),
                      const SizedBox(height: 32),
                      FormTextField(
                        label: 'Email Address',
                        controller: _emailCtrl,
                        hint: 'Enter your email',
                        prefixIcon: Icons.mail_outline,
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter your email' : null,
                      ),
                      const SizedBox(height: 20),
                      FormTextField(
                        label: 'Password',
                        controller: _passwordCtrl,
                        hint: 'Enter your password',
                        prefixIcon: Icons.lock_outline,
                        obscure: true,
                        validator: (v) => (v == null || v.isEmpty) ? 'Please enter your password' : null,
                      ),
                      const SizedBox(height: 50),
                      FormButton(label: 'Log In', onPressed: _submit),
                      const SizedBox(height: 24),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: 14, color: cs.onSurfaceVariant),
                            children: [
                              const TextSpan(text: "Don't have an account?  "),
                              WidgetSpan(
                                child: GestureDetector(
                                  onTap: () => context.go('/auth/register'),
                                  child: Text('Sign Up', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: cs.primary)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
