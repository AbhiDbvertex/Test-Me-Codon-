// import 'package:codon/features/auth/models/user_model.dart';
// import 'package:codon/features/auth/services/auth_services.dart';
// import 'package:codon/features/home/screens/home_screen.dart';
// import 'package:codon/utills/prefs_service.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// // Controller
// class LoginController extends GetxController {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final isPasswordVisible = false.obs;

//   void togglePasswordVisibility() {
//     isPasswordVisible.value = !isPasswordVisible.value;
//   }

//   void login() async {

//     final email = emailController.text;
//     final password = passwordController.text;

//     if (email.isEmpty || password.isEmpty) {
//       Get.snackbar(
//         'Error',
//         'Please fill all fields',
//         snackPosition: SnackPosition.TOP,
//       );
//       return;
//     }

//     // Add your login logic here
//     final response = await Get.find<AuthService>().login(
//       emailOrPhone: email,
//       password: password,
//     );
//     print("Login Responsess: $response");
//     if (response["token"] != null) {
//       print("Token is here ${response["token"]}");
//       await PrefsService.saveAccessToken(token: response["token"]);
//       // PrefsService.saveRefereshToken(token: response["refresh_token"]);
//       print("Token is cere ${response["token"]}");
//       if (response["user"] != null) {
//         UserModel.fromJson(response["user"]);
//       }
//       print("Token is tere ${response["token"]}");
//       Get.offAll(() => HomeScreen());
//       Get.snackbar(
//         'Success',
//         response["message"] ?? 'Login Successful',
//         snackPosition: SnackPosition.TOP,
//       );
//     } else {
//       Get.snackbar(
//         'Error',
//         response["message"] ?? 'Login failed',
//         snackPosition: SnackPosition.TOP,
//       );
//     }
//   }

//   void googleSignIn() {
//     // Add Google sign-in logic here
//     Get.snackbar(
//       'Google Sign In',
//       'Google sign-in to be implemented',
//       snackPosition: SnackPosition.TOP,
//     );
//   }

//   @override
//   void onClose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.onClose();
//   }
// }
import 'package:codon/features/auth/controllers/user_controller.dart';
import 'package:codon/features/auth/controllers/verify_otp_controller.dart';
import 'package:codon/features/auth/models/user_model.dart';
import 'package:codon/features/auth/services/auth_services.dart';
import 'package:codon/features/auth/services/google_sign_in_service.dart';
import 'package:codon/features/auth/screens/complete_profile_screen.dart';
import 'package:codon/features/auth/controllers/complete_profile_controller.dart';
import 'package:codon/features/home/screens/home_screen.dart';
import 'package:codon/features/subscription/screens/subscription_screen.dart';
import 'package:codon/utills/base_api_client.dart';
import 'package:codon/utills/prefs_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/verify_otp_screen.dart';

