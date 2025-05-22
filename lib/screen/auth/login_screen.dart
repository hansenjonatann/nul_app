import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:get/get.dart';
import 'package:nul_app/core.dart';
import 'package:nul_app/utils/image_dir.dart';
import 'package:nul_app/utils/svg_dir.dart';
import 'package:nul_app/widget/login_alternative.dart';
import 'package:nul_app/widget/custom_textfield.dart';

final authC = Get.put(AuthController());
final TextEditingController nameC = new TextEditingController();
final TextEditingController passwordC = new TextEditingController();

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    nameC.clear();
    passwordC.clear();
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          const SizedBox(
            height: 49,
          ),
          Center(
              child: Image.asset(
            ImageDir.waterAuthLogo,
            width: 230,
          )),
          const SizedBox(
            height: 60,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLoginFormField(),
                  const SizedBox(
                    height: 7,
                  ),
                  _buildLoginFooter()
                ],
              ))
        ],
      ),
    )));
  }
}

Widget _buildLoginFormField() {
  return Column(children: [
    Align(
        alignment: Alignment.centerLeft,
        child: Text('Login Details',
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500, fontSize: 20))),
    const SizedBox(
      height: 13,
    ),
    CustomTextField(
      hidden: false,
      fieldController: nameC,
      hint: 'Your Name',
      label: 'Name',
    ),
    const SizedBox(
      height: 6,
    ),
    CustomTextField(
      hidden: true,
      hint: 'Your Password',
      label: 'Password',
      fieldController: passwordC,
    ),
  ]);
}

Widget _buildLoginFooter() {
  return (Column(
    children: [
      GestureDetector(
          onTap: () {
            authC.login(name: nameC.text, password: passwordC.text);
          },
          child: Container(
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
                color: appPrimary, borderRadius: BorderRadius.circular(5)),
            child: Center(
                child: Obx(() => Text(
                    authC.isLoading.value == true ? 'Logining in ...' : 'Login',
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: appWhite)))),
          )),
      const SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Don't have an account yet ? Register ",
              style: GoogleFonts.montserrat(
                  fontSize: 12, fontWeight: FontWeight.bold)),
          GestureDetector(
            onTap: () {
              Get.offNamed('/register');
            },
            child: Text('here',
                style: GoogleFonts.montserrat(
                    fontSize: 12, fontWeight: FontWeight.bold, color: appGold)),
          )
        ],
      ),
      const SizedBox(
        height: 30,
      ),
      const SizedBox(
        height: 10.0,
      ),
      GestureDetector(
          onTap: () => {Get.offNamed('/umkm/login')},
          child: Container(
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: appPrimary.withOpacity(0.8)),
              child: Center(
                  child: Text('Login as UMKM',
                      style: GoogleFonts.montserrat(
                          color: appWhite, fontWeight: FontWeight.w500))))),
    ],
  ));
}
