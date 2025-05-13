import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:nul_app/constants/url.dart';
import 'package:nul_app/core.dart';
import 'package:nul_app/models/auth/user_model.dart';

class UMKMAuthController extends GetxController {
  final isLoading = false.obs;
  final box = GetStorage();
  Dio dio = Dio();
  final umkmProfile = Rx<User>(User());

  void register(
      {required String name,
      required String email,
      required String password,
      required String phoneNumber}) async {
    try {
      isLoading.value = true;
      final response = await dio.post('${API_DEV_URL}umkm/auth/register',
          data: {
            'name': name,
            'email': email,
            'phoneNumber': phoneNumber,
            'password': password
          });

      if (response.statusCode == 201) {
        isLoading.value = false;
        Get.snackbar('Success', 'Account Created!',
            backgroundColor: appSuccess, colorText: appWhite);
        Get.offNamed('/umkm/login');
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Internal Server Error',
          backgroundColor: appRed, colorText: appWhite);
    }
  }

  void login({required String email, required String password}) async {
    try {
      isLoading.value = true;

      final response = await dio.post('${API_DEV_URL}umkm/auth/login',
          data: {'email': email, 'password': password});

      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.snackbar(
            backgroundColor: appSuccess,
            colorText: appWhite,
            'Success',
            'Success Login as UMKM');

        box.write('token', response.data['token']);
        profile();
        Get.toNamed('/umkm/main');
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Failed', 'Internal Server Error ',
          backgroundColor: appRed, colorText: appWhite);
    }
  }

  void profile() async {
    try {
      isLoading.value = true;
      final token = box.read('token');
      Map<String, dynamic> payload = Jwt.parseJwt(token);

      final response = await dio.get(
        '${API_DEV_URL}umkm/auth/profile?id=${payload['id']}',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        umkmProfile.value = User.fromJson(data);
      }
    } catch (err) {
      print('Error getting profile: $err');
    } finally {
      isLoading.value = false;
    }
  }
}
