import 'package:dio/dio.dart';
import 'package:nul_app/constants/url.dart';
import 'package:nul_app/models/category_model.dart';
import 'package:get/get.dart';

void main() async {
  final dio = Dio();
  final categories = Rx<List<Category>>([]);
  RxBool isLoading = false.obs;

  isLoading.value = true;
  final response = await dio.get('${API_URL}category');

  if (response.statusCode == 200) {
    final List<dynamic> dataList = response.data['data'];
    categories.value = Category.fromJsonList(dataList);
  }
}
