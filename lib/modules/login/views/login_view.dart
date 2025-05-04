import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/controllers/login_controller.dart';
import '../../../app/core/theme/app_theme.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('🟢 LOGIN VIEW');
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Main content in a scrollable container
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 80.0, 24.0, 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),

                    // Logo image from Figma
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Container(
                        width: MediaQuery.of(context).size.width *
                            0.4, // 40% of screen width
                        height: MediaQuery.of(context).size.height *
                            0.2, // 20% of screen height
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/login.png'), // Pastikan path benar
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Email field with styling from Figma
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: const Color.fromRGBO(27, 149, 112, 1),
                          width: 3,
                        ),
                      ),
                      child: TextField(
                        controller: controller.usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.35),
                            fontFamily: 'Rubik',
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 33),

                    // Password field with styling from Figma
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: const Color.fromRGBO(27, 149, 112, 1),
                          width: 3,
                        ),
                      ),
                      child: Obx(() => TextField(
                            controller: controller.passwordController,
                            obscureText: !controller.isPasswordVisible.value,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              border: InputBorder.none,
                              labelStyle: const TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.35),
                                fontFamily: 'Rubik',
                                fontSize: 16,
                              ),
                              suffixIcon: IconButton(
                                icon: controller.isPasswordVisible.value
                                    ? const Icon(Icons.visibility,
                                        color: Color.fromRGBO(27, 149, 112, 1))
                                    : const Icon(Icons.visibility_off,
                                        color: Color.fromRGBO(27, 149, 112, 1)),
                                onPressed: controller.togglePasswordVisibility,
                              ),
                            ),
                          )),
                    ),

                    // Forgot Password text
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Add your forgot password logic here
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Color.fromRGBO(27, 149, 112, 1),
                            fontFamily: 'Rubik',
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),

                    // Login button with styling from Figma
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: controller.login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(27, 149, 112, 1),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 12),
                            side: const BorderSide(
                              color: Color.fromRGBO(27, 149, 112, 1),
                              width: 3,
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
