import 'package:get/get.dart';
import 'package:nul_app/controller/umkm/report/booking_report_controller.dart';

class UmkmReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingReportController>(() => BookingReportController());
  }
}
