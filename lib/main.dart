import 'package:get_storage/get_storage.dart';
import 'package:nul_app/core.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nul_app/screen/auth/umkm/location_screen.dart';
import 'package:nul_app/screen/auth/umkm/login_screen.dart';
import 'package:nul_app/screen/auth/umkm/register_screen.dart';
import 'package:nul_app/screen/location_detail_screen.dart';
import 'package:nul_app/screen/umkm/main_screen.dart';

void main() => runApp(NulApp());

final box = GetStorage();

class NulApp extends StatelessWidget {
  final AuthController _authC = Get.put(AuthController(), permanent: true);
  final token = box.read('token');
  NulApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: token == null ? const SplashScreen() : HomeScreen(),
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/register', page: () => RegisterScreen()),
        GetPage(name: '/umkm/login', page: () => const UMKMLoginScreen()),
        GetPage(name: '/umkm/register', page: () => UMKMRegisterScreen()),
        GetPage(name: '/profile', page: () => ProfileScreen()),
        GetPage(name: '/card-detail', page: () => CardDetailScreen()),
        GetPage(name: '/activity-detail', page: () => ActivityDetailScreen()),
        GetPage(name: '/activity', page: () => ActivityScreen()),
        GetPage(name: '/favorite', page: () => FavoriteScreen()),
        GetPage(name: '/umkm/main', page: () => UMKMMainScreen()),
        GetPage(name: '/umkm/location', page: () => UMKMLocationScreen()),
        GetPage(name: '/category-detail', page: () => CategoryDetailScreen()),
        GetPage(name: '/location-detail', page: () => LocationDetailScreen()),
      ],
    );
  }
}
