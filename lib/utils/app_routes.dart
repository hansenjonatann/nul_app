import 'package:get/get.dart';
import 'package:nul_app/bindings/auth/auth_binding.dart';
import 'package:nul_app/bindings/features/booking_binding.dart';
import 'package:nul_app/bindings/features/category_binding.dart';
import 'package:nul_app/bindings/features/umkm/umkm_auth_binding.dart';
import 'package:nul_app/bindings/features/umkm/umkm_binding.dart';
import 'package:nul_app/bindings/features/umkm/umkm_location_binding.dart';
import 'package:nul_app/bindings/features/umkm/umkm_report_binding.dart';
import 'package:nul_app/bindings/home_binding.dart';
import 'package:nul_app/controller/more_screen.dart';
import 'package:nul_app/core.dart';
import 'package:nul_app/screen/auth/umkm/login_screen.dart';
import 'package:nul_app/screen/auth/umkm/register_screen.dart';
import 'package:nul_app/screen/booking_screen.dart';
import 'package:nul_app/screen/edit_profile_screen.dart';
import 'package:nul_app/screen/location_detail_screen.dart';
import 'package:nul_app/screen/map_screen.dart';
import 'package:nul_app/screen/umkm/location_screen.dart';
import 'package:nul_app/screen/umkm/main_screen.dart';
import 'package:nul_app/screen/umkm/report_screen.dart';
import 'package:nul_app/screen/umkm/umkm_booking_screen.dart';

final List<GetPage> appRoutes = [
  // Auth Routes
  GetPage(
    name: '/login',
    page: () => LoginScreen(),
    binding: AuthBinding(),
  ),
  GetPage(
    name: '/register',
    page: () => RegisterScreen(),
    binding: AuthBinding(),
  ),
  GetPage(
    name: '/profile',
    page: () => ProfileScreen(),
    binding: AuthBinding(),
  ),
  GetPage(
    name: '/edit-profile',
    page: () => EditProfileScreen(),
    binding: AuthBinding(),
  ),

  // Main Routes
  GetPage(
    name: '/home',
    page: () => HomeScreen(),
    binding: HomeBinding(),
  ),
  GetPage(
    name: '/favorite',
    page: () => FavoriteScreen(),
  ),
  GetPage(
    name: '/category-detail',
    page: () => CategoryDetailScreen(),
    binding: CategoryBinding(),
  ),
  GetPage(
    name: '/location-detail',
    page: () => LocationDetailScreen(),
    binding: LocationBookingBinding(),
  ),
  GetPage(
    name: '/booking',
    page: () => BookingScreen(),
    binding: LocationBookingBinding(),
  ),
  GetPage(
    name: '/card-detail',
    page: () => const CardDetailScreen(),
  ),
  GetPage(
    name: '/more',
    page: () => MoreScreen(),
  ),

  // UMKM Routes
  GetPage(
    name: '/umkm/main',
    page: () => UMKMMainScreen(),
    binding: UmkmBinding(),
  ),
  GetPage(
      name: '/umkm/login',
      page: () => const UMKMLoginScreen(),
      binding: UmkmAuthBinding()),
  GetPage(
      name: '/umkm/register',
      page: () => UMKMRegisterScreen(),
      binding: UmkmAuthBinding()),
  GetPage(
      name: '/umkm/location',
      page: () => const UMKMLocationScreen(),
      binding: UmkmLocationBinding()),
  GetPage(
    name: '/umkm/booking',
    page: () => UMKMBookingScreen(),
  ),

  GetPage(
    name: '/maps',
    page: () => MapScreen(),
  ),

  GetPage(
      name: '/umkm/report',
      page: () => BookingReportScreen(),
      binding: UmkmReportBinding()),
];