// Controller
class LoginController extends GetxController {
  final emailOrPhoneController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordVisible = false.obs;
  RxBool isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() async {
    final emailOrPhone = emailOrPhoneController.text;
    final password = passwordController.text;

    // Validate before setting loading state
    if (emailOrPhone.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all fields',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    isLoading.value = true;

    try {
      final response = await Get.find<AuthService>().login(
        emailOrPhone: emailOrPhone,
        password: password,
      );

      print("Login Response: $response");

      if (response["accessToken"] != null && response["refreshToken"] != null) {
        print("Token is here ${response["accessToken"]}");
        print("refresh token is here ${response["refreshToken"]}");

        await PrefsService.saveAccessToken(token: response["accessToken"]);
        await PrefsService.saveRefreshToken(token: response["refreshToken"]);
        BaseApiClient.accessToken = response["accessToken"];

        // PrefsService.saveRefereshToken(token: response["refresh_token"]);

        if (response["user"] != null) {
          final userData = Map<String, dynamic>.from(response["user"]);
          if (response["activesubscription"] != null)
            userData["activesubscription"] = response["activesubscription"];
          if (response["activeSubscription"] != null)
            userData["activeSubscription"] = response["activeSubscription"];
          Get.find<UserController>().userModel.value = UserModel.fromJson(
            userData,
          );
          print(
            "User Model: ${Get.find<UserController>().userModel.value?.email ?? ""}",
          );
        }

        // if (Get.find<UserController>().userModel.value?.subscription.isActive ??
        //     false) {
        Get.offAll(() => HomeScreen());
        // } else {
        //   Get.offAll(() => const SubscriptionScreen());
        // }
        Get.snackbar(
          'Success',
          response["message"] ?? 'Login Successful',
          snackPosition: SnackPosition.TOP,
        );
      } /*else if(response["message"]=="Email not verified") {

        Get.find<VerifyOtpController>().emailController.text =
            emailOrPhone;
        Get.to(() => const VerifyOtpScreen());
        Get.snackbar(
          'Error',
          response["message"] ?? 'Login failed',
          snackPosition: SnackPosition.TOP,
        );
      }*/ else {
        Get.snackbar(
          'Error',
          response["message"] ?? 'Login failed',
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> googleSignIn() async {
    isLoading.value = true;
    print("Google Sign In");
    try {
      // Step 1: Sign in with Google and get Firebase ID token
      final googleResponse = await Get.find<GoogleSignInService>()
          .signInWithGoogle();

      if (googleResponse['success'] != true) {
        print("Google Sign In Failed ${googleResponse['message']}");
        Get.snackbar(
          'Error',
          googleResponse['message'] ?? 'Google sign-in failed',
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      // Step 2: Send Firebase ID token to backend
      final String? firebaseIdToken = googleResponse['idToken'];

      if (firebaseIdToken == null) {
        Get.snackbar(
          'Error',
          'Failed to get authentication token',
          snackPosition: SnackPosition.TOP,
        );
        return;
      }
      print("Firebase ID Token: $firebaseIdToken");
      final backendResponse = await Get.find<AuthService>().googleAuth(
        idToken: firebaseIdToken,
      );

      // Step 3: Handle backend response
      if (backendResponse['accessToken'] != null &&
          backendResponse['refreshToken'] != null) {
        // Save tokens
        await PrefsService.saveAccessToken(
          token: backendResponse['accessToken'],
        );
        await PrefsService.saveRefreshToken(
          token: backendResponse['refreshToken'],
        );
        BaseApiClient.accessToken = backendResponse['accessToken'];

        // Save user data
        if (backendResponse['user'] != null) {
          final userData = Map<String, dynamic>.from(backendResponse['user']);
          if (backendResponse["activesubscription"] != null)
            userData["activesubscription"] =
                backendResponse["activesubscription"];
          if (backendResponse["activeSubscription"] != null)
            userData["activeSubscription"] =
                backendResponse["activeSubscription"];
          Get.find<UserController>().userModel.value = UserModel.fromJson(
            userData,
          );
        }

        // Navigate — go to CompleteProfileScreen if profile is incomplete
        final userModel = Get.find<UserController>().userModel.value;
        final bool profileIncomplete =
            userModel == null || (userModel.mobile.isEmpty);

        if (profileIncomplete) {
          // Ensure controller is initialised with latest user data
          if (!Get.isRegistered<CompleteProfileController>()) {
            Get.put(CompleteProfileController());
          } else {
            // Re-load user data into existing controller
            Get.find<CompleteProfileController>().onInit();
          }
          Get.offAll(() => const CompleteProfileScreen());
        } else {
          Get.offAll(() => HomeScreen());
        }
        Get.snackbar(
          'Success',
          'Signed in with Google successfully',
          snackPosition: SnackPosition.TOP,
        );
      } else {
        Get.snackbar(
          'Error',
          backendResponse['message'] ?? 'Authentication failed',
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      print('Google Sign-In Error: $e');
      Get.snackbar(
        'Error',
        'An error occurred: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailOrPhoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
