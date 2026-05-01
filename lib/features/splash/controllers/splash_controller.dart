import 'package:codon/features/auth/controllers/user_controller.dart';
import 'package:codon/features/auth/models/user_model.dart';
import 'package:codon/features/auth/screens/login_screen.dart';
import 'package:codon/features/auth/screens/verify_otp_screen.dart';
import 'package:codon/features/home/screens/home_screen.dart';
import 'package:codon/features/splash/services/splash_service.dart';
import 'package:codon/features/auth/controllers/complete_profile_controller.dart';
import 'package:codon/features/auth/screens/complete_profile_screen.dart';
import 'package:codon/features/subscription/screens/subscription_screen.dart';
import 'package:codon/utills/widgets/internel_server_error_screen.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // authCheck();
    checkServerStatus();
  }

  void _navigateToHome() {
    Get.offAll(() => HomeScreen());
  }

  void _navigateToLogin() {
    Get.offAll(() => const LoginScreen());
  }

  void _navigateToVerifyEmail({String? email}) {
    Get.offAll(() => const VerifyOtpScreen(), arguments: {"email": email});
  }

  void _navigateToInternalError() {
    Get.offAll(() => const InternalServerErrorScreen());
  }

  // Future<void> checkServerStatus() async {
  //   final splashService = Get.find<SplashService>();
  //   final result = await splashService.checkServerStatus();
  //   if (result['success']) {
  //     authCheck();
  //   } else {
  //     _navigateToInternalError();
  //   }
  // }
  void _navigateToSubscription() {
    Get.offAll(() => const SubscriptionScreen());
  }

  Future<void> checkServerStatus() async {
    try {
      Future.delayed(const Duration(seconds: 62));
      final splashService = Get.find<SplashService>();

      final result = await splashService.checkServerStatus().timeout(
        const Duration(seconds: 65),
      );

      if (result['success'] == true) {
        await authCheck();
      } else {
        _navigateToInternalError();
      }
    } catch (e) {
      print("Server status error: $e");
      _navigateToInternalError();
    }
  }

  Future<void> authCheck() async {
    try {
      print("Auth Check");

      final splashService = Get.find<SplashService>();

      final result = await splashService.authCheck().timeout(
        const Duration(seconds: 65),
      );

      if (result['success'] == true) {
        final userController = Get.find<UserController>();

        final userData = Map<String, dynamic>.from(result['data']);
        if (result["activesubscription"] != null)
          userData["activesubscription"] = result["activesubscription"];
        if (result["activeSubscription"] != null)
          userData["activeSubscription"] = result["activeSubscription"];
        userController.userModel.value = UserModel.fromJson(userData);

        final user = userController.userModel.value;
        final isEmailVerified = user?.isEmailVerified ?? false;

        if (isEmailVerified) {
          final bool profileIncomplete =
              user?.mobile == null || user!.mobile.isEmpty;

          if (profileIncomplete) {
            if (!Get.isRegistered<CompleteProfileController>()) {
              Get.put(CompleteProfileController());
            } else {
              Get.find<CompleteProfileController>().onInit();
            }
            Get.offAll(() => const CompleteProfileScreen());
          } else {
            _navigateToHome();
          }
        } else {
          _navigateToVerifyEmail(email: user?.email);
        }
      } else {
        _navigateToLogin();
      }
    } catch (e) {
      print("Auth check error: $e");
      _navigateToLogin();
    }
  }
}
