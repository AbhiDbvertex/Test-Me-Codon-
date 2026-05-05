import 'package:codon/features/auth/controllers/user_controller.dart';
import 'package:codon/features/auth/controllers/complete_profile_controller.dart';
import 'package:codon/features/auth/models/select_location_model.dart';
import 'package:codon/features/auth/models/user_model.dart';
import 'package:codon/features/auth/screens/complete_profile_screen.dart';
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
  final addressController = TextEditingController();
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
      print("user address ${addressController.text}");
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
          address: addressController.text ?? "",
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
    if (firstNameController.text.trim().isEmpty) {
      _showError('Please enter your name');
      return false;
    }

    final email = emailController.text.trim();
    if (email.isEmpty) {
      _showError('Please enter your email');
      return false;
    }
    if (!GetUtils.isEmail(email)) {
      _showError('Please enter a valid email address');
      return false;
    }

    final mobile = mobileController.text.trim();
    if (mobile.isEmpty) {
      _showError('Please enter your mobile number');
      return false;
    }
    if (mobile.length != 10 || !GetUtils.isNumericOnly(mobile)) {
      _showError('Please enter a valid 10-digit mobile number');
      return false;
    }

    if (addressController.text.trim().isEmpty) {
      _showError('Please enter your address');
      return false;
    }

    if (selectedState.value == null) {
      _showError('Please select your state');
      return false;
    }

    if (selectedCity.value == null) {
      _showError('Please select your city');
      return false;
    }

    if (collegeController.text.trim().isEmpty) {
      _showError('Please enter your college name');
      return false;
    }

    if (selectedYear.value == null) {
      _showError('Please select passing year');
      return false;
    }

    if (passwordController.text.isEmpty) {
      _showError('Please enter a password');
      return false;
    }

    if (passwordController.text.length < 6) {
      _showError('Password must be at least 6 characters');
      return false;
    }

    if (passwordController.text != confirmPasswordController.text) {
      _showError('Passwords do not match');
      return false;
    }

    return true;
  }

  void _showError(String message) {
    Get.snackbar(
      'Validation Error',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      duration: const Duration(seconds: 2),
    );
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

        // Navigate — go to CompleteProfileScreen if profile is incomplete
        final userModel = Get.find<UserController>().userModel.value;
        final bool profileIncomplete =
            userModel == null || (userModel.mobile.isEmpty);

        if (profileIncomplete) {
          if (!Get.isRegistered<CompleteProfileController>()) {
            Get.put(CompleteProfileController());
          } else {
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
