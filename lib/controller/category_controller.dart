import 'package:dio/dio.dart';
import 'package:nul_app/constants/color.dart';
import 'package:get/get.dart';
import 'package:nul_app/constants/url.dart';
import 'package:nul_app/models/category_model.dart';

class CategoryController extends GetxController {
  final dio = Dio();
  final categories = Rx<List<Category>>([]);
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  void getCategories() async {
    try {
      isLoading.value = true;
      final response = await dio.get('${API_URL}category');

      if (response.statusCode == 200) {
        final List<dynamic> dataList = response.data['data'];
        categories.value = Category.fromJsonList(dataList);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load categories: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: appRed,
        colorText: appWhite,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
