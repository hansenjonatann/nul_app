import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/models/category_model.dart';
import 'package:nul_app/constants/url.dart';

class CategoryController extends GetxController {
  final dio = Dio();
  RxList<CategoryModel> categories = RxList<CategoryModel>([]);
  RxBool isLoading = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    getCategories();  // Memanggil API untuk mengambil kategori
  }

  // Fungsi untuk mengambil kategori dari API
  void getCategories() async {
    try {
      isLoading.value = true;
      final response = await dio.get('${API_URL}category');
      
      if (response.statusCode == 200) {
        // Mengambil data kategori dari JSON
        var categoryData = json.decode(response.data)['data'];
        categories.value = List<CategoryModel>.from(categoryData.map((item) => CategoryModel.fromJson(item)));
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to load categories',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: appRed,
          colorText: appWhite);
    }
  }
}
