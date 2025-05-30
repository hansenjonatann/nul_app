import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:nul_app/controller/umkm/auth_controller.dart';
import 'package:nul_app/core.dart';

class UMKMLoginScreen extends StatelessWidget {
  const UMKMLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 49.0,
          ),
          Center(
            child: Image.asset(
              ImageDir.waterAuthLogo,
              width: 240,
            ),
          ),
          const SizedBox(
            height: 60.0,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLoginFormField(),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('You are not registered UMKM? ',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600, fontSize: 12)),
                      const SizedBox(
                        width: 5.0,
                      ),
                      GestureDetector(
                          onTap: () {
                            Get.offNamed('/umkm/register');
                          },
                          child: Text('Sign up ',
                              style: GoogleFonts.montserrat(
                                  color: appPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10))),
                    ],
                  )),
                  const SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.offNamed('/login');
                      },
                      child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.brown,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text('Login as User',
                                  style: GoogleFonts.montserrat(
                                      color: appWhite,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)))))
                ],
              ))
        ],
      )),
    ));
  }
}

Widget _buildLoginFormField() {
  final UMKMAuthController _umkmC = Get.find<UMKMAuthController>();
  final TextEditingController _emailC = new TextEditingController();
  final TextEditingController _passwordC = new TextEditingController();

  return Column(
    children: [
      Align(
          alignment: Alignment.centerLeft,
          child: Text('Login UMKM',
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500, fontSize: 20))),
      const SizedBox(
        height: 15,
      ),
      CustomTextField(
        hint: 'yourname@gmail.com',
        label: 'Email',
        hidden: false,
        fieldController: _emailC,
      ),
      const SizedBox(
        height: 8,
      ),
      CustomTextField(
        hint: '******',
        label: 'Password',
        hidden: true,
        fieldController: _passwordC,
      ),
      const SizedBox(
        height: 20,
      ),
      GestureDetector(
        onTap: () {
          _umkmC.login(email: _emailC.text, password: _passwordC.text);
        },
        child: Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
              color: appPrimary, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Obx(
              () => _umkmC.isLoading.value == true
                  ? Text('Login in...',
                      style: GoogleFonts.montserrat(
                          color: appWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 22))
                  : Text(
                      'Login',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: appWhite),
                    ),
            ),
          ),
        ),
      ),
    ],
  );
}
