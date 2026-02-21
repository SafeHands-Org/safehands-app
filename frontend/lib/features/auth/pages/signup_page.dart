import 'package:flutter/material.dart';
import 'package:frontend/features/auth/pages/login_page.dart';
import 'package:frontend/styles/app_theme.dart';
import 'package:frontend/features/dashboard/pages/caregiver_dashboard.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? selectedRole;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CaregiverDashboard()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData, 
      home: Scaffold(
        body: SingleChildScrollView(
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
                          value: "family",
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
                    TextField(
                      decoration: AppTheme.inputDecoration(
                        hintText: "Email",
                        icon: Icons.email,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      obscureText: true,
                      decoration: AppTheme.inputDecoration(
                        hintText: "Password",
                        icon: Icons.lock,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      obscureText: true,
                      decoration: AppTheme.inputDecoration(
                        hintText: "Confirm Password",
                        icon: Icons.lock,
                      ),
                    ),
                  ],
                ),

                ElevatedButton(
                  onPressed: _submit,
                  style: AppTheme.buttonStyle,
                  child: const Text(
                    "Sign up",
                    style: AppTheme.button,
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())),
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