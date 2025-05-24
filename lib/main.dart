import 'package:get_storage/get_storage.dart';

import 'package:nul_app/core.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nul_app/utils/app_routes.dart';

void main() => runApp(NulApp());

final box = GetStorage();

class NulApp extends StatelessWidget {
  final token = box.read('token');
  NulApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: token == null ? const SplashScreen() : HomeScreen(),
      getPages: appRoutes,
    );
  }
}
