import 'package:codon/features/splash/controllers/splash_controller.dart';
import 'package:codon/utills/constants.dart';
import 'package:codon/utills/screen_size_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>(); // Ensure controller is initialized
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image (SVG)
          Positioned.fill(
            child: Image.asset(splashBackground, fit: BoxFit.cover),
          ),

          // Top Left Triangle Image
          Positioned(top: 0, left: 0, child: Image.asset(rectangle20888)),

          // Bottom Right Triangle Image
          Positioned(bottom: 0, right: 0, child: Image.asset(rectangle20889)),

          // Center Content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(appLogo, scale: 2.5),
                // Image.asset("assets/pngs/Test-me-logo.png", scale: 2.5),
                // Image.asset(appLogoText, scale: 3),
                // Logo Section
                // Container(
                //   width: 0.45.toWidthPercent(),
                //   height: 0.45.toWidthPercent(),
                //   decoration: const BoxDecoration(
                //     color: AppColors.primary,
                //     shape: BoxShape.circle,
                //   ),
                //   child: Center(
                //     // child: Text(
                //     //   'LOGO HERE',
                //     //   textAlign: TextAlign.center,
                //     //   style: TextStyle(
                //     //     fontSize: 0.055.toWidthPercent(),
                //     //     fontWeight: FontWeight.w900,
                //     //     color: Colors.black,
                //     //     letterSpacing: 1.2,
                //     //   ),
                //     // ),
                //     child: Image.asset(appLogo),
                //   ),
                // ),

                // SizedBox(height: 0.04.toHeightPercent()),

                // // App Name
                // Text(
                //   'CoDon',
                //   style: TextStyle(
                //     fontSize: 0.065.toWidthPercent(),
                //     fontWeight: FontWeight.bold,
                //     color: Colors.black,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
