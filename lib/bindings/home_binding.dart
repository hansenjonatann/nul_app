import 'package:get/get.dart';
import 'package:nul_app/controller/auth/auth_controller.dart';
import 'package:nul_app/controller/category_controller.dart';
import 'package:nul_app/controller/homepage_controller.dart';
import 'package:nul_app/controller/utils/location_controller_utils.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<CategoryController>(() => CategoryController());
    Get.lazyPut<HomePageController>(() => HomePageController());
    Get.lazyPut<LocationUtilsController>(() => LocationUtilsController());
  }
}
