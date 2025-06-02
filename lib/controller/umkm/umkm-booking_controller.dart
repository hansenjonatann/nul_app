import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/constants/url.dart';
import 'package:nul_app/models/booking_model.dart';

class UMKMBookingController extends GetxController {
  final loading = false.obs;
  final box = GetStorage();
  final dio = Dio();
  final bookings = Rx<List<Booking>>([]);
  final selectedBooking = Rxn<Booking>(Booking());
  var totalCount = 0.obs;

  void getBookings({int? page}) async {
    try {
      loading.value = true;
      final token = box.read('token');
      final response = await dio.get('${API_URL}umkm/booking?page=${page}',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      print(response);

      if (response.statusCode == 200) {
        loading.value = false;
        final data = response.data['data'] as List<dynamic>;
        bookings.value = data
            .map((item) => Booking.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      loading.value = false;
    }
  }

  void accept({required int id}) async {
    try {
      loading.value = true;
      final token = box.read('token');
      final response = await dio.patch(
          '${API_URL}umkm/booking/accept?id=${id}',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200) {
        loading.value = false;
        Get.snackbar('Success', response.data['message'],
            backgroundColor: appSuccess,
            colorText: appWhite,
            snackPosition: SnackPosition.TOP);
        getBookings();
      }
    } catch (e) {
      loading.value = false;
      print(e);
    }
  }

  void decline({required int id}) async {
    try {
      loading.value = true;
      final token = box.read('token');
      final response = await dio.patch(
          '${API_URL}umkm/booking/decline?id=${id}',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200) {
        loading.value = false;
        Get.snackbar('Success', response.data['message'],
            backgroundColor: appSuccess,
            colorText: appWhite,
            snackPosition: SnackPosition.TOP);
        getBookings();
      }
    } catch (e) {
      loading.value = false;
      print(e);
    }
  }
}
