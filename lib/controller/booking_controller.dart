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
  void onInit() {
    super.onInit();
    getBookings();
  }

  Future<void> getBookings() async {
    try {
      loading.value = true;
      final token = box.read('token');
      final payload = Jwt.parseJwt(token);
      final response = await dio.get(
          '${API_DEV_URL}user/booking/history?userId=${payload['id']}',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
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

  Future<void> book(
      {required int headCount,
      required String bookingTime,
      required int locationId,
      required String? dateTime}) async {
    try {
      loading.value = true;
      final token = box.read('token');
      final payload = Jwt.parseJwt(token);
      final response = await dio.post('${API_DEV_URL}user/booking/create',
          data: {
            'locationId': locationId,
            'headCount': headCount,
            'bookingTime': bookingTime,
            'userId': payload['id'],
            'dateTime': dateTime
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      print(response);
      if (response.statusCode == 201) {
        loading.value = false;
        Get.defaultDialog(
          contentPadding: EdgeInsets.all(10),
          title: 'Booking Confirmation',
          content: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Date : ',
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.w500)),
                  Text('${dateTime}',
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Time : ',
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.w500)),
                  Text('${bookingTime}',
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Head : ',
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.w500)),
                  Text('${headCount}',
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
          confirm: InkWell(
            onTap: () {
              Get.back();
              Get.snackbar('Booking Created', response.data['message'],
                  backgroundColor: appSuccess,
                  snackPosition: SnackPosition.TOP,
                  colorText: appWhite);
              Get.toNamed('/booking');
              getBookings();
            },
            child: Container(
                width: double.infinity,
                height: 30,
                decoration: BoxDecoration(
                    color: appPrimary, borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text('Confirm',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold, color: appLightGrey)),
                )),
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
          '${API_DEV_URL}user/booking/cancel?id=${id}',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200) {
        loading.value = false;
        Get.defaultDialog(
            title: 'Cancel Confirmation',
            confirm: InkWell(
                onTap: () {
                  Get.back();
                  getBookings();
                },
                child: Text('Yes',
                    style: GoogleFonts.montserrat(
                        color: appPrimary, fontWeight: FontWeight.bold))));
      }
    } catch (e) {
      print(e);
    }
  }
}
