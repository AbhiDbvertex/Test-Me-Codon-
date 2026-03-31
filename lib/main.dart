import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/home/screens/home_screen.dart';
import 'features/splash/screens/splash_screen.dart';
import 'utills/app_theme.dart';
import 'utills/initial_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  InitialBinding.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // yash
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Codon',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
      // home:   HomeScreen(),
    );
  }
}
