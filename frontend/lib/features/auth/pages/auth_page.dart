import 'package:flutter/material.dart';
import 'package:frontend/styles/app_theme.dart';
import 'package:frontend/features/auth/services/auth_service.dart';
import 'package:frontend/features/dashboard/pages/dashboard_page.dart';

enum Auth {
  login,
  register,
}

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
  final AuthService authService = AuthService();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? selectedRole;

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_auth == Auth.login) {
      if (!_logInFormKey.currentState!.validate()) return;

      final session = await authService.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (!mounted) return;

      if (session != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login failed")),
        );
      }

    } else {
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

      final session = await authService.register(
        "${_firstNameController.text.trim()} ${_lastNameController.text.trim()}",
        _emailController.text.trim(),
        _passwordController.text.trim(),
        selectedRole!
      );

      if (!mounted) return;

      if (session != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration failed")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_auth) {
      case Auth.login:
        return _buildLogin();

      case Auth.register:
        return _buildRegister();
    }
  }
    
  Widget _buildLogin() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _logInFormKey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  "SafeHands",
                  style: AppTheme.title,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),
                Text(
                  "Log In",
                  style: AppTheme.subtitle,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  decoration: AppTheme.inputDecoration(
                    hintText: "Email",
                    icon: Icons.email,
                  ),
                ),

                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: AppTheme.inputDecoration(
                    hintText: "Password",
                    icon: Icons.lock,
                  ),
                ),

                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _submit,
                  style: AppTheme.buttonStyle,
                  child: const Text(
                    "Log In",
                    style: AppTheme.button,
                  ),
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _auth = Auth.register;
                        });
                      },
                      child: const Text(
                        "Sign Up",
                        style: AppTheme.link,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegister() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _registerFormKey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(height: 60),
                    const Text(
                      "SafeHands",
                      style: AppTheme.title,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Sign Up",
                      style: AppTheme.subtitle,
                    ),
                  ],
                ),

                Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _firstNameController,
                      decoration: AppTheme.inputDecoration(
                        hintText: "First Name",
                        icon: Icons.person,
                      ),
                    ),

                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: AppTheme.inputDecoration(
                        hintText: "Last Name",
                        icon: Icons.person,
                      ),
                    ),

                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      initialValue: selectedRole,
                      decoration: AppTheme.inputDecoration(
                        hintText: "What's your role?",
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "caregiver",
                          child: Text("Caregiver"),
                        ),
                        DropdownMenuItem(
                          value: "family_member",
                          child: Text("Family Member"),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedRole = value;
                        });
                      },
                    ),

                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      decoration: AppTheme.inputDecoration(
                        hintText: "Email",
                        icon: Icons.email,
                      ),
                    ),

                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: AppTheme.inputDecoration(
                        hintText: "Password",
                        prefixIcon: Icons.lock,
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      decoration: AppTheme.inputDecoration(
                        hintText: "Confirm Password",
                        prefixIcon: Icons.lock,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please confirm your password";
                        }
                        if (value != _passwordController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submit,
                        style: AppTheme.buttonStyle,
                        child: const Text(
                          "Sign up",
                          style: AppTheme.button,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _auth = Auth.login;
                        });
                      },
                      child: const Text(
                        "Login",
                        style: AppTheme.link,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}