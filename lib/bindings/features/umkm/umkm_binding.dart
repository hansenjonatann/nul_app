import 'package:get/get.dart';
import 'package:nul_app/controller/auth/auth_controller.dart';
import 'package:nul_app/controller/location_controller.dart';
import 'package:nul_app/controller/umkm/auth_controller.dart';
import 'package:nul_app/controller/umkm/umkm-booking_controller.dart';

class UmkmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<UMKMAuthController>(() => UMKMAuthController());
    Get.lazyPut<UMKMBookingController>(() => UMKMBookingController());
    Get.lazyPut<LocationController>(() => LocationController());
  }
}
