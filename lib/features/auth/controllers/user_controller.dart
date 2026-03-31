import 'package:codon/features/auth/models/user_model.dart';
import 'package:codon/features/auth/services/auth_services.dart';
import 'package:codon/utills/prefs_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  Rx<UserModel?> userModel = Rx<UserModel?>(null);

  Future<void> refreshUserProfile() async {
    try {
      final token = await PrefsService.getAccessToken();
      if (token != null) {
        final response = await Get.find<AuthService>().authMe(token: token);
        if (response['success'] == true && response['data'] != null) {
          final userData = Map<String, dynamic>.from(response['data']);
          if (response["activesubscription"] != null)
            userData["activesubscription"] = response["activesubscription"];
          if (response["activeSubscription"] != null)
            userData["activeSubscription"] = response["activeSubscription"];
          userModel.value = UserModel.fromJson(userData);
          debugPrint("User Profile Refreshed: ${userModel.value?.email}");
        }
      }
    } catch (e) {
      debugPrint("Error refreshing user profile: $e");
    }
  }
}
