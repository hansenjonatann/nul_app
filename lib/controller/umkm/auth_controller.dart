import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';
import 'package:nul_app/constants/url.dart';

class UMKMController extends GetxController {
  final isLoading = false.obs;
  final box = GetStorage();
  Dio dio = Dio();

  void register ({required String name , required String email , required String password , required String phoneNumber}) async {
    try{
      isLoading.value = true;
      final response = await dio.post('${API_URL}umkm/auth/register' , data: {
        'name' : name, 
        'email' : email , 
        'phoneNumber' : phoneNumber , 
        'password' : password
      });

      if(response.statusCode == 201) {
        isLoading.value = false;
        print(response.data);

      }
    }catch(e) {
      isLoading.value = false;
      print(e);
    }
  }

}