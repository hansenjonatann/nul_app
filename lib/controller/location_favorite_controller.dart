import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nul_app/constants/url.dart';
import 'package:nul_app/models/favorite_model.dart';

class LocationFavoriteController extends GetxController {
  final loading = false.obs;
  final favoriteLocations = Rx<List<Favorite>>([]);
  final box = GetStorage();
  final dio = Dio();

  @override
  void onReady() {
    super.onReady();
    getFavorites();
  }

  void getFavorites() async {
    try {
      loading.value = true;
      final token = box.read('token');
      final response = await dio.get('${API_DEV_URL}user/locationfavorite/',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      print(response);
      if (response.statusCode == 200) {
        loading.value = false;
        final data = response.data['data'] as List<dynamic>;
        favoriteLocations.value = data
            .map((item) => Favorite.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (err) {
      loading.value = false;
      print(err);
    }
  }
}
