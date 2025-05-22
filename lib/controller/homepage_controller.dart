import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nul_app/constants/url.dart';
import 'package:nul_app/core.dart';
import 'package:nul_app/models/location_model.dart';
import 'package:dio/dio.dart';

class HomePageController extends GetxController {
  final isLoading = false.obs;
  final box = GetStorage();
  final isSearching = false.obs;
  final searchResults = Rx<List<Location>>([]);
  final recommendations = Rx<List<Location>>([]);
  final Dio dio = Dio();
  OverlayEntry? searchOverlay;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    recomend();
  }

  Future<void> search(String keyword) async {
    try {
      isSearching.value = true;
      final token = box.read('token');

      final response = await dio.get(
        '${API_DEV_URL}user/homepage/search?name=$keyword',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> dataList = response.data['data'];

        searchResults.value = dataList
            .map((json) => Location.fromJson(json as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      print('Error during search: $e');
    } finally {
      isSearching.value = false;
    }
  }

  void recomend() async {
    try {
      isLoading.value = true;
      final token = box.read('token');

      final response = await dio.get(
        '${API_DEV_URL}user/homepage/recomend',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print(response);

      if (response.statusCode == 200) {
        // Parsing list data dari key 'data'
        final List<dynamic> dataList = response.data['data'];

        // Map JSON list ke List<Location>
        recommendations.value = dataList
            .map((json) => Location.fromJson(json as Map<String, dynamic>))
            .toList();

        // Update observable list
      }
    } catch (e) {
      print('Error fetching recommendations: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
