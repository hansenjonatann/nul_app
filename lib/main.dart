import 'package:get_storage/get_storage.dart';
import 'package:nul_app/core.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nul_app/screen/auth/umkm/login_screen.dart';

void main() => runApp(NulApp());

final box = GetStorage();

class NulApp extends StatelessWidget {
  var token = box.read('token');
  NulApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: token == null ? SplashScreen() : HomeScreen(),
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/register', page: () => RegisterScreen()),
        GetPage(name: '/umkm/login', page: () => UMKMLoginScreen()),
        GetPage(name: '/profile', page: () => ProfileScreen()),
        GetPage(name: '/card-detail', page: () => CardDetailScreen()),
        GetPage(name: '/activity-detail', page: () => ActivityDetailScreen()),
        GetPage(name: '/activity', page: () => ActivityScreen()),
        GetPage(name: '/favorite', page: () => FavoriteScreen())
      ],
    );
  }
}
