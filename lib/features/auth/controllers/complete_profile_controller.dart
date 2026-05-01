import 'dart:io';
import 'package:codon/features/auth/controllers/user_controller.dart';
import 'package:codon/features/auth/models/select_location_model.dart';
import 'package:codon/features/auth/models/user_model.dart';
import 'package:codon/features/auth/services/location_service.dart';
import 'package:codon/features/home/screens/home_screen.dart';
import 'package:codon/features/settings/services/setting_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfileController extends GetxController {
  // Text Controllers
  late TextEditingController nameCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController mobileCtrl;
  late TextEditingController collegeCtrl;

  // Dropdown values
  final selectedState = RxnString();
  final selectedCity = RxnString();
  final selectedYear = RxnString();

  // Profile image
  final Rx<File?> profileImage = Rx<File?>(null);
  final profileImageUrl = ''.obs;

  // Loading
  final isLoading = false.obs;

  // Data lists
  final states = <LocationModel>[].obs;
  final cities = <LocationModel>[].obs;
  final List<String> years = List.generate(
    12,
    (i) => (DateTime.now().year + 2 - i).toString(),
  );

  // Services
  final LocationService _locationService = Get.find<LocationService>();
  final SettingService _settingService = Get.find<SettingService>();
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();

    nameCtrl = TextEditingController();
    emailCtrl = TextEditingController();
    mobileCtrl = TextEditingController();
    collegeCtrl = TextEditingController();

    _loadUserData();
    getStates();
  }

  /// Pre-fill whatever data is available from Google/backend
  void _loadUserData() {
    final user = Get.find<UserController>().userModel.value;
    if (user == null) return;

    nameCtrl.text = user.name.isNotEmpty ? user.name : '';
    emailCtrl.text = user.email.isNotEmpty ? user.email : '';
    mobileCtrl.text = user.mobile.isNotEmpty ? user.mobile : '';
    collegeCtrl.text = user.college?.name ?? '';
    profileImageUrl.value = user.profileImage ?? '';

    if (user.state?.id != null && user.state!.id.isNotEmpty) {
      selectedState.value = user.state!.id;
      getCities(user.state!.id);
    }

    if (user.city?.id != null && user.city!.id.isNotEmpty) {
      // Set after cities load
      selectedCity.value = user.city!.id;
    }

    if (user.passingYear != null && user.passingYear!.isNotEmpty) {
      selectedYear.value = user.passingYear;
    }
  }

  Future<void> getStates() async {
    try {
      final res = await _locationService.getStates();
      if (res['success'] == true) {
        states.assignAll(LocationResponse.fromJson(res).data);
      }
    } catch (e) {
      print('Error fetching states: $e');
    }
  }

  Future<void> getCities(String stateId) async {
    if (stateId.isEmpty) return;
    try {
      cities.clear();
      selectedCity.value = null;
      final res = await _locationService.getCities(stateId: stateId);
      if (res['success'] == true) {
        final list = LocationResponse.fromJson(res).data;
        cities.assignAll(list);

        // Re-apply saved city if available
        final user = Get.find<UserController>().userModel.value;
        if (user?.city?.id != null &&
            list.any((c) => c.id == user!.city!.id)) {
          selectedCity.value = user!.city!.id;
        }
      }
    } catch (e) {
      print('Error fetching cities: $e');
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final image = await _picker.pickImage(
        source: source,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 85,
      );
      if (image != null) {
        profileImage.value = File(image.path);
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  bool _validate() {
    if (nameCtrl.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter your name',
          snackPosition: SnackPosition.TOP);
      return false;
    }
    if (mobileCtrl.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter your mobile number',
          snackPosition: SnackPosition.TOP);
      return false;
    }
    if (mobileCtrl.text.trim().length != 10) {
      Get.snackbar('Error', 'Please enter a valid 10-digit mobile number',
          snackPosition: SnackPosition.TOP);
      return false;
    }
    if (selectedState.value == null) {
      Get.snackbar('Error', 'Please select your state',
          snackPosition: SnackPosition.TOP);
      return false;
    }
    if (selectedCity.value == null) {
      Get.snackbar('Error', 'Please select your city',
          snackPosition: SnackPosition.TOP);
      return false;
    }
    return true;
  }

  Future<void> completeProfile() async {
    if (!_validate()) return;

    isLoading.value = true;
    try {
      final res = await _settingService.updateProfile(
        name: nameCtrl.text.trim(),
        mobile: mobileCtrl.text.trim(),
        address: '',
        countryId: '6967b961d48b7381354d28eb',
        stateId: selectedState.value ?? '',
        cityId: selectedCity.value ?? '',
        collegeId: collegeCtrl.text.trim(),
        classId: '',
        passingYear: selectedYear.value ?? '',
        image: profileImage.value,
      );

      print('Complete profile res: ${res['success']}');

      if (res['success'] == true) {
        Get.find<UserController>().userModel.value = UserModel.fromJson(
          res['data'],
        );
        Get.offAll(() => HomeScreen());
        Get.snackbar(
          'Welcome!',
          'Profile completed successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFF5AD6E0),
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          res['message'] ?? 'Failed to update profile',
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      print('Error completing profile: $e');
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    mobileCtrl.dispose();
    collegeCtrl.dispose();
    super.onClose();
  }
}
