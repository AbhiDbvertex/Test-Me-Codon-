import 'dart:io';
import 'package:codon/features/auth/controllers/user_controller.dart';
import 'package:codon/features/auth/models/select_location_model.dart';
import 'package:codon/features/auth/models/user_model.dart';
import 'package:codon/features/auth/services/location_service.dart';
import 'package:codon/features/settings/services/setting_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  // Text Controllers
  late TextEditingController firstNameCtrl;
  late TextEditingController mobileCtrl;
  late TextEditingController addressCtrl;
  late TextEditingController collegeCtrl;

  // Dropdown values
  final selectedCountry = ''.obs;
  final selectedState = ''.obs;
  final selectedCity = ''.obs;
  final selectedClass = ''.obs;
  final selectedYear = ''.obs;

  // Profile image
  final Rx<File?> profileImage = Rx<File?>(null);
  final profileImageUrl = ''.obs;

  // Loading
  final isLoading = false.obs;

  // Data lists
  final states = <LocationModel>[].obs;
  final cities = <LocationModel>[].obs;
  final years = List.generate(12, (i) => (2028 - i).toString()).obs;

  // Services
  final LocationService _locationService = Get.find<LocationService>();
  final SettingService _settingService = Get.find<SettingService>();
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();

    firstNameCtrl = TextEditingController();
    mobileCtrl = TextEditingController();
    addressCtrl = TextEditingController();
    collegeCtrl = TextEditingController();

    _loadUserData();
    getStates();
  }

  void _loadUserData() {
    final user = Get.find<UserController>().userModel.value;
    if (user == null) return;

    firstNameCtrl.text = user.name ?? '';
    mobileCtrl.text = user.mobile ?? '';
    addressCtrl.text = user.address ?? '';
    collegeCtrl.text = user.college?.name ?? '';
    selectedCountry.value = user.countryId ?? '';
    selectedState.value = user.state?.id ?? '';
    selectedCity.value = user.city?.id ?? '';
    selectedClass.value = user.classId ?? '';
    selectedYear.value = user.passingYear.toString() ?? '';

    profileImageUrl.value = user.profileImage ?? '';

    if (selectedState.value.isNotEmpty) {
      getCities(selectedState.value);
    }
  }

  Future<void> getStates() async {
    final res = await _locationService.getStates();
    if (res['success'] == true) {
      states.assignAll(LocationResponse.fromJson(res).data);
    }
  }

  Future<void> getCities(String stateId) async {
    if (stateId.isEmpty) return;
    final res = await _locationService.getCities(stateId: stateId);
    if (res['success'] == true) {
      cities.assignAll(LocationResponse.fromJson(res).data);
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final image = await _picker.pickImage(
      source: source,
      maxWidth: 1080,
      maxHeight: 1080,
      imageQuality: 85,
    );
    if (image != null) {
      profileImage.value = File(image.path);
    }
  }

  bool _validate() {
    if (firstNameCtrl.text.isEmpty ||
        mobileCtrl.text.isEmpty ||
        addressCtrl.text.isEmpty ||
        selectedState.value.isEmpty ||
        selectedCity.value.isEmpty) {
      Get.snackbar('Error', 'Please fill all required fields');
      return false;
    }
    return true;
  }

  Future<void> updateProfile() async {
    if (!_validate()) return;

    isLoading.value = true;
    try {
      final res = await _settingService.updateProfile(
        name: firstNameCtrl.text.trim(),
        mobile: mobileCtrl.text.trim(),
        address: addressCtrl.text.trim(),
        countryId: selectedCountry.value.isNotEmpty
            ? selectedCountry.value
            : '6967b961d48b7381354d28eb',
        stateId: selectedState.value,
        cityId: selectedCity.value,
        collegeId: collegeCtrl.text.trim(),
        classId: selectedClass.value,
        passingYear: selectedYear.value,
        image: profileImage.value,
      );
      print("update profile res:- ${res['success']}");
      if (res['success']) {
        //Get.snackbar('Success', res['message'] ?? 'Profile updated');
        Get.find<UserController>().userModel.value = UserModel.fromJson(
          res["data"],
        );
        //Get.snackbar('Success', 'Profile updated');
        Get.back();
        Get.snackbar(
          'Success',
          'Profile updated',
          snackPosition: SnackPosition.TOP,
        );
      } else {
        Get.snackbar('Error', res['message'] ?? 'Update failed');
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    firstNameCtrl.dispose();
    mobileCtrl.dispose();
    addressCtrl.dispose();
    collegeCtrl.dispose();
    super.onClose();
  }
}
