import 'package:get/get.dart';
import 'package:nul_app/controller/category_controller.dart';
import 'package:nul_app/controller/location_controller.dart';
import 'package:nul_app/controller/tag_controller.dart';

class UmkmLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryController>(() => CategoryController());
    Get.lazyPut<TagController>(() => TagController());
    Get.lazyPut<LocationController>(() => LocationController());
  }
}
