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

class UMKMLocationController extends GetxController {
  RxBool isLoading = false.obs;
  final box = GetStorage();
  final dio = Dio();
  final locations = Rx<List<Location>>([]);
  final selectedFile = Rxn<PlatformFile>();

  @override
  void onInit() {
    getLocations();
    super.onInit();
  }

  void getLocations() async {
    try {
      isLoading.value = true;
      final token = box.read('token');
      final alllocations = await dio.get('${API_DEV_URL}umkm/location',
          options: Options(headers: {
            'Authorization': "Bearer $token",
            "Accept": "application/json"
          }));

      if (alllocations.statusCode == 200) {
        isLoading.value = false;
        final List<dynamic> dataList = alllocations.data['data'];
        locations.value =
            dataList.map((json) => Location.fromJson(json)).toList();
      }
    } catch (err) {
      isLoading.value = false;
      Get.snackbar('Error', 'Gagal memuat lokasi: $err',
          backgroundColor: appRed, colorText: appWhite);
      print('Error getting locations: $err');
    }
  }

  void pickFile() async {
    try {
      // Minta izin sesuai OS dan versi
      PermissionStatus permission;
      if (Platform.isAndroid &&
          int.parse(Platform.version.split('.').first) >= 33) {
        permission = await Permission.photos.request();
      } else {
        permission = await Permission.storage.request();
      }

      if (permission.isDenied) {
        Get.snackbar(
          'Izin Ditolak',
          'Aplikasi memerlukan izin untuk memilih gambar',
          backgroundColor: appRed,
          colorText: appWhite,
        );
        return;
      }

      if (permission.isPermanentlyDenied) {
        Get.snackbar(
          'Izin Ditolak Permanen',
          'Buka pengaturan untuk mengizinkan akses',
          backgroundColor: appRed,
          colorText: appWhite,
        );
        await openAppSettings();
        return;
      }

      // Pilih file gambar
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: true,
      );

      if (result != null && result.files.single.path != null) {
        final file = result.files.single;
        final ext = file.extension?.toLowerCase();
        if (!['jpg', 'jpeg', 'png', 'webp'].contains(ext)) {
          Get.snackbar(
            'Error',
            'Hanya file jpeg, jpg, png, atau webp yang diizinkan',
            backgroundColor: appRed,
            colorText: appWhite,
          );
          return;
        }

        selectedFile.value = file; // Simpan PlatformFile
        Get.snackbar(
          'Berhasil',
          'Gambar berhasil dipilih',
          backgroundColor: appSuccess,
          colorText: appWhite,
        );
      } else {
        Get.snackbar(
          'Dibatalkan',
          'Tidak ada gambar yang dipilih',
          backgroundColor: appRed,
          colorText: appWhite,
        );
      }
    } catch (err) {
      Get.snackbar(
        'Error',
        'Gagal memilih gambar: $err',
        backgroundColor: appRed,
        colorText: appWhite,
      );
      print('Error picking file: $err');
    }
  }

  void createLocation({
    required String name,
    required int categoryId,
    required List<int> tagIds,
  }) async {
    try {
      isLoading.value = true;
      final token = box.read('token');
      Map<String, dynamic> payload = Jwt.parseJwt(token);

      if (selectedFile.value == null || selectedFile.value!.path == null) {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Pilih gambar terlebih dahulu',
          backgroundColor: appRed,
          colorText: appWhite,
        );
        return;
      }

      final filePath = selectedFile.value!.path!;
      final fileName = filePath.split('/').last;
      final ext = fileName.split('.').last.toLowerCase();
      if (!['jpg', 'jpeg', 'png', 'webp'].contains(ext)) {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Hanya file jpeg, jpg, png, atau webp yang diizinkan',
          backgroundColor: appRed,
          colorText: appWhite,
        );
        return;
      }

      final formData = FormData.fromMap({
        'name': name,
        'categoryId': categoryId.toString(),
        'tagIds': tagIds.map((e) => e.toString()).toList(),
        'image': await MultipartFile.fromFile(
          filePath,
          filename: fileName,
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
        isLoading.value = false;
        selectedFile.value = null; // Reset file setelah sukses
        Get.snackbar(
          'Berhasil',
          'Lokasi berhasil dibuat!',
          backgroundColor: appSuccess,
          colorText: appWhite,
        );
        getLocations(); // Refresh daftar lokasi
        Get.back(); // Tutup bottom sheet setelah sukses
      }
    } catch (err) {
      isLoading.value = false;
      String errorMessage = 'Gagal membuat lokasi';
      errorMessage = err.toString();
      Get.snackbar(
        'Error',
        errorMessage,
        backgroundColor: appRed,
        colorText: appWhite,
      );
      print('Error creating location: $err');
    }
  }
}
