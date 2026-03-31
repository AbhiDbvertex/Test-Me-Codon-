import 'package:codon/features/settings/controllers/change_password_controller.dart';
import 'package:codon/utills/constants.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:codon/utills/widgets/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangePasswordController controller =
        Get.find<ChangePasswordController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const DefaultAppBar(title: 'Change Password'),
      body: Column(
        children: [
          SizedBox(height: 0.02.toHeightPercent()),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 0.1.toWidthPercent()),
              child: Column(
                children: [
                  SizedBox(height: 0.05.toHeightPercent()),

                  // Illustration
                  Center(
                    child: SvgPicture.asset(
                      changePasswordImg,
                      width: 0.6.toWidthPercent(),
                      height: 0.25.toHeightPercent(),
                      fit: BoxFit.contain,
                    ),
                  ),

                  SizedBox(height: 0.06.toHeightPercent()),

                  // New Password Field
                  Obx(
                    () => _buildPasswordField(
                      controller: controller.newPasswordController,
                      hint: 'New Password',
                      isVisible: controller.isNewPasswordVisible.value,
                      onToggleVisibility:
                          controller.toggleNewPasswordVisibility,
                    ),
                  ),

                  SizedBox(height: 0.03.toHeightPercent()),

                  // Confirm New Password Field
                  Obx(
                    () => _buildPasswordField(
                      controller: controller.confirmPasswordController,
                      hint: 'Confirm New Password',
                      isVisible: controller.isConfirmPasswordVisible.value,
                      onToggleVisibility:
                          controller.toggleConfirmPasswordVisibility,
                    ),
                  ),

                  SizedBox(height: 0.06.toHeightPercent()),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(
                          vertical: 0.015.toHeightPercent(),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        elevation: 5,
                        shadowColor: AppColors.primary.withOpacity(0.5),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
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
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool isVisible,
    required VoidCallback onToggleVisibility,
  }) {
    return TextField(
      controller: controller,
      obscureText: !isVisible,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 18,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.black54,
          ),
          onPressed: onToggleVisibility,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: AppColors.primary, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }
}
