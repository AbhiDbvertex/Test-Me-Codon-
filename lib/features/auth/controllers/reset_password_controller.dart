import 'package:codon/features/auth/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  final otpController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isLoading = false.obs;

  final isNewPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void resendOtp(String email) async {
    final response = await Get.find<AuthService>().forgotPassword(email: email);
    if (response['success']) {
      Get.snackbar(
        'Success',
        response['message'],
        snackPosition: SnackPosition.TOP,
      );
    } else {
      Get.snackbar(
        'Error',
        response['message'],
        snackPosition: SnackPosition.TOP,
      );
    }
    // Get.snackbar(
    //   'Success',
    //   response['message'],
    //   snackPosition: SnackPosition.TOP,
    // );

    // Get.snackbar(
    //   'OTP Resent',
    //   'A new verification code has been sent.',
    //   snackPosition: SnackPosition.TOP,
    // );
  }

  Future<void> resetPassword(String email) async {
    final otp = otpController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (otp.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter the OTP',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in both password fields',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (newPassword != confirmPassword) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Logic to reset password via API would go here
    try {
      isLoading.value = true;
      final response = await Get.find<AuthService>().resetPassword(
        email: email,
        otp: otp,
        newPassword: newPassword,
      );
      if (response['success']) {
        Get.back();
        Get.back();
        Get.snackbar(
          'Success',
          'Your password has been reset successfully.',
          snackPosition: SnackPosition.TOP,
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

    // Typically navigate to LoginScreen after successful reset
    // Get.offAll(() => const LoginScreen());
  }

  @override
  void onClose() {
    otpController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
