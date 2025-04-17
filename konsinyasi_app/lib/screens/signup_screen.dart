import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../themes/app_theme.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 100,
              ),
              const SizedBox(height: 48),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // Validate passwords match
                  if (_passwordController.text ==
                      _confirmPasswordController.text) {
                    Get.offAllNamed('/home');
                  } else {
                    Get.snackbar(
                      'Error',
                      'Passwords do not match',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                child: const Text('Sign up'),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an Account? "),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: AppTheme.primaryColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
