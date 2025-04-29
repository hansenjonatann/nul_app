import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class UMKMLocationController {
  final isLoading = false.obs;
  final box = GetStorage();
  Dio dio = Dio();
}
