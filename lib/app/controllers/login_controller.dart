import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() {
    final username = usernameController.text;
    final password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // TODO: Implement actual login logic here
    // For now, just show a success message and navigate to home
    Get.snackbar(
      'Success',
      'Login successful',
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.offAllNamed('/home');
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
