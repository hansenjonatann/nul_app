import 'package:nul_app/constants/url.dart';
import 'package:nul_app/core.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:nul_app/models/category_model.dart';

class CategoryController extends GetxController {
  final dio = Dio();

  RxList<Datum> categories = <Datum>[].obs;
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
        final categoryModel = CategoryModel.fromJson(response.data);

        // Ambil list datanya
        categories.value = categoryModel.data;
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to load categories ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: appRed,
        colorText: appWhite,
      );
    } finally {
      // Pastikan isLoading diset ke false setelah request selesai
      isLoading.value = false;
    }
  }
}
