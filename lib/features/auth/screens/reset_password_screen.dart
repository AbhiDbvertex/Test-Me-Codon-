import 'package:codon/features/auth/controllers/reset_password_controller.dart';
import 'package:codon/utills/constants.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:codon/utills/widgets/default_appbar.dart' show DefaultAppBar;
import 'package:flutter/material.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  bool isForChangePassword = false;
  ResetPasswordScreen({
    super.key,
    required this.email,
    required this.isForChangePassword,
  });
  final String email;

  @override
  Widget build(BuildContext context) {
    final ResetPasswordController controller =
        Get.find<ResetPasswordController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: isForChangePassword
          ? const DefaultAppBar(title: 'Forgot Password')
          : const DefaultAppBar(title: 'Change Password'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 0.05.toHeightPercent()),

              // Logo Section
              // Center(
              //   child: Container(
              //     width: 0.4.toWidthPercent(),
              //     height: 0.4.toWidthPercent(),
              //     decoration: const BoxDecoration(
              //       color: AppColors.primary,
              //       shape: BoxShape.circle,
              //     ),
              //     child: Center(
              //       child: Text(
              //         'LOGO HERE',
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //           fontSize: 0.05.toWidthPercent(),
              //           fontWeight: FontWeight.bold,
              //           color: Colors.black,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Center(
                child: SvgPicture.asset(
                  changePasswordImg,
                  width: 0.6.toWidthPercent(),
                  height: 0.25.toHeightPercent(),
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 0.03.toHeightPercent()),

              Text(
                'Codon',
                style: TextStyle(
                  fontSize: 0.06.toWidthPercent(),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 0.04.toHeightPercent()),
              Text(
                isForChangePassword ? 'Forgot Password' : 'Change Password',
                style: TextStyle(
                  fontSize: 0.045.toWidthPercent(),
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 0.04.toHeightPercent()),

              // OTP Input
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.1.toWidthPercent()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      controller: controller.otpController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter OTP',
                        hintStyle: TextStyle(fontSize: 0.04.toWidthPercent()),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 0.05.toWidthPercent(),
                          vertical: 0.015.toHeightPercent(),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            0.1.toWidthPercent(),
                          ),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            0.1.toWidthPercent(),
                          ),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            0.1.toWidthPercent(),
                          ),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => controller.resendOtp(email),
                      child: Text(
                        'Resend',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 0.035.toWidthPercent(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 0.02.toHeightPercent()),

              // New Password Input
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.1.toWidthPercent()),
                child: Obx(
                  () => TextField(
                    controller: controller.newPasswordController,
                    obscureText: !controller.isNewPasswordVisible.value,
                    decoration: InputDecoration(
                      hintText: 'New Password',
                      hintStyle: TextStyle(fontSize: 0.04.toWidthPercent()),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 0.032.toWidthPercent()),
                        child: IconButton(
                          icon: Icon(
                            controller.isNewPasswordVisible.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.black26, // Very light grey icon
                            size: 0.053.toWidthPercent(),
                          ),
                          onPressed: controller.toggleNewPasswordVisibility,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 0.05.toWidthPercent(),
                        vertical: 0.015.toHeightPercent(),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          0.1.toWidthPercent(),
                        ),
                        borderSide: const BorderSide(color: AppColors.primary),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          0.1.toWidthPercent(),
                        ),
                        borderSide: const BorderSide(color: AppColors.primary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          0.1.toWidthPercent(),
                        ),
                        borderSide: const BorderSide(color: AppColors.primary),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 0.03.toHeightPercent()),

              // Confirm New Password Input
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.1.toWidthPercent()),
                child: Obx(
                  () => TextField(
                    controller: controller.confirmPasswordController,
                    obscureText: !controller.isConfirmPasswordVisible.value,
                    decoration: InputDecoration(
                      hintText: 'Confirm New Password',
                      hintStyle: TextStyle(fontSize: 0.04.toWidthPercent()),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 0.032.toWidthPercent()),
                        child: IconButton(
                          icon: Icon(
                            controller.isConfirmPasswordVisible.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.black26, // Very light grey icon
                            size: 0.053.toWidthPercent(),
                          ),
                          onPressed: controller.toggleConfirmPasswordVisibility,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 0.05.toWidthPercent(),
                        vertical: 0.015.toHeightPercent(),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          0.1.toWidthPercent(),
                        ),
                        borderSide: const BorderSide(color: AppColors.primary),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          0.1.toWidthPercent(),
                        ),
                        borderSide: const BorderSide(color: AppColors.primary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          0.1.toWidthPercent(),
                        ),
                        borderSide: const BorderSide(color: AppColors.primary),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 0.04.toHeightPercent()),

              // Verify Button
              Obx(
                () => GestureDetector(
                  onTap: controller.isLoading.value
                      ? null
                      : () => controller.resetPassword(email),
                  child: Container(
                    width: 0.8.toWidthPercent(),
                    padding: EdgeInsets.symmetric(
                      vertical: 0.015.toHeightPercent(),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(
                        0.05.toWidthPercent(),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.black)
                          : Text(
                              'Change Password',
                              style: TextStyle(
                                fontSize: 0.04.toWidthPercent(),
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 0.05.toHeightPercent()),
            ],
          ),
        ),
      ),
    );
  }
}
