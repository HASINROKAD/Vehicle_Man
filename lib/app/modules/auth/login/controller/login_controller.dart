import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_man/app/modules/auth/auth_controller.dart';

class LoginController extends GetxController {
  final AuthController authController = Get.find();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;

  void login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (!GetUtils.isEmail(email)) {
      Get.snackbar("Invalid Email", "Please enter a valid email");
      return;
    }

    if (password.length < 6) {
      Get.snackbar("Invalid Password", "Minimum 6 characters required");
      return;
    }

    isLoading.value = true;
    await authController.login(email: email, password: password);
    isLoading.value = false;
  }

  void clearForm() {
    emailController.clear();
    passwordController.clear();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
