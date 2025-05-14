import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nul_app/constants/url.dart';
import 'package:nul_app/core.dart';
import 'package:nul_app/models/location_model.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationController extends GetxController {
  RxBool isLoading = false.obs;
  final box = GetStorage();
  final dio = Dio();
  final locations = Rx<List<Location>>([]);
  final selectedFile = Rxn<PlatformFile>();
  final selectedLocation = Rx<Location>(Location());
  final hasFetchedLocations = false.obs;

  @override
  void onInit() {
    super.onInit();
    final token = box.read('token');
    if (token != null && !hasFetchedLocations.value) {
      getLocations();
    }
  }

  void getLocations() async {
    if (hasFetchedLocations.value) return;
    try {
      isLoading.value = true;
      final token = box.read('token');
      final response = await dio.get('${API_DEV_URL}umkm/location',
          options: Options(headers: {
            'Authorization': "Bearer $token",
            "Accept": "application/json"
          }));
      print(response);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List<dynamic>;
        locations.value = data
            .map((item) => Location.fromJson(item as Map<String, dynamic>))
            .toList();
        hasFetchedLocations.value = true;
      }
    } catch (err) {
      isLoading.value = false;
      Get.snackbar('Error', 'Gagal memuat lokasi: $err',
          backgroundColor: appRed, colorText: appWhite);
    }
  }

  Future<bool> _validateImageFile(PlatformFile file) async {
    final ext = file.extension?.toLowerCase();
    final allowedExtensions = ['jpg', 'jpeg', 'png', 'webp'];

    if (ext == null || !allowedExtensions.contains(ext)) {
      Get.snackbar(
        'Error',
        'Only jpeg, jpg, png, or webp files are allowed',
        backgroundColor: appRed,
        colorText: appWhite,
      );
      return false;
    }

    if (file.size > 2 * 1024 * 1024) {
      Get.snackbar(
        'Error',
        'File size exceeds 2MB limit',
        backgroundColor: appRed,
        colorText: appWhite,
      );
      return false;
    }

    return true;
  }

  Future<void> pickFile() async {
    try {
      PermissionStatus permission;
      if (Platform.isAndroid) {
        try {
          final version = int.parse(Platform.version.split('.').first);
          permission = version >= 33
              ? await Permission.photos.request()
              : await Permission.storage.request();
        } catch (e) {
          permission = await Permission.storage.request();
        }
      } else {
        permission = await Permission.storage.request();
      }

      if (permission.isDenied) {
        Get.snackbar(
          'Permission Denied',
          'The app needs permission to select images',
          backgroundColor: appRed,
          colorText: appWhite,
        );
        return;
      }

      if (permission.isPermanentlyDenied) {
        Get.snackbar(
          'Permission Permanently Denied',
          'Please enable access in settings',
          backgroundColor: appRed,
          colorText: appWhite,
        );
        await openAppSettings();
        return;
      }

      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: true,
      );

      if (result != null && result.files.single.path != null) {
        final file = result.files.single;
        print(
            'Selected File: ${file.name}, Extension: ${file.extension}, Path: ${file.path}');
        if (await _validateImageFile(file)) {
          selectedFile.value = file;
          Get.snackbar('Success', 'Image selected successfully',
              backgroundColor: appSuccess, colorText: appWhite);
        }
      } else {
        Get.snackbar('Cancelled', 'No image selected',
            backgroundColor: appRed, colorText: appWhite);
      }
    } catch (err) {
      Get.snackbar('Error', 'Failed to pick image: $err',
          backgroundColor: appRed, colorText: appWhite);
      print('Error picking file: $err');
    }
  }

  Future<void> createLocation({
    required String name,
    required int categoryId,
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
        'image': await MultipartFile.fromFile(
          filePath,
          filename: fileName,
          contentType: DioMediaType('image', ext == 'jpg' ? 'jpeg' : ext),
        ),
        'userId': payload['id'],
      });

      final response = await dio.post(
        '${API_DEV_URL}umkm/location/create',
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
        getLocations();
        Get.back();
      }
    } catch (err) {
      String errorMessage = 'Failed to create location';
      if (err is DioError && err.response?.data != null) {
        errorMessage = err.response!.data['error'] ?? errorMessage;
      } else {
        errorMessage = err.toString();
      }
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
          '${API_DEV_URL}user/location/detail?locationId=${id}',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      print(response);
      if (response.statusCode == 200) {
        isLoading.value = false;
        final data = response.data['data'];
        selectedLocation.value = Location.fromJson(data);
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<void> deleteLocation({required int id}) async {
    try {
      isLoading.value = true;
      final token = box.read('token');
      final response = await dio.delete('${API_DEV_URL}umkm/location/delete',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      print(response);
      if (response.statusCode == 200) {
        // Get.snackbar('Sucess');
      }
    } catch (err) {}
  }
}
