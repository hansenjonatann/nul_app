import 'package:nul_app/core.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nul_app/core/navigation.dart';
import 'package:nul_app/screen/splash_screen.dart';

void main () => runApp(const NulApp());

class NulApp extends StatelessWidget {
  const NulApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: NullAppNavigation.routes,
      navigatorKey: NullAppNavigation.navigatorKey,

    );
  }
}