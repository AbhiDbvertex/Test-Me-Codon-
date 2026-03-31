import 'dart:io';
import 'package:codon/features/auth/models/select_location_model.dart';
import 'package:codon/features/settings/controllers/edit_profile_controller.dart';
import 'package:codon/utills/api_urls.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:codon/utills/constants.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:codon/utills/widgets/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final controller = Get.find<EditProfileController>();

  @override
  Widget build(BuildContext context) {
    print(controller.profileImage.value);
    return Scaffold(
      appBar: const DefaultAppBar(title: 'Edit Profile'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 0.08.toWidthPercent()),
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// Profile Image
            Obx(
              () => Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: controller.profileImage.value != null
                        ? FileImage(controller.profileImage.value!)
                        : (controller.profileImageUrl.value.isNotEmpty
                                  ? NetworkImage(
                                      baseUrl +
                                          controller.profileImageUrl.value,
                                    )
                                  : const AssetImage(profilePlaceholder))
                              as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 18,
                        ),
                        onPressed: () => _showImagePicker(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// Text Fields
            _buildTextField(
              hint: 'Name',
              initialValue: controller.firstNameCtrl.text,
              onChanged: (v) => controller.firstNameCtrl.text = v,
            ),
            _buildTextField(
              hint: 'Mobile',
              keyboardType: TextInputType.phone,
              initialValue: controller.mobileCtrl.text,
              onChanged: (v) => controller.mobileCtrl.text = v,
              length: 10,
            ),
            _buildTextField(
              hint: 'Address',
              initialValue: controller.addressCtrl.text,
              onChanged: (v) => controller.addressCtrl.text = v,
            ),
            _buildTextField(
              hint: 'College',
              initialValue: controller.collegeCtrl.text,
              onChanged: (v) => controller.collegeCtrl.text = v,
            ),

            /// State
            Obx(
              () => _locationDropdown(
                hint: 'Select State',
                value: controller.selectedState.value.isEmpty
                    ? null
                    : controller.selectedState.value,
                items: controller.states,
                onChanged: (val) {
                  controller.selectedState.value = val!;
                  controller.getCities(val);
                },
              ),
            ),

            /// City
            Obx(
              () => _locationDropdown(
                hint: 'Select City',
                value: controller.selectedCity.value.isEmpty
                    ? null
                    : controller.selectedCity.value,
                items: controller.cities,
                onChanged: (val) => controller.selectedCity.value = val!,
              ),
            ),

            /// Passing Year
            Obx(() => _yearDropdown()),

            const SizedBox(height: 30),

            /// Save Button
            Obx(
              () => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  fixedSize: Size(0.8.toWidthPercent(), 0.08.toHeightPercent()),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: controller.isLoading.value
                    ? null
                    : controller.updateProfile,
                child: controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text('Save', style: TextStyle(fontSize: 16)),
              ),
            ),
            SizedBox(height: 0.08.toHeightPercent()),
          ],
        ),
      ),
    );
  }

  /// ðŸ”¹ SHARED BORDER (same as TextField)
  InputDecoration _dropdownDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: const BorderSide(color: AppColors.primary, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
    );
  }

  /// ðŸ”¹ TEXT FIELD (unchanged)
  Widget _buildTextField({
    required String hint,
    required Function(String) onChanged,
    String initialValue = '',
    TextInputType? keyboardType,
    int? length,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 0.02.toHeightPercent()),
      child: TextFormField(
        maxLength: length,
        key: ValueKey(initialValue),
        initialValue: initialValue,
        onChanged: onChanged,
        keyboardType: keyboardType,
        decoration: _dropdownDecoration(hint),
      ),
    );
  }

  /// ðŸ”¹ STATE / CITY DROPDOWN
  Widget _locationDropdown({
    required String hint,
    required String? value,
    required List<LocationModel> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 0.02.toHeightPercent()),
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: onChanged,
        decoration: _dropdownDecoration(hint),
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
        items: items
            .map((e) => DropdownMenuItem(value: e.id, child: Text(e.name)))
            .toList(),
      ),
    );
  }

  /// ðŸ”¹ PASSING YEAR DROPDOWN
  Widget _yearDropdown() {
    return Container(
      margin: EdgeInsets.only(bottom: 0.02.toHeightPercent()),
      child: DropdownButtonFormField<String>(
        initialValue:
            (controller.selectedYear.value.isNotEmpty &&
                controller.years.contains(controller.selectedYear.value))
            ? controller.selectedYear.value
            : null,
        onChanged: (v) => controller.selectedYear.value = v!,
        decoration: _dropdownDecoration('Passing Year'),
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
        items: controller.years
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
      ),
    );
  }

  /// ðŸ”¹ IMAGE PICKER
  void _showImagePicker(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Drag Handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Get.back();
                  controller.pickImage(ImageSource.gallery);
                },
              ),

              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take Photo'),
                onTap: () {
                  Get.back();
                  controller.pickImage(ImageSource.camera);
                },
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
