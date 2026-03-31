import 'package:codon/features/auth/screens/login_screen.dart';
import 'package:codon/features/home/screens/home_screen.dart';
import 'package:codon/utills/constants.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:codon/utills/app_theme.dart';
import 'package:get/get.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: 0.04.toWidthPercent(),
        vertical: 0.02.toHeightPercent(),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.1.toWidthPercent()),
      ),
      backgroundColor: Colors.white,
      child: Container(
        width: 1.toWidthPercent(),
        padding: EdgeInsets.symmetric(
          horizontal: 0.002.toWidthPercent(),
          vertical: 0.04.toHeightPercent(),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Illustration Placeholder (Circle with Icon)
            Image.asset(
              thanksDialogImage,
              height: 0.25.toHeightPercent(),
              width: 0.5.toWidthPercent(),
            ),

            SizedBox(height: 0.02.toHeightPercent()),

            // Thanks Title
            Text(
              'Thanks',
              style: TextStyle(
                fontSize: 0.06.toWidthPercent(),
                fontWeight: FontWeight.bold,
                color: AppColors.primary, // Cyan color
              ),
            ),

            SizedBox(height: 0.01.toHeightPercent()),

            // Subtitle
            Text(
              'Your registration successfully\ncreated',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 0.04.toWidthPercent(),
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 0.04.toHeightPercent()),

            // Ok Button
            SizedBox(
              width: 0.3.toWidthPercent(),
              height: 0.05.toHeightPercent(),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => LoginScreen()); // Navigate to Login
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary, // Cyan background
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.06.toWidthPercent()),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Ok',
                  style: TextStyle(
                    fontSize: 0.04.toWidthPercent(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
