import 'package:codon/features/auth/controllers/forgot_password_controller.dart';
import 'package:codon/utills/constants.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:codon/utills/widgets/default_appbar.dart' show DefaultAppBar;
import 'package:flutter/material.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  bool isForChangePassword = false;
  ForgotPasswordScreen({super.key, required this.isForChangePassword});

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordController controller =
        Get.find<ForgotPasswordController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: isForChangePassword
          ? const DefaultAppBar(title: 'Change Password')
          : const DefaultAppBar(title: 'Forgot Password'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              SizedBox(height: 0.05.toHeightPercent()),

              // Logo Section
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
                isForChangePassword ? 'Change Password' : 'Forgot Password',
                style: TextStyle(
                  fontSize: 0.045.toWidthPercent(),
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 0.04.toHeightPercent()),

              // Phone Input
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.1.toWidthPercent()),
                child: TextField(
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter your Email',
                    hintStyle: TextStyle(fontSize: 0.04.toWidthPercent()),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 0.05.toWidthPercent(),
                      vertical: 0.015.toHeightPercent(),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.1.toWidthPercent()),
                      borderSide: const BorderSide(color: AppColors.primary),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.1.toWidthPercent()),
                      borderSide: const BorderSide(color: AppColors.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.1.toWidthPercent()),
                      borderSide: const BorderSide(color: AppColors.primary),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 0.04.toHeightPercent()),

              // Verify Button
              Obx(
                () => GestureDetector(
                  onTap: () => controller.isLoading.value
                      ? null
                      : controller.verifyPhone(
                          isForChangePassword: isForChangePassword,
                        ),
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
                          ? SizedBox(
                              height: 0.053.toWidthPercent(),
                              width: 0.053.toWidthPercent(),
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.black,
                                ),
                              ),
                            )
                          : Text(
                              'Verify',
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
            ],
          ),
        ),
      ),
    );
  }
}
