import 'package:flutter/material.dart';
import 'package:frontend/controllers/auth_controller.dart';
import 'package:frontend/features/components/styles/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/signup';
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _step1FormKey = GlobalKey<FormState>();
  final _step2FormKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  String? selectedRole;
  int _currentStep = 0;

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _goToNextStep() {
    if (!_step1FormKey.currentState!.validate()) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    setState(() => _currentStep = 1);
  }

  void _createAccount() async {
    final controller = context.read<AuthController>();
    if (!_step2FormKey.currentState!.validate()) return;

    if (selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select a role')),
      );
      return;
    }

    try {
      await controller.register(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
        selectedRole!,
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.purple.shade400, size: 32),
          onPressed: () {
            if (_currentStep == 1) {
              setState(() => _currentStep = 0);
            } else {
              context.go('/auth');
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: _currentStep == 0 ? _buildStep1() : _buildStep2(),
        ),
      ),
    );
  }

  Widget _buildStep1() {
    return Form(
      key: _step1FormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const Text('Create Account', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1A2E22))),
          const SizedBox(height: 32),

          const Text('Enter email', style: TextStyle(fontSize: 15, color: Color(0xFF333333))),
          const SizedBox(height: 8),
          TextFormField(
            controller: _emailController,
            decoration: AppTheme.inputDecoration(
              prefixIcon: Icon(Icons.email),
              hintText: 'Email',
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'Please enter a valid email';
              return null;
            },
          ),
          const SizedBox(height: 24),

          const Text('Enter password', style: TextStyle(fontSize: 15, color: Color(0xFF333333))),
          const SizedBox(height: 8),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: AppTheme.inputDecoration(
              hintText: 'Password',
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: Colors.grey,
                ),
                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'Please enter a password';
              return null;
            },
          ),
          const SizedBox(height: 24),

          const Text('Confirm password', style: TextStyle(fontSize: 15, color: Color(0xFF333333))),
          const SizedBox(height: 8),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: _obscureConfirmPassword,
            decoration: AppTheme.inputDecoration(
              hintText: 'Confirm Password',
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: Colors.grey,
                ),
                onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
              ),
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'Please confirm your password';
              return null;
            },
          ),
          const SizedBox(height: 32),

          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _goToNextStep,
              style: AppTheme.buttonStyle,
              child: const Text('Next', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildStep2() {
    return Form(
      key: _step2FormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const Text('Personal Information', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1A2E22))),
          const SizedBox(height: 32),

          const Text("What's your name?", style: TextStyle(fontSize: 15, color: Color(0xFF333333))),
          const SizedBox(height: 8),
          TextFormField(
            controller: _nameController,
            decoration: AppTheme.inputDecoration(
              prefixIcon: Icon(Icons.person),
              hintText: 'Name',
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'Please enter your name';
              return null;
            },
          ),
          const SizedBox(height: 24),

          const Text('Choose a role', style: TextStyle(fontSize: 15, color: Color(0xFF333333))),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: selectedRole,
            decoration: AppTheme.inputDecoration(
              hintText: 'Role',
              prefixIcon: Icon(Icons.person),
            ),
            items: const [
              DropdownMenuItem(value: 'caregiver', child: Text('Caregiver')),
              DropdownMenuItem(value: 'family_member', child: Text('Family Member')),
            ],
            onChanged: (value) => setState(() => selectedRole = value),
            validator: (v) {
              if (v == null) return 'Please select a role';
              return null;
            },
          ),
          const SizedBox(height: 32),

          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _createAccount,
              style: AppTheme.buttonStyle,
              child: const Text('Sign Up', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}