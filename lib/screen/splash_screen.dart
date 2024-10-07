import 'package:flutter/material.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/screen/auth/register_screen.dart';
import 'package:nul_app/utils/image_dir.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  
  State<SplashScreen> createState() => _SplashScreenState();


}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed( const Duration(seconds: 5) , () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RegisterScreen() ));
    });
  }
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: appPrimary,
      body: Center(
        child: Image.asset('${ImageDir.splashImage}')
      )
    );
  }
}