import 'package:dio/dio.dart';
import 'package:nul_app/constants/color.dart';
import 'package:get/get.dart';
import 'package:nul_app/constants/url.dart';
import 'package:nul_app/models/category_model.dart';

class CategoryController extends GetxController {
  final dio = Dio();
  final categories = Rx<List<Category>>([]);
  RxBool isLoading = false.obs;
  final selectedCategory = Rx<Category>(Category());

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  void getCategories() async {
    try {
      isLoading.value = true;
      final response = await dio.get('${API_DEV_URL}category');

      if (response.statusCode == 200) {
        isLoading.value = false;
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

  Future<void> getDetailCategory({required int id}) async {
    try {
      isLoading.value = true;
      final response = await dio.get('${API_DEV_URL}category/detail/$id');
      print(response);

      if (response.statusCode == 200) {
        final data = response.data['data'];

        // Parsing the response to Category model
        selectedCategory.value = Category.fromJson(data);
      }
    } catch (err) {
      Get.snackbar(
        'Error',
        'Failed to load category details: ${err.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: appRed,
        colorText: appWhite,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
