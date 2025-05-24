import 'package:get/get.dart';
import 'package:nul_app/controller/umkm/auth_controller.dart';

class UmkmAuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UMKMAuthController>(() => UMKMAuthController());
  }
}
