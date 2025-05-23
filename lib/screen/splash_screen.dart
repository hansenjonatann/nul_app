import 'package:flutter/material.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/core.dart';
import 'package:nul_app/utils/image_dir.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed('/login');
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appPrimary,
        body: Center(child: Image.asset(ImageDir.splashImage)));
  }
}
