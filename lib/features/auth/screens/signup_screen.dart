import 'package:codon/features/auth/models/select_location_model.dart';
import 'package:codon/utills/constants.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:codon/utills/widgets/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<SignUpController>().getStates();
  }

  @override
  Widget build(BuildContext context) {
    final SignUpController controller = Get.find<SignUpController>();

    InputDecoration buildInputDecoration(String hint, {Widget? suffixIcon}) {
      return InputDecoration(
        hintText: hint,
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(
          color: Colors.black54,
          fontSize: 0.04.toWidthPercent(),
          fontWeight: FontWeight.bold,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 0.064.toWidthPercent(),
          vertical: 0.02.toHeightPercent(),
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.08.toWidthPercent()),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 0.004.toWidthPercent(),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.08.toWidthPercent()),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 0.004.toWidthPercent(),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.08.toWidthPercent()),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 0.005.toWidthPercent(),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const DefaultAppBar(title: 'Sign up'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 0.06.toWidthPercent()),
          child: Column(
            children: [
              SizedBox(height: 0.03.toHeightPercent()),

              // Form Fields
              TextField(
                controller: controller.firstNameController,
                style: TextStyle(fontSize: 0.04.toWidthPercent()),
                decoration: buildInputDecoration('Enter First Name'),
              ),
              SizedBox(height: 0.02.toHeightPercent()),

              TextField(
                controller: controller.emailController,
                style: TextStyle(fontSize: 0.04.toWidthPercent()),
                decoration: buildInputDecoration('Enter your Email Address'),
              ),
              SizedBox(height: 0.02.toHeightPercent()),

              TextField(
                maxLength: 10,
                controller: controller.mobileController,
                keyboardType: TextInputType.phone,
                style: TextStyle(fontSize: 0.04.toWidthPercent()),
                decoration: buildInputDecoration('Enter Mobile Number'),
              ),
              SizedBox(height: 0.02.toHeightPercent()),

              // TextField(
              //   controller: controller.addressController,
              //   style: TextStyle(fontSize: 0.04.toWidthPercent()),
              //   decoration: buildInputDecoration('Enter Your Address'),
              // ),
              SizedBox(height: 0.02.toHeightPercent()),

              // Dropdowns
              Obx(
                () => DropdownButtonFormField<String>(
                  initialValue:
                      controller.states.any(
                        (element) =>
                            element.id == controller.selectedState.value,
                      )
                      ? controller.selectedState.value
                      : null,
                  items: controller.states.map((LocationModel value) {
                    return DropdownMenuItem<String>(
                      value: value.id,
                      child: Text(value.name),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    controller.selectedState.value = newValue;
                    if (newValue != null) controller.getCities(newValue);
                  },
                  decoration: buildInputDecoration('Select Your State'),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(height: 0.02.toHeightPercent()),

              Obx(
                () => DropdownButtonFormField<String>(
                  initialValue:
                      controller.cities.any(
                        (element) =>
                            element.id == controller.selectedCity.value,
                      )
                      ? controller.selectedCity.value
                      : null,
                  items: controller.cities.map((LocationModel value) {
                    return DropdownMenuItem<String>(
                      value: value.id,
                      child: Text(value.name),
                    );
                  }).toList(),
                  onChanged: (newValue) =>
                      controller.selectedCity.value = newValue,
                  decoration: buildInputDecoration('Select Your City'),
                  // hint:Text("Select Your City") ,
                  disabledHint: const Text("No City Available"),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(height: 0.02.toHeightPercent()),

              TextField(
                controller: controller.collegeController,
                style: TextStyle(fontSize: 0.04.toWidthPercent()),
                decoration: buildInputDecoration('Enter your College'),
              ),
              SizedBox(height: 0.02.toHeightPercent()),

              DropdownButtonFormField<String>(
                initialValue: controller.selectedYear.value,
                items: controller.years.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) =>
                    controller.selectedYear.value = newValue!,
                decoration: buildInputDecoration(
                  'Select year of 12 the passed?',
                ),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 0.02.toHeightPercent()),

              // Passwords
              Obx(
                () => TextField(
                  controller: controller.passwordController,
                  obscureText: !controller.isPasswordVisible.value,
                  style: TextStyle(fontSize: 0.04.toWidthPercent()),
                  decoration: buildInputDecoration(
                    'Enter Password',
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 0.032.toWidthPercent()),
                      child: IconButton(
                        icon: Icon(
                          controller.isPasswordVisible.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors
                              .black26, // Login screen jaisa light grey icon
                          size: 0.053.toWidthPercent(),
                        ),
                        onPressed: () => controller.isPasswordVisible.toggle(),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 0.02.toHeightPercent()),

              Obx(
                () => TextField(
                  controller: controller.confirmPasswordController,
                  obscureText: !controller.isConfirmPasswordVisible.value,
                  style: TextStyle(fontSize: 0.04.toWidthPercent()),
                  decoration: buildInputDecoration(
                    'Enter Confirm Password',
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 0.032.toWidthPercent()),
                      child: IconButton(
                        icon: Icon(
                          controller.isConfirmPasswordVisible.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.black26,
                          size: 0.053.toWidthPercent(),
                        ),
                        onPressed: () =>
                            controller.isConfirmPasswordVisible.toggle(),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 0.04.toHeightPercent()),

              // Signup Button
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 0.07.toHeightPercent(),
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.signUp,
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
                      elevation: 5,
                      shadowColor: Colors.black.withOpacity(0.2),
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
                            'Signup',
                            style: TextStyle(
                              fontSize: 0.045.toWidthPercent(),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),

              SizedBox(height: 0.02.toHeightPercent()),

              // Login Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 0.035.toWidthPercent(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 0.035.toWidthPercent(),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              if (!GetPlatform.isIOS) ...[
                SizedBox(height: 0.02.toHeightPercent()),

                const Text(
                  'Or',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 0.02.toHeightPercent()),

                // Google Sign In
                InkWell(
                  onTap: controller.googleSignIn,
                  child: SvgPicture.asset(
                    googleIcon,
                    width: 0.13.toWidthPercent(),
                    height: 0.06.toHeightPercent(),
                    placeholderBuilder:
                        (BuildContext context) => CircleAvatar(
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
              ],
              SizedBox(height: 0.05.toHeightPercent()),
            ],
          ),
        ),
      ),
    );
  }
}
