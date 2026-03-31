import 'package:codon/features/auth/controllers/signup_controller.dart';
import 'package:codon/features/auth/controllers/user_controller.dart';
import 'package:codon/features/auth/services/auth_services.dart';
import 'package:codon/utills/widgets/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utills/base_api_client.dart';
import '../../../utills/prefs_service.dart';
import '../../home/screens/home_screen.dart';
import '../models/user_model.dart';

class VerifyOtpController extends GetxController {
  final otpController = TextEditingController();
  final emailController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool showEmailInput = false.obs;

  @override
  void onInit() {
    super.onInit();
    var arg = Get.arguments;
    if (arg != null && arg['email'] != null) {
      emailController.text = arg['email'];
      showEmailInput.value = false;
    } else {
      showEmailInput.value = true;
    }
  }

  // Future<void> verifyOtp({required String email}) async {
  //   print("Email: $email");
  //   print("OTP: ${otpController.text}");
  //   String otp = otpController.text;
  //   if (otp.length != 6) {
  //     Get.snackbar(
  //       'Error',
  //       'Please enter a valid OTP',
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //     return;
  //   }
  //
  //   isLoading.value = true;
  //   // Mock verification
  //   // Show Success Dialog
  //   // final response = await Get.find<AuthService>().verifyEmail(
  //   //   email: email,
  //   //   otp: otp,
  //   // );
  //   try {
  //     final response = await Get.find<AuthService>().verifyEmail(
  //       email: email,
  //       otp: otp,
  //     );
  //     // if (response['success']) {
  //     //   // Get.dialog(const SuccessDialog());
  //     //
  //     // }
  //
  //
  //
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.TOP);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> verifyOtp({required String email , required String password}) async {
    print("Email: $email");
    print("OTP: ${otpController.text}");
    String otp = otpController.text;
    if (otp.length != 6) {
      Get.snackbar(
        'Error',
        'Please enter a valid OTP',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;
    // Mock verification
    // Show Success Dialog
    // final response = await Get.find<AuthService>().verifyEmail(
    //   email: email,
    //   otp: otp,
    // );
    // Get.find<AuthController>().password = passwordController.text;
    final authController = Get.find<SignUpController>();
    try {
      final response = await Get.find<AuthService>().verifyEmail(
        email: email,
        otp: otp,
          password: password
      );
      // if (response['success']) {
      //   // Get.dialog(const SuccessDialog());
      //
      // }

      if (response['success'] == true) {

        print("Abhi:- verfiy email: ${email}, password: ${password}");

        final loginResponse = await Get.find<AuthService>().login(
            emailOrPhone: email,
            password: password // ya jo bhi password hai
        );

        print("Abhi:- get login token: ${loginResponse["accessToken"]}");

        if (loginResponse["accessToken"] != null &&
            loginResponse["refreshToken"] != null) {

          await PrefsService.saveAccessToken(token: loginResponse["accessToken"]);
          await PrefsService.saveRefreshToken(token: loginResponse["refreshToken"]);

          BaseApiClient.accessToken = loginResponse["accessToken"];

          if (loginResponse["user"] != null) {
            final userData = Map<String, dynamic>.from(loginResponse["user"]);

            Get.find<UserController>().userModel.value =
                UserModel.fromJson(userData);
          }

          Get.offAll(() => HomeScreen());
        }
      }

    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendVerificationEmail() async {
    String email = emailController.text.trim();
    if (email.isEmpty || !GetUtils.isEmail(email)) {
      Get.snackbar(
        'Error',
        'Please enter a valid email address',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    isLoading.value = true;
    try {
      final response = await Get.find<AuthService>()
          .resendOtpForEmailVerification(email: email);
      if (response['success']) {
        showEmailInput.value = false;
        Get.snackbar(
          'Success',
          'OTP sent successfully',
          snackPosition: SnackPosition.TOP,
        );
      } else {
        Get.snackbar(
          'Error',
          response['message'] ?? 'Failed to send OTP',
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOtp() async {
    String email = emailController.text.trim();
    if (email.isEmpty) {
      Get.snackbar(
        'Error',
        'Email is required',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }
    isLoading.value = true;
    try {
      final response = await Get.find<AuthService>()
          .resendOtpForEmailVerification(email: email);
      Get.snackbar(
        response['success'] ? 'Success' : 'Error',
        response['message'],
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }
}
