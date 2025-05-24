import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/constants/url.dart';
import 'package:nul_app/models/booking_model.dart';
import 'package:jwt_decode/jwt_decode.dart';

class BookingController extends GetxController {
  final loading = false.obs;
  final box = GetStorage();
  final bookings = Rx<List<Booking>>([]);
  final dio = Dio();

  @override
  void onReady() {
    super.onReady();
    getBookings();
  }

  Future<void> getBookings() async {
    try {
      loading.value = true;
      final token = box.read('token');
      final payload = Jwt.parseJwt(token);
      final response = await dio.get(
        '${API_DEV_URL}user/booking/history?userId=${payload['id']}',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print(response);
      if (response.statusCode == 200) {
        loading.value = false;
        final data = response.data['data'];
        bookings.value = Booking.fromJsonList(data);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> book({
    required int headCount,
    required String bookingTime,
    required int locationId,
    required String? dateTime,
  }) async {
    try {
      loading.value = true;
      final token = box.read('token');
      final payload = Jwt.parseJwt(token);
      final response = await dio.post(
        '${API_DEV_URL}user/booking/create',
        data: {
          'locationId': locationId,
          'headCount': headCount,
          'bookingTime': bookingTime,
          'userId': payload['id'],
          'dateTime': dateTime,
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print(response);
      if (response.statusCode == 201) {
        loading.value = false;
        Get.dialog(
          _buildBookingConfirmationDialog(
            dateTime: dateTime ?? 'N/A',
            bookingTime: bookingTime,
            headCount: headCount,
            response: response.data,
            getBookings: getBookings,
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> cancel({required int id}) async {
    try {
      loading.value = true;
      final token = box.read('token');
      final payload = Jwt.parseJwt(token);
      final response = await dio.put(
        '${API_DEV_URL}user/booking/cancel?id=$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        loading.value = false;
        Get.dialog(
          _buildCancelConfirmationDialog(getBookings: getBookings),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  // Refactored Booking Confirmation Dialog
  Widget _buildBookingConfirmationDialog({
    required String dateTime,
    required String bookingTime,
    required int headCount,
    required Map<String, dynamic> response,
    required VoidCallback getBookings,
  }) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Booking Confirmation',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            // Content
            ListView(
              shrinkWrap: true,
              children: [
                _buildInfoRow(label: 'Date', value: dateTime),
                const SizedBox(height: 12),
                _buildInfoRow(label: 'Time', value: bookingTime),
                const SizedBox(height: 12),
                _buildInfoRow(label: 'Head', value: headCount.toString()),
              ],
            ),
            const SizedBox(height: 24),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Get.back(),
                    style: TextButton.styleFrom(
                      foregroundColor: appLightGrey,
                      textStyle: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      Get.snackbar(
                        'Booking Created',
                        response['message'],
                        backgroundColor: appSuccess,
                        snackPosition: SnackPosition.TOP,
                        colorText: appWhite,
                      );
                      Get.toNamed('/booking');
                      getBookings();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appPrimary,
                      foregroundColor: appLightGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(double.infinity, 48),
                      textStyle: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Confirm'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Refactored Cancel Confirmation Dialog
  Widget _buildCancelConfirmationDialog({
    required VoidCallback getBookings,
  }) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Cancel Confirmation',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            // Content
            Text(
              'Are you sure you want to cancel this booking?',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 24),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Get.back(),
                    style: TextButton.styleFrom(
                      foregroundColor: appLightGrey,
                      textStyle: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: const Text('No'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      getBookings();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appPrimary,
                      foregroundColor: appLightGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(double.infinity, 48),
                      textStyle: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Yes'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for info rows in booking confirmation
  Widget _buildInfoRow({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label:',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
