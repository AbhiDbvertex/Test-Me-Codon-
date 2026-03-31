import 'package:codon/features/auth/screens/signup_screen.dart';
import 'package:codon/features/auth/screens/forgot_password_screen.dart';
import 'package:codon/features/auth/screens/verify_otp_screen.dart';
import 'package:codon/utills/constants.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

// Login Screen
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find<LoginController>();

    return Scaffold(
      backgroundColor: Colors.white, // Background is white in screenshot
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.06.toWidthPercent()),
            child: Column(
              children: [
                //SizedBox(height: 0.02.toHeightPercent()),
                // Row(
                //   children: [
                //     TextButton(
                //       onPressed: () {
                //         Get.to(() => VerifyOtpScreen());
                //       },
                //       child: Text(
                //         'Verify email',
                //         style: TextStyle(
                //           fontSize: 0.025.toWidthPercent(),
                //           fontWeight: FontWeight.w600,
                //           color: Colors.black54, // Slightly grey/muted
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 0.07.toHeightPercent()),

                // // Logo Circle
                // Image.asset(appLogo, scale: 3),
                // App Name
                Image.asset("assets/pngs/Test-me-logo.png", scale: 2.8),
                // Image.asset(appLogoText, scale: 2.8),

                SizedBox(height: 0.02.toHeightPercent()),

                // LogIn Header
                Text(
                  'LogIn',
                  style: TextStyle(
                    fontSize: 0.064.toWidthPercent(),
                    fontWeight: FontWeight.w600,
                    color: Colors.black54, // Slightly grey/muted
                  ),
                ),

                SizedBox(height: 0.04.toHeightPercent()),

                // Welcome Text
                Text(
                  'Please login to continue using our app',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 0.037.toWidthPercent(),
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 0.04.toHeightPercent()),

                // Email TextField
                TextField(
                  controller: controller.emailOrPhoneController,
                  style: TextStyle(fontSize: 0.04.toWidthPercent()),
                  decoration: InputDecoration(
                    hintText: 'Email or Phone Number',
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 0.04.toWidthPercent(),
                      fontWeight: FontWeight.bold, // Bold hint in screenshot
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 0.064.toWidthPercent(),
                      vertical: 0.025.toHeightPercent(),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        0.08.toWidthPercent(),
                      ),
                      borderSide: BorderSide(
                        color: AppColors.primary, // Cyan border
                        width: 0.004.toWidthPercent(),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        0.08.toWidthPercent(),
                      ),
                      borderSide: BorderSide(
                        color: AppColors.primary, // Cyan border visible
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

                SizedBox(height: 0.025.toHeightPercent()),

                // Password TextField
                Obx(
                  () => TextField(
                    controller: controller.passwordController,
                    obscureText: !controller.isPasswordVisible.value,
                    style: TextStyle(fontSize: 0.04.toWidthPercent()),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: 0.04.toWidthPercent(),
                        fontWeight: FontWeight.bold,
                      ),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 0.032.toWidthPercent()),
                        child: IconButton(
                          icon: Icon(
                            controller.isPasswordVisible.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.black26, // Very light grey icon
                            size: 0.053.toWidthPercent(),
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 0.064.toWidthPercent(),
                        vertical: 0.025.toHeightPercent(),
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
                ),

                SizedBox(height: 0.01.toHeightPercent()),
                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Get.to(() => VerifyOtpScreen());
                        },
                        child: Text(
                          'Verify email',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 0.035.toWidthPercent(),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(
                            () => ForgotPasswordScreen(
                              isForChangePassword: false,
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 0.035.toWidthPercent(),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 0.03.toHeightPercent()),

                // Login Button
                Obx(
                  () => Container(
                    width: double.infinity,
                    height: 0.07.toHeightPercent(),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        0.08.toWidthPercent(),
                      ),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black.withOpacity(0.2),
                      //     blurRadius: 6,
                      //     offset: const Offset(0, 3),
                      //   ),
                      // ],
                    ),
                    child: ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.black,
                        disabledBackgroundColor: AppColors.primary.withOpacity(
                          0.6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            0.08.toWidthPercent(),
                          ),
                        ),
                        elevation: 0,
                        shadowColor: Colors.transparent,
                      ),
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
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 0.043.toWidthPercent(),
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                              ),
                            ),
                    ),
                  ),
                ),

                // Container(
                //   width: double.infinity,
                //   height: 0.07.toHeightPercent(),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(0.08.toWidthPercent()),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.black.withOpacity(0.2),
                //         blurRadius: 6,
                //         offset: const Offset(0, 3),
                //       ),
                //     ],
                //   ),
                //   child: ElevatedButton(
                //     onPressed: controller.login,
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: AppColors.primary,
                //       foregroundColor: Colors.black, // Black text
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(
                //           0.08.toWidthPercent(),
                //         ),
                //       ),
                //       elevation:
                //           0, // Shadow handled by Container for better control or just use standard elevation
                //       shadowColor: Colors.transparent,
                //     ),
                //     child: Text(
                //       'LOGIN',
                //       style: TextStyle(
                //         fontSize: 0.043.toWidthPercent(),
                //         fontWeight: FontWeight.w800, // Very bold
                //         letterSpacing: 0.5,
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height: 0.03.toHeightPercent()),

                // Sign Up Text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account, ",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 0.035.toWidthPercent(),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4),
                        onTap: () {
                          Get.to(() => const SignUpScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          child: Text(
                            'Sign Up now.',
                            style: TextStyle(
                              color: Color(
                                0xFF26C6DA,
                              ), // Slightly darker cyan for text visibility
                              fontSize: 0.035.toWidthPercent(),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 0.03.toHeightPercent()),

                // Or
                Text(
                  'Or',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 0.043.toWidthPercent(),
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 0.03.toHeightPercent()),

                // Google Sign In Button
                InkWell(
                  onTap: controller.googleSignIn,
                  child: SvgPicture.asset(
                    googleIcon,
                    width: 0.13.toWidthPercent(),
                    height: 0.06.toHeightPercent(),
                    placeholderBuilder: (BuildContext context) => CircleAvatar(
                      radius: 0.06.toWidthPercent(),
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.g_mobiledata,
                        size: 0.1.toWidthPercent(),
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 0.05.toHeightPercent()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
