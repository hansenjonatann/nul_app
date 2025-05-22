import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/constants/url.dart';
import 'package:flutter/material.dart';
import 'package:nul_app/models/auth/user_model.dart';
import 'package:permission_handler/permission_handler.dart';

final dio = Dio();
final box = GetStorage();

class AuthController extends GetxController {
  final isLoading = false.obs;
  final selectedFile = Rxn<PlatformFile>();
  final userProfile = Rx<User>(User());

  Future<bool> _validateImageFile(PlatformFile file) async {
    final ext = file.extension?.toLowerCase();
    final allowedExtensions = ['jpg', 'jpeg', 'png', 'webp'];

    if (ext == null || !allowedExtensions.contains(ext)) {
      Get.snackbar('Error', 'Only jpeg, jpg, png, or webp files are allowed');
      return false;
    }

    if (file.size > 10 * 1024 * 1024) {
      Get.snackbar('Error', 'File size exceeds 2MB limit');
      return false;
    }

    return true;
  }

  Future<void> pickFile() async {
    try {
      final permission = await Permission.storage.request();

      if (permission.isDenied) {
        Get.snackbar('Permission Denied', 'Storage access is required');
        return;
      }

      if (permission.isPermanentlyDenied) {
        await openAppSettings();
        return;
      }

      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && await _validateImageFile(result.files.single)) {
        selectedFile.value = result.files.single;
      }
    } catch (err) {
      Get.snackbar('Error', 'Failed to pick image: $err');
    }
  }

  void login({required String name, required String password}) async {
    try {
      isLoading.value = true;
      final response = await dio.post('${API_DEV_URL}user/auth/login',
          data: {'name': name, 'password': password});

      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.snackbar('Success', "Login Success!",
            backgroundColor: const Color(0xff28a745), colorText: appWhite);
        box.write('token', response.data['token']);
        profile();
        Get.toNamed('/home');
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Failed', 'Invalid Credentials',
          backgroundColor: appRed, colorText: appWhite);
    }
  }

  void resetForm() {
    selectedFile.value = null;
    userProfile.value = User(); // Reset ke model kosong
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

      final response =
          await dio.post('${API_DEV_URL}user/auth/register', data: {
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
        '${API_DEV_URL}user/auth/logout',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // <-- benerin ini
            'Accept': 'application/json', // opsional tambahan
          },
        ),
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        await box.remove('token');
        Get.snackbar('Success', 'Logout Success',
            backgroundColor: appSuccess, colorText: appWhite);

        Get.offAllNamed('/login');
        resetForm();
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

  void profile() async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      Map<String, dynamic> payload = Jwt.parseJwt(token);
      final response = await dio.get(
          '${API_DEV_URL}user/auth/me?id=${payload['id']}',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200) {
        isLoading.value = false;
        userProfile.value = User.fromJson(response.data['data']);
      }
    } catch (err) {
      Get.snackbar('Error', err.toString(),
          backgroundColor: appRed, colorText: appWhite);
      print(err);
    }
  }

  void updateProfile({
    required String name,
    required String email,
    required String gender,
    required String phone,
    required String dob,
    required String country,
  }) async {
    try {
      isLoading.value = true;
      final token = box.read('token');
      if (token == null) {
        isLoading.value = false;
        Get.snackbar('Error', 'Please log in again',
            backgroundColor: appRed, colorText: appWhite);
        return;
      }

      final payload = Jwt.parseJwt(token);

      final Map<String, dynamic> dataMap = {
        'name': name,
        'email': email,
        'gender': gender,
        'phone': phone,
        'dob': dob,
        'country': country,
      };

      // Jika file dipilih, tambahkan ke FormData
      if (selectedFile.value != null && selectedFile.value!.path != null) {
        if (!await _validateImageFile(selectedFile.value!)) {
          isLoading.value = false;
          return;
        }

        final filePath = selectedFile.value!.path!;
        final fileName = filePath.split('/').last;
        final ext = fileName.split('.').last.toLowerCase();

        final mimeTypeMap = {
          'jpg': 'image/jpeg',
          'jpeg': 'image/jpeg',
          'png': 'image/png',
          'webp': 'image/webp',
        };
        final contentType = mimeTypeMap[ext] ?? 'image/jpeg';

        dataMap['profile'] = await MultipartFile.fromFile(
          filePath,
          filename: fileName,
          contentType: DioMediaType('image', ext == 'jpg' ? 'jpeg' : ext),
        );
      }

      final formData = FormData.fromMap(dataMap);

      final response = await dio.patch(
        '${API_DEV_URL}user/profile/update?userId=${payload['id']}',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        selectedFile.value = null;
        Get.snackbar('Success', 'Profile Updated',
            backgroundColor: appSuccess, colorText: appWhite);
        Get.toNamed('/profile');
        profile(); // Refresh data user
      }
    } catch (err) {
      Get.snackbar('Error', err.toString(),
          backgroundColor: appRed, colorText: appWhite);
      print(err);
    } finally {
      isLoading.value = false;
    }
  }
}
