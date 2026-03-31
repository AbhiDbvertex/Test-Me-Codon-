import 'package:codon/features/auth/screens/reset_password_screen.dart';
import 'package:codon/features/auth/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> verifyPhone({required bool isForChangePassword}) async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your phone number',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (!email.isEmail) {
      Get.snackbar(
        'Error',
        'Please enter a valid email',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Logic for phone verification/OTP sending would go here
    try {
      isLoading.value = true;
      final response = await Get.find<AuthService>().forgotPassword(
        email: email,
      );
      if (response['success']) {
        Get.snackbar(
          'Success',
          response['message'],
          snackPosition: SnackPosition.TOP,
        );
        Get.to(
          () => ResetPasswordScreen(
            email: email,
            isForChangePassword: isForChangePassword,
          ),
        );
      } else {
        Get.snackbar(
          'Error',
          response['message'],
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
