import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nul_app/constants/url.dart';
import 'package:nul_app/core.dart';
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
      final token = box.read('token');
      final alllocations = await dio.get('${API_DEV_URL}umkm/location' , options: Options(headers: {
        'Authorization' : "Bearer $token"
      }));

      if (alllocations.statusCode == 200) {
        isLoading.value = false;
        print(alllocations);
        final List<dynamic> dataList = alllocations.data['data'];
        print(dataList);
      }
    } catch (err) {
      Get.snackbar('Error' , '${err}' , backgroundColor: appRed, colorText: appWhite);
      print(err);
    }
  }
}
