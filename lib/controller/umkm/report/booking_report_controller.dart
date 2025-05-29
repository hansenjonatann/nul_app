import 'package:get/get.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/constants/url.dart';
import 'package:nul_app/models/booking_model.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class BookingReportController extends GetxController {
  final bookings = Rx<List<Booking>>([]);
  final dio = Dio();
  final box = GetStorage();
  final loading = false.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getBookingReports();
  }

  void getBookingReports() async {
    try {
      loading.value = true;
      final token = box.read('token');
      final response = await dio.get('${API_DEV_URL}umkm/report/booking',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      print(response);
      if (response.statusCode == 200) {
        loading.value = false;
        final data = response.data['data'] as List;
        bookings.value = data
            .map((item) => Booking.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar('Error', e.toString(),
          backgroundColor: appRed, colorText: appWhite);
      print(e);
    }
  }
}
