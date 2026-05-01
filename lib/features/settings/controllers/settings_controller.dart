import 'package:codon/features/auth/screens/forgot_password_screen.dart';
import 'package:codon/features/auth/screens/login_screen.dart';
import 'package:codon/features/settings/screens/edit_profile_screen.dart';
import 'package:codon/features/settings/screens/change_password_screen.dart';
import 'package:codon/features/settings/screens/about_us_screen.dart';
import 'package:codon/features/settings/screens/privacy_policy_screen.dart';
import 'package:codon/features/settings/screens/refund_and_cancellation_screen.dart';
import 'package:codon/features/settings/screens/share_us_app.dart';
import 'package:codon/features/settings/screens/terms_condition_screen.dart';
import 'package:codon/features/settings/services/setting_service.dart';
import 'package:codon/utills/prefs_service.dart';
import 'package:codon/features/auth/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../../utills/base_api_client.dart';
import '../../subscription/screens/subscription_screen.dart';
import '../screens/add_our_plans.dart';
import '../screens/add_rate_us.dart';
import '../screens/connect_With_Us.dart';
import '../screens/faq_screen.dart';
import '../screens/report_privacy_screen.dart';

class SettingsController extends GetxController {
  final UserController _userController = Get.find<UserController>();
  final RxBool isLoading = false.obs;

  void navigateTo(String page) {
    if (page == 'Edit Profile') {
      Get.to(() => EditProfileScreen());
    } else if (page == 'CHANGE PASSWORD') {
      Get.to(() => ForgotPasswordScreen(isForChangePassword: true));
    } else if (page == 'About us') {
      Get.to(() => const AboutUsScreen());
    } else if (page == 'PRIVACY') {
      Get.to(() => const PrivacyPolicyScreen());
    } else if (page == 'Terms & Condition') {
      Get.to(() => const TermsConditionScreen());
    } else if (page == 'faq') {
      Get.to(() => const FaqScreen());
    } else if (page == 'Refund & Cancellation Policy') {
      Get.to(() => const RefundAndCancellationPolicyScreen());
    } else if (page == "Connect with us") {
      Get.to(() => const ConnectWithUsScreen());
    } else if (page == 'Our Plans') {
      Get.to(() => const SubscriptionScreen());
    } else if (page == 'Rate Us') {
      Get.to(() => const RateUsScreen());
    } else if (page == 'Share Us') {
      Get.to(() => const ShareUsScreen());
    } else if (page == 'Report Privacy') {
      Get.to(() => const ReportPrivacyScreen());
    } else {
      Get.snackbar(
        'Navigation',
        'Navigating to $page',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  final RxBool isOtherExpanded = false.obs;

  Future<dynamic> getAboutUs() async {
    try {
      final response = await Get.find<SettingService>().getAboutUs();
      print(response.entries);
      print("data in controller:- ${response['data']}");
      if (response['success']) {
        print(response['data']);
        return response['data'];
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getTermsConditions() async {
    try {
      final response = await Get.find<SettingService>().getTermsConditions();
      if (response['success']) {
        print(response['data']);
        return response['data'];
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getPrivacyPolicy() async {
    try {
      final response = await Get.find<SettingService>().getPrivacyPolicy();
      if (response['success']) {
        print(response['data']);
        return response['data'];
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getFaverite() async {
    try {
      final response = await Get.find<SettingService>().getFaverite();
      if (response['success']) {
        print(response['data']);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getHistory() async {
    try {
      final response = await Get.find<SettingService>().getHistory();
      if (response['success']) {
        print(response['data']);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    final response = await Get.find<SettingService>().logout(
      userId: _userController.userModel.value?.id ?? '',
    );
    if (response["success"] == true) {
      final res = await PrefsService.clearAllData();
      BaseApiClient.accessToken = null;
      res
          ? Get.offAll(() => LoginScreen())
          : Get.snackbar(
              'Error',
              'Logout Failed.',
              snackPosition: SnackPosition.TOP,
            );
    }
  }

  Future<void> deleteAccount() async {
    isLoading.value = true;
    try {
      final response = await Get.find<SettingService>().deleteAccount();
      if (response['success']) {
        await PrefsService.clearAllData();
        BaseApiClient.accessToken = null;
        Get.offAll(() => LoginScreen());
        Get.snackbar(
          'Success',
          'Account deleted successfully',
          snackPosition: SnackPosition.TOP,
        );
      } else {
        Get.snackbar(
          'Error',
          response['message'] ?? 'Failed to delete account',
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
