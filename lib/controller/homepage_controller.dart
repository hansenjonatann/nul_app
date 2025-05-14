import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nul_app/constants/url.dart';
import 'package:nul_app/models/location_model.dart';
import 'package:dio/dio.dart';

class HomePageController extends GetxController {
  final isLoading = false.obs;
  final box = GetStorage();
  final reomendations = Rx<List<Location>>([]);
  final Dio dio = Dio();

  void recomend() async {
    try {
      isLoading.value = true;
      final token = box.read('token');
      final response = await dio.get('${API_DEV_URL}user/homepage/recomend',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      print(response);
    } catch (e) {}
  }
}
