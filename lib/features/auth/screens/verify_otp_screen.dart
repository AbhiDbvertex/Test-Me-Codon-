import 'package:codon/features/auth/controllers/verify_otp_controller.dart';
import 'package:codon/utills/constants.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:codon/utills/widgets/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:get/get.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final VerifyOtpController controller = Get.find<VerifyOtpController>();

    final args = Get.arguments;
    String email = args["email"];
    String password = args["password"];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const DefaultAppBar(title: 'Verify'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 0.06.toWidthPercent()),
          child: Obx(
            () => Column(
              children: [
                SizedBox(height: 0.04.toHeightPercent()),

                // Illustration
                Image.asset(
                  verifyOtpImage,
                  height: 0.25.toHeightPercent(),
                  width: 0.5.toWidthPercent(),
                ),

                SizedBox(height: 0.04.toHeightPercent()),

                if (controller.showEmailInput.value) ...[
                  // Email mode
                  Text(
                    "Enter your email to receive a verification code",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 0.045.toWidthPercent(),
                    ),
                  ),
                  SizedBox(height: 0.04.toHeightPercent()),
                  TextField(
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 0.04.toWidthPercent()),
                    decoration: InputDecoration(
                      hintText: 'Enter Email Address',
                      hintStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: 0.035.toWidthPercent(),
                        fontWeight: FontWeight.bold,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0.02.toHeightPercent(),
                        horizontal: 0.04.toWidthPercent(),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          0.08.toWidthPercent(),
                        ),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 0.004.toWidthPercent(),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          0.08.toWidthPercent(),
                        ),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 0.004.toWidthPercent(),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          0.08.toWidthPercent(),
                        ),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 0.005.toWidthPercent(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 0.04.toHeightPercent()),
                  SizedBox(
                    width: 0.8.toWidthPercent(),
                    height: 0.06.toHeightPercent(),
                    child: ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.sendVerificationEmail,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            0.06.toWidthPercent(),
                          ),
                        ),
                        elevation: 5,
                        shadowColor: Colors.black.withOpacity(0.2),
                      ),
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.black)
                          : Text(
                              'Send Code',
                              style: TextStyle(
                                fontSize: 0.04.toWidthPercent(),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ] else ...[
                  // OTP mode
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 0.05.toWidthPercent(),
                      ),
                      children: [
                        const TextSpan(
                          text: "We've sent a verification code to\n",
                        ),
                        TextSpan(
                          text: controller.emailController.text,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.showEmailInput.value = true,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Change Email',
                        style: TextStyle(
                          fontSize: 0.035.toWidthPercent(),
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 0.05.toHeightPercent()),

                  // OTP Input
                  TextField(
                    controller: controller.otpController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 0.04.toWidthPercent()),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Please enter OTP',
                      hintStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: 0.035.toWidthPercent(),
                        fontWeight: FontWeight.bold,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0.02.toHeightPercent(),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          0.08.toWidthPercent(),
                        ),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 0.004.toWidthPercent(),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          0.08.toWidthPercent(),
                        ),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 0.004.toWidthPercent(),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          0.08.toWidthPercent(),
                        ),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 0.005.toWidthPercent(),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 0.015.toHeightPercent()),

                  // Resend
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: controller.resendOtp,
                      child: Text(
                        'Resend',
                        style: TextStyle(
                          fontSize: 0.035.toWidthPercent(),
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 0.04.toHeightPercent()),

                  // Verify Button
                  SizedBox(
                    width: 0.8
                        .toWidthPercent(), // Smaller width based on design
                    height: 0.06.toHeightPercent(),
                    child: ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () => controller.verifyOtp(
                              email: controller.emailController.text,
                        password: password
                            ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            0.06.toWidthPercent(),
                          ),
                        ),
                        elevation: 5,
                        shadowColor: Colors.black.withOpacity(0.2),
                      ),
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.black)
                          : Text(
                              'Verify',
                              style: TextStyle(
                                fontSize: 0.04.toWidthPercent(),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],

                SizedBox(height: 0.05.toHeightPercent()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
