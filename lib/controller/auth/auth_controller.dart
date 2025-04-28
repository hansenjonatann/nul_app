import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/constants/url.dart';
import 'package:flutter/material.dart';

final dio = Dio();
final box = GetStorage();

class AuthController extends GetxController {
  final isLoading = false.obs;

  void login({required String name, required String password}) async {
    try {
      isLoading.value = true;
      final response = await dio.post('${API_URL}user/auth/login',
          data: {'name': name, 'password': password});

      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.snackbar('Success', "Login Success!",
            backgroundColor: const Color(0xff28a745), colorText: appWhite);
        box.write('token', response.data['token']);
        print(response.data['token']);
        Get.toNamed('/home');
      } else if (response.statusCode == 500) {
        isLoading.value = false;
        Get.snackbar('Failed', 'Invalid Credentialas!',
            backgroundColor: appRed, colorText: appWhite);
        return;
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Failed', 'Internal Server Error',
          backgroundColor: appRed, colorText: appWhite);
      Get.offNamed('/login');
    }
  }

  void register(
      {required String name,
      required String email,
      required String phone,
      required String password,
      required String confirmPassword}) async {
    try {
      isLoading.value = true;

      if (password != confirmPassword) {
        isLoading.value = false;
        Get.snackbar('Something went wrong',
            'Your password and confirmation password  not match');
        return;
      }

      if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
        isLoading.value = false;
        Get.snackbar('Something went wrong', 'All fields are required',
            backgroundColor: appRed, colorText: appWhite);
        return;
      }

      final response = await dio.post('${API_URL}user/auth/register', data: {
        'name': name,
        'email': email,
        'phoneNumber': phone,
        'password': password,
      });

      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.snackbar(
          'Success',
          'Registration Success',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xff28a745), // Biar warnanya sesuai tema
          colorText: appWhite, // Text putih misalnya
        );
        Get.offNamed('/login');
      }
    } catch (err) {
      isLoading.value = false;
      Get.snackbar('Failed', 'Registration Failed. ${err.toString()}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: appRed,
          colorText: appWhite);
    }
  }

  void logout() async {
    try {
      isLoading.value = true;

      final token = box.read('token'); // ambil token dari local storage

      final response = await dio.post(
        '${API_URL}user/auth/logout',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // <-- benerin ini
            'Accept': 'application/json', // opsional tambahan
          },
        ),
      );

      print(response);

      if (response.statusCode == 200) {
        // kalau sukses, hapus token dari local storage
        await box.remove('token');

        isLoading.value = false;

        // redirect ke login page atau landing page
        Get.offAllNamed('/login'); // sesuaikan dengan route kamu
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Logout Failed',
          'Unexpected error occurred',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: appRed,
          colorText: appWhite,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to logout: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: appRed,
        colorText: appWhite,
      );
    }
  }
}
