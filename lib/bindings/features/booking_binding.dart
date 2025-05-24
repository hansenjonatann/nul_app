import 'package:get/get.dart';
import 'package:nul_app/controller/booking_controller.dart';
import 'package:nul_app/controller/location_controller.dart';

class LocationBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingController>(() => BookingController());
    Get.lazyPut<LocationController>(() => LocationController());
  }
}
