import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/constants/url.dart';
import 'package:nul_app/models/tag_model.dart';

class TagController extends GetxController {
  final isLoading = false.obs;
  final tags = RxList<Tag>([]);
  final selectedTag = Rxn<Tag>();
  Dio dio = Dio();

  @override
  void onInit() {
    getTags();
    super.onInit();
  }

  void getTags() async {
    try {
      isLoading.value = true;
      final response = await dio.get('${API_URL}tag');

      if (response.statusCode == 200) {
        final List<dynamic> dataList = response.data['data'];
        tags.value = Tag.fromJsonList(dataList);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Failed', '${e}',
          backgroundColor: appRed, colorText: appWhite);
    }
  }
}
