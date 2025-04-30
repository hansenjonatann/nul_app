import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nul_app/constants/url.dart';
import 'package:nul_app/models/location_model.dart';

class UMKMLocationController extends GetxController {
  RxBool isLoading = false.obs;
  final box = GetStorage();
  Dio dio = Dio();
  final locations = Rx<List<Location>>([]);

  @override
  void onInit() {
    getLocations();
    super.onInit();
  }

  void getLocations() async {
    try {
      isLoading.value = true;
      final alllocations = await dio.get('${API_URL}umkm/location');

      if (alllocations.statusCode == 200) {
        print(alllocations);
        final List<dynamic> dataList = alllocations.data['data'];
        print(dataList);
      }
    } catch (e) {}
  }
}
