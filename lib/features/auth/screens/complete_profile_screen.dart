import 'dart:io';
import 'package:codon/features/auth/controllers/complete_profile_controller.dart';
import 'package:codon/features/auth/models/select_location_model.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CompleteProfileController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF4FAFB),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Column(
          children: [
            // ── Gradient Header ──────────────────────────────────────────
            _buildHeader(context, controller),

            // ── Form Body ────────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 0.05.toWidthPercent(),
                  vertical: 0.025.toHeightPercent(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionLabel('Personal Info'),
                    SizedBox(height: 0.015.toHeightPercent()),

                    // Name
                    _buildTextField(
                      controller: controller.nameCtrl,
                      hint: 'Full Name',
                      icon: Icons.person_outline_rounded,
                    ),
                    SizedBox(height: 0.018.toHeightPercent()),

                    // Email (read-only if pre-filled)
                    _buildTextField(
                      controller: controller.emailCtrl,
                      hint: 'Email Address',
                      icon: Icons.email_outlined,
                      readOnly: controller.emailCtrl.text.isNotEmpty,
                      suffixIcon: controller.emailCtrl.text.isNotEmpty
                          ? const Icon(
                              Icons.verified_rounded,
                              color: Color(0xFF5AD6E0),
                              size: 20,
                            )
                          : null,
                    ),

                    SizedBox(height: 0.018.toHeightPercent()),

                    // Mobile
                    _buildTextField(
                      controller: controller.mobileCtrl,
                      hint: 'Mobile Number',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    SizedBox(height: 0.03.toHeightPercent()),

                    _sectionLabel('Location'),
                    SizedBox(height: 0.015.toHeightPercent()),

                    // State Dropdown
                    Obx(
                      () => _buildDropdown<String>(
                        hint: 'Select State',
                        icon: Icons.location_on_outlined,
                        value:
                            controller.states.any(
                              (s) => s.id == controller.selectedState.value,
                            )
                            ? controller.selectedState.value
                            : null,
                        items: controller.states
                            .map(
                              (LocationModel s) => DropdownMenuItem<String>(
                                value: s.id,
                                child: Text(
                                  s.name,
                                  style: const TextStyle(
                                    color: Color(0xFF212121),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (val) {
                          if (val != null) {
                            controller.selectedState.value = val;
                            controller.getCities(val);
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 0.018.toHeightPercent()),

                    // City Dropdown
                    Obx(
                      () => _buildDropdown<String>(
                        hint: 'Select City',
                        icon: Icons.location_city_outlined,
                        value:
                            controller.cities.any(
                              (c) => c.id == controller.selectedCity.value,
                            )
                            ? controller.selectedCity.value
                            : null,
                        items: controller.cities
                            .map(
                              (LocationModel c) => DropdownMenuItem<String>(
                                value: c.id,
                                child: Text(
                                  c.name,
                                  style: const TextStyle(
                                    color: Color(0xFF212121),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (val) => controller.selectedCity.value = val,
                        disabledHint: controller.selectedState.value == null
                            ? 'Select State first'
                            : 'No cities available',
                      ),
                    ),
                    SizedBox(height: 0.03.toHeightPercent()),

                    _sectionLabel('Academic Info'),
                    SizedBox(height: 0.015.toHeightPercent()),

                    // College
                    _buildTextField(
                      controller: controller.collegeCtrl,
                      hint: 'College / Institution Name',
                      icon: Icons.school_outlined,
                    ),
                    SizedBox(height: 0.018.toHeightPercent()),

                    // Passing Year Dropdown
                    Obx(
                      () => _buildDropdown<String>(
                        hint: 'Year of 12th Passing',
                        icon: Icons.calendar_today_outlined,
                        value:
                            controller.years.contains(
                              controller.selectedYear.value,
                            )
                            ? controller.selectedYear.value
                            : null,
                        items: controller.years
                            .map(
                              (y) => DropdownMenuItem<String>(
                                value: y,
                                child: Text(
                                  y,
                                  style: const TextStyle(
                                    color: Color(0xFF212121),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (val) => controller.selectedYear.value = val,
                      ),
                    ),
                    SizedBox(height: 0.04.toHeightPercent()),

                    // Submit Button
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        height: 0.065.toHeightPercent(),
                        child: ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : controller.completeProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: AppColors.primary
                                .withOpacity(0.6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                0.04.toWidthPercent(),
                              ),
                            ),
                            elevation: 4,
                            shadowColor: AppColors.primary.withOpacity(0.4),
                          ),
                          child: controller.isLoading.value
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.check_circle_outline_rounded,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Complete Profile',
                                      style: TextStyle(
                                        fontSize: 0.042.toWidthPercent(),
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: 0.04.toHeightPercent()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Header with gradient + avatar ────────────────────────────────────────
  Widget _buildHeader(
    BuildContext context,
    CompleteProfileController controller,
  ) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF5AD6E0), Color(0xFF2BB5C2)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      padding: EdgeInsets.only(
        top: topPadding + 16,
        bottom: 28,
        left: 20,
        right: 20,
      ),
      child: Column(
        children: [
          // Title row
          Row(
            children: [
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Complete Your Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Fill in the details to get started',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Avatar
          Obx(
            () => GestureDetector(
              onTap: () => _showImagePickerSheet(controller),
              child: Stack(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipOval(child: _buildAvatarImage(controller)),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        size: 16,
                        color: Color(0xFF2BB5C2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarImage(CompleteProfileController controller) {
    if (controller.profileImage.value != null) {
      return Image.file(
        controller.profileImage.value!,
        fit: BoxFit.cover,
        width: 90,
        height: 90,
      );
    }
    if (controller.profileImageUrl.value.isNotEmpty) {
      return Image.network(
        controller.profileImageUrl.value,
        fit: BoxFit.cover,
        width: 90,
        height: 90,
        errorBuilder: (_, __, ___) => _defaultAvatar(controller),
      );
    }
    return _defaultAvatar(controller);
  }

  Widget _defaultAvatar(CompleteProfileController controller) {
    final name = controller.nameCtrl.text;
    final initials = name.isNotEmpty ? name[0].toUpperCase() : '?';
    return Container(
      width: 90,
      height: 90,
      color: const Color(0xFF2BB5C2),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ── Section label ─────────────────────────────────────────────────────────
  Widget _sectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 2),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: Color(0xFF2BB5C2),
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  // ── Reusable TextField ────────────────────────────────────────────────────
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool readOnly = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        keyboardType: keyboardType,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF212121),
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFFBDBDBD), fontSize: 14),
          prefixIcon: Icon(icon, color: const Color(0xFF5AD6E0), size: 20),
          suffixIcon: suffixIcon,
          counterText: '',
          filled: true,
          fillColor: readOnly ? const Color(0xFFF8FDFD) : Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE0F7FA), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE0F7FA), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF5AD6E0), width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  // ── Reusable Dropdown ──────────────────────────────────────────────────────
  Widget _buildDropdown<T>({
    required String hint,
    required IconData icon,
    required T? value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
    String? disabledHint,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonFormField<T>(
        value: value,
        items: items,
        onChanged: items.isEmpty ? null : onChanged,
        isExpanded: true,
        disabledHint: Text(
          disabledHint ?? hint,
          style: const TextStyle(color: Color(0xFFBDBDBD), fontSize: 14),
        ),
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Color(0xFF5AD6E0),
        ),
        style: const TextStyle(
          color: Color(0xFF212121),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        dropdownColor: Colors.white,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFFBDBDBD), fontSize: 14),
          prefixIcon: Icon(icon, color: const Color(0xFF5AD6E0), size: 20),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE0F7FA), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE0F7FA), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF5AD6E0), width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
        ),
      ),
    );
  }

  // ── Image Picker Bottom Sheet ─────────────────────────────────────────────
  void _showImagePickerSheet(CompleteProfileController controller) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Change Profile Photo',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF212121),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _imageSourceButton(
                    icon: Icons.camera_alt_rounded,
                    label: 'Camera',
                    onTap: () {
                      Get.back();
                      controller.pickImage(ImageSource.camera);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _imageSourceButton(
                    icon: Icons.photo_library_rounded,
                    label: 'Gallery',
                    onTap: () {
                      Get.back();
                      controller.pickImage(ImageSource.gallery);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _imageSourceButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF4FAFB),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE0F7FA)),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF5AD6E0), size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF424242),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
