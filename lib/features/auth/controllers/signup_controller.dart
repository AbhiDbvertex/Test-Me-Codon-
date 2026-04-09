import 'package:codon/features/auth/controllers/user_controller.dart';
import 'package:codon/features/auth/models/select_location_model.dart';
import 'package:codon/features/auth/models/user_model.dart';
import 'package:codon/features/auth/screens/verify_otp_screen.dart';
import 'package:codon/features/auth/services/auth_services.dart';
import 'package:codon/features/auth/services/google_sign_in_service.dart';
import 'package:codon/features/auth/services/location_service.dart';
import 'package:codon/features/home/screens/home_screen.dart';
import 'package:codon/utills/base_api_client.dart';
import 'package:codon/utills/prefs_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  // Text Controllers
  final firstNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  // final addressController = TextEditingController();
  final collegeController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final passingYearController =
      TextEditingController(); // Added missing controller/field

  // Dropdown Selections
  final selectedState = RxnString();
  final selectedCity = RxnString();
  final selectedYear = RxnString();
  RxBool isLoading = false.obs;

  // final password = passwordController.text;

  // Data Lists
  final states = <LocationModel>[].obs;
  final cities = <LocationModel>[].obs;

  // Password Visibility
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  // Dependencies
  final LocationService _locationService = Get.find<LocationService>();

  final List<String> years = List.generate(
    3,
    (index) => (DateTime.now().year + index).toString(),
  );

  @override
  void onInit() {
    super.onInit();
    getStates();
  }

  Future<void> getStates() async {
    try {
      final response = await _locationService.getStates();
      if (response['success'] == true) {
        final locationResponse = LocationResponse.fromJson(response);
        states.assignAll(locationResponse.data);
      }
    } catch (e) {
      print("Error fetching states: $e");
    }
  }

  Future<void> getCities(String stateId) async {
    try {
      if (stateId.isEmpty) return;
      final response = await _locationService.getCities(stateId: stateId);
      if (response['success'] == true) {
        final locationResponse = LocationResponse.fromJson(response);
        cities.assignAll(locationResponse.data);
      }
    } catch (e) {
      print("Error fetching cities: $e");
    }
  }

  // Toggle Visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  // Sign Up Action
  void signUp() async {
    if (_validateFields()) {
      print("Sign Up Action");
      print("user name ${firstNameController.text}");
      print("user email ${emailController.text}");
      print("user mobile ${mobileController.text}");
      // print("user address ${addressController.text}");
      print("user college ${collegeController.text}");
      print("user password ${passwordController.text}");
      print("user admission year ${selectedYear.value}");
      print("Selected State ID: ${selectedState.value}");
      print("Selected City ID: ${selectedCity.value}");
      print(" class ID: ");
      try {
        isLoading.value = true;
        final response = await Get.find<AuthService>().register(
          name: firstNameController.text,
          emailOrPhone: emailController.text,
          mobile: mobileController.text,
          address: "",
          collegeName: collegeController.text,
          password: passwordController.text,
          admissionYear: selectedYear.value ?? "",
          stateId: selectedState.value ?? "",
          cityId: selectedCity.value ?? "",
          classId: "",
        );
        print("Response: $response");
        if (response['success'] == true) {
          Get.to(
            () => const VerifyOtpScreen(),
            // arguments: {"email": emailController.text,'passwrod':passingYearController.text},
            arguments: {
              "email": emailController.text,
              "password": passwordController.text,
            },
          );
        } else {
          Get.snackbar(
            'Error',
            '${response['message']}',
            snackPosition: SnackPosition.TOP,
          );
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'Please fill all required fields',
          snackPosition: SnackPosition.TOP,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  bool _validateFields() {
    if (firstNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        mobileController.text.isEmpty ||
        // addressController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        selectedState.value == null ||
        selectedCity.value == null) {
      Get.snackbar(
        'Error',
        'Please fill all required fields',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }

    return true;
  }

  void googleSignIn() async {
    try {
      isLoading.value = true;
      final googleResponse = await Get.find<GoogleSignInService>()
          .signInWithGoogle();

      if (!googleResponse['success']) {
        print("Google Sign In Failed ${googleResponse['message']}");
        Get.snackbar(
          'Error',
          googleResponse['message'] ?? 'Google sign-in failed',
          snackPosition: SnackPosition.TOP,
        );
        return;
      }
      print("Google Sign In Success");
      final firebaseIdToken = googleResponse['idToken'];
      print("Firebase ID Token: $firebaseIdToken");

      // Step 2: Call backend API with Firebase ID token
      final response = await Get.find<AuthService>().googleAuth(
        idToken: firebaseIdToken,
      );
      print("Response: $response");

      if (response['accessToken'] != null && response['refreshToken'] != null) {
        // Save tokens
        await PrefsService.saveAccessToken(token: response['accessToken']);
        await PrefsService.saveRefreshToken(token: response['refreshToken']);
        BaseApiClient.accessToken = response['accessToken'];

        // Save user data
        if (response['user'] != null) {
          final userData = Map<String, dynamic>.from(response['user']);
          if (response["activesubscription"] != null)
            userData["activesubscription"] = response["activesubscription"];
          if (response["activeSubscription"] != null)
            userData["activeSubscription"] = response["activeSubscription"];
          Get.find<UserController>().userModel.value = UserModel.fromJson(
            userData,
          );
        }

        // Navigate to Home
        Get.offAll(() => HomeScreen());

        Get.snackbar(
          'Success',
          'Signed in with Google successfully',
          snackPosition: SnackPosition.TOP,
        );
      } else {
        Get.snackbar(
          'Error',
          response['message'] ?? 'Authentication failed',
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
    firstNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    // addressController.dispose();
    collegeController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    passingYearController.dispose();
    super.onClose();
  }
}
