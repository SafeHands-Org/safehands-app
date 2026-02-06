import 'package:flutter/material.dart';
import 'package:frontend/styles/app_theme.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? selectedRole;

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
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      obscureText: true,
                      decoration: AppTheme.inputDecoration(
                        hintText: "Password",
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      obscureText: true,
                      decoration: AppTheme.inputDecoration(
                        hintText: "Confirm Password",
                      ),
                    ),
                  ],
                ),

                ElevatedButton(
                  onPressed: () {},
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
                      onPressed: () {},
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