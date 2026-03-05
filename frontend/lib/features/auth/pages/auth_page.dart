// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:frontend/features/components/styles/app_theme.dart';
import 'package:frontend/features/auth/controller/auth_controller.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

enum Auth { login, register }

class AuthPage extends StatefulWidget {
  static const routeName = '/auth';
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  Auth _auth = Auth.register;

  final _logInFormKey = GlobalKey<FormState>();
  final _registerFormKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final ValueNotifier<bool> _obscurePassword = ValueNotifier(true);
  final ValueNotifier<bool> _obscureConfirmPassword = ValueNotifier(true);

  String? selectedRole;

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _obscurePassword.dispose();
    _obscureConfirmPassword.dispose();
    super.dispose();
  }

  void _submit() async {
    final controller = context.read<AuthController>();

    if (_auth == Auth.login) {
      if (!_logInFormKey.currentState!.validate()) return;

      try {
        await controller.login(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
        context.go("/dashboard");
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Something went wrong, please try again later.")),
        );
      }
    } 
    else {
      if (!_registerFormKey.currentState!.validate()) return;

      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords do not match")),
        );
        return;
      }

      if (selectedRole == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Select a role")),
        );
        return;
      }

      try {
        await controller.register(
          "${_firstNameController.text.trim()} ${_lastNameController.text.trim()}",
          _emailController.text.trim(),
          _passwordController.text.trim(),
          selectedRole!,
        );
        context.go("/dashboard");
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration failed")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: _auth == Auth.login ? _buildLogin() : _buildRegister(),
      ),
    );
  } 

  Widget _buildLogin() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Form(
        key: _logInFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 80),
            const Text(
              "SafeHands", 
              style: AppTheme.title, 
              textAlign: TextAlign.center
            ),

            const SizedBox(height: 20),
            Text(
              "Log In",
              style: AppTheme.subtitle,
              textAlign: TextAlign.center
            ),

            const SizedBox(height: 40),
            TextFormField(
              controller: _emailController,
              decoration: AppTheme.inputDecoration(hintText: "Email", icon: Icons.email),
            ),

            const SizedBox(height: 20),
            ValueListenableBuilder(
              valueListenable: _obscurePassword,
              builder: (_, bool obscure, _) => TextFormField(
                controller: _passwordController,
                obscureText: obscure,
                decoration: AppTheme.inputDecoration(
                  hintText: "Password",
                  prefixIcon: Icons.lock,
                  suffixIcon: IconButton(
                    icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => _obscurePassword.value = !obscure,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _submit,
              style: AppTheme.buttonStyle,
              child: const Text("Log In", style: AppTheme.button),
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                TextButton(onPressed: () => setState(() => _auth = Auth.register), child: const Text("Sign Up", style: AppTheme.link)),
              ],
            ),
          ],
        ),
      )
    );

  Widget _buildRegister() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Form(
        key: _registerFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                const Text(
                  "SafeHands", 
                  style: AppTheme.title
                ),
                
                const SizedBox(height: 20),
                Text(
                  "Sign Up", 
                  style: AppTheme.subtitle
                ),

                const SizedBox(height: 20),
                TextFormField(
                  controller: _firstNameController,
                  decoration: AppTheme.inputDecoration(
                    hintText: "First Name",
                    icon: Icons.person,
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Please enter a name";
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                TextFormField(
                  controller: _lastNameController,
                  decoration: AppTheme.inputDecoration(
                    hintText: "Last Name",
                    icon: Icons.person,
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Please enter a last name";
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: AppTheme.inputDecoration(
                    hintText: "Email",
                    icon: Icons.email,
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Please enter an email";
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                ValueListenableBuilder(
                  valueListenable: _obscurePassword,
                  builder: (_, bool obscure, _) => TextFormField(
                    controller: _passwordController,
                    obscureText: obscure,
                    decoration: AppTheme.inputDecoration(
                      hintText: "Password",
                      prefixIcon: Icons.lock,
                      suffixIcon: IconButton(
                        icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => _obscurePassword.value = !obscure,
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return "Please enter a password";
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 20),
                ValueListenableBuilder(
                  valueListenable: _obscureConfirmPassword,
                  builder: (_, bool obscure, _) => TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: obscure,
                    decoration: AppTheme.inputDecoration(
                      hintText: "Confirm Password",
                      prefixIcon: Icons.lock,
                      suffixIcon: IconButton(
                        icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => _obscureConfirmPassword.value = !obscure,
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return "Please confirm your password";
                      if (v != _passwordController.text) return "Passwords do not match";
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  initialValue: selectedRole,
                  decoration: AppTheme.inputDecoration(hintText: "What's your role?"),
                  items: const [
                    DropdownMenuItem(value: "caregiver", child: Text("Caregiver")),
                    DropdownMenuItem(value: "family_member", child: Text("Family Member")),
                  ],
                  onChanged: (value) => setState(() => selectedRole = value),
                ),

                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: AppTheme.buttonStyle,
                    child: const Text("Sign up", style: AppTheme.button),
                  ),
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () => setState(() => _auth = Auth.login),
                      child: const Text("Login", style: AppTheme.link),
                    ),
                  ],
                ),
              ],
            ),
          ]
        )
      )
    );
  }
