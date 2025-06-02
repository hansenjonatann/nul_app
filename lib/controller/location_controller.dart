import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nul_app/constants/url.dart';
import 'package:nul_app/core.dart';
import 'package:nul_app/models/location_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:jwt_decode/jwt_decode.dart';

class LocationController extends GetxController {
  RxBool isLoading = false.obs;
  final box = GetStorage();
  final dio = Dio();
  final locations = Rx<List<Location>>([]);
  final selectedFile = Rxn<PlatformFile>();
  final selectedLocation = Rx<Location>(Location());
  final isFavorite = false.obs;
  final selectedAddress = ''.obs;

  @override
  void onReady() {
    super.onReady();
    getLocations();
  }

  void getLocations() async {
    try {
      isLoading.value = true;
      final token = box.read('token');
      final response = await dio.get('${API_URL}umkm/location',
          options: Options(headers: {
            'Authorization': "Bearer $token",
            "Accept": "application/json"
          }));
      if (response.statusCode == 200) {
        final data = response.data['data'] as List<dynamic>;
        locations.value = data
            .map((item) => Location.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (err) {
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> _validateImageFile(PlatformFile file) async {
    final ext = file.extension?.toLowerCase();
    final allowedExtensions = ['jpg', 'jpeg', 'png', 'webp'];

    if (ext == null || !allowedExtensions.contains(ext)) {
      Get.snackbar('Error', 'Only jpeg, jpg, png, or webp files are allowed');
      return false;
    }

    if (file.size > 2 * 1024 * 1024) {
      Get.snackbar('Error', 'File size exceeds 2MB limit');
      return false;
    }

    return true;
  }

  Future<void> pickFile() async {
    try {
      final permission = await Permission.storage.request();

      if (permission.isPermanentlyDenied) {
        await openAppSettings();
      }

      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && await _validateImageFile(result.files.single)) {
        selectedFile.value = result.files.single;
      }
    } catch (err) {
      Get.snackbar('Error', 'Failed to pick image: $err');
    }
  }

  Future<void> createLocation({
    required String name,
    required String desc,
    required int categoryId,
    String? address,
    required List<int> tagIds,
  }) async {
    try {
      isLoading.value = true;
      final token = box.read('token');
      if (token == null) {
        isLoading.value = false;
        Get.snackbar('Error', 'Please log in again',
            backgroundColor: appRed, colorText: appWhite);
        return;
      }

      if (selectedFile.value == null || selectedFile.value!.path == null) {
        isLoading.value = false;
        Get.snackbar('Error', 'Please select an image',
            backgroundColor: appRed, colorText: appWhite);
        return;
      }

      if (!await _validateImageFile(selectedFile.value!)) {
        isLoading.value = false;
        return;
      }

      final filePath = selectedFile.value!.path!;
      final fileName = filePath.split('/').last;
      final ext = fileName.split('.').last.toLowerCase();
      final payload = Jwt.parseJwt(token);

      // Map extension to MIME type
      final mimeTypeMap = {
        'jpg': 'image/jpeg',
        'jpeg': 'image/jpeg',
        'png': 'image/png',
        'webp': 'image/webp',
      };
      final contentType =
          mimeTypeMap[ext] ?? 'image/jpeg'; // Default to jpeg if unknown

      final formData = FormData.fromMap({
        'name': name,
        'categoryId': categoryId,
        'tagIds': jsonEncode(tagIds),
        'desc': desc,
        'image': await MultipartFile.fromFile(
          filePath,
          filename: fileName,
          contentType: DioMediaType('image', ext == 'jpg' ? 'jpeg' : ext),
        ),
        'userId': payload['id'],
        'address': address
      });

      final response = await dio.post(
        '${API_URL}umkm/location/create',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 201) {
        selectedFile.value = null;
        Get.snackbar(
          'Success',
          'Location created successfully!',
          backgroundColor: appSuccess,
          colorText: appWhite,
        );
        Get.back();
        getLocations();
      }
    } catch (err) {
      String errorMessage = 'Failed to create location';

      Get.snackbar('Error', errorMessage,
          backgroundColor: appRed, colorText: appWhite);
      print('Error creating location: $err');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> detailLocation({required int id}) async {
    try {
      isLoading.value = true;
      final token = box.read('token');
      final response = await dio.get(
        '${API_URL}user/location/detail?locationId=$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        selectedLocation.value = Location.fromJson(response.data['data']);
      }
    } catch (err) {
      print(err);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteLocation({required int id}) async {
    try {
      isLoading.value = true;
      final token = box.read('token');
      final response = await dio.delete(
        '${API_URL}umkm/location/delete/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print(response);
      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.snackbar('Success', 'Location deleted successfully');
        getLocations();
      }
    } catch (err) {
      Get.snackbar('Error', 'Failed to delete location: $err');
    } finally {
      isLoading.value = false;
    }
  }

  void rate({required int id, required double rate}) async {
    try {
      isLoading.value = true;
      final token = box.read('token');
      final response = await dio.put('${API_URL}user/location/rate/${id}',
          data: {'rate': rate},
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.snackbar('Success', 'Thankyou for giving rate for this location',
            snackPosition: SnackPosition.TOP,
            backgroundColor: appSuccess,
            colorText: appWhite);
        Get.toNamed('/home');
      }
    } catch (e) {
      print(e);
    }
  }

  void favorite({required int locationId}) async {
    try {
      isLoading.value = true;
      final token = box.read('token');
      final response = await dio.post(
          '${API_URL}user/locationfavorite/favorite',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          data: {'locationId': locationId});
      if (response.statusCode == 201) {
        isLoading.value = false;
        isFavorite.value = true;
        Get.snackbar('Success', response.data['message'],
            backgroundColor: appSuccess, colorText: appWhite);
      }
    } catch (e) {
      isLoading.value = false;
      print(e);
    }
  }

  void unfavorite({required int locationId}) async {
    try {
      isLoading.value = true;
      final token = box.read('token');
      final response = await dio.delete(
          '${API_URL}user/locationfavorite/unfavorite',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          data: {'locationId': locationId});
      if (response.statusCode == 201) {
        isLoading.value = false;
        isFavorite.value = false;
        Get.snackbar('Success', response.data['message'],
            backgroundColor: appSuccess, colorText: appWhite);
      }
    } catch (e) {
      isLoading.value = false;
      print(e);
    }
  }
}
