import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/controller/umkm/auth_controller.dart';
import 'package:nul_app/core.dart';

class UMKMRegisterScreen extends StatelessWidget {
  UMKMRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 40.0,
          ),
          Center(child: Image.asset(ImageDir.waterAuthLogo)),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRegisterFormField(),
                  const SizedBox(
                    height: 34,
                  ),
                  Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('You are  registered UMKM? ',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600)),
                      const SizedBox(
                        width: 5.0,
                      ),
                      GestureDetector(
                          onTap: () {
                            Get.offNamed('/umkm/login');
                          },
                          child: Text('Sign in ',
                              style: GoogleFonts.montserrat(
                                  color: appPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16))),
                    ],
                  )),
                  const SizedBox(
                    height: 30.0,
                  ),
                ],
              ))
        ],
      )),
    ));
  }
}

Widget _buildRegisterFormField() {
  final UMKMAuthController _umkmAuthC = Get.put(UMKMAuthController());
  final TextEditingController _nameC = new TextEditingController();
  final TextEditingController _emailC = new TextEditingController();
  final TextEditingController _phoneC = new TextEditingController();
  final TextEditingController _passwordC = new TextEditingController();
  return Column(
    children: [
      Align(
          alignment: Alignment.centerLeft,
          child: Text('Registration UMKM',
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500, fontSize: 24))),
      const SizedBox(
        height: 11.0,
      ),
      CustomTextField(
          fieldController: _nameC,
          label: 'Name',
          hint: 'Your UMKM Owner Name',
          hidden: false),
      const SizedBox(
        height: 11.0,
      ),
      CustomTextField(
          fieldController: _emailC,
          label: 'Email',
          hint: 'Your UMKM Owner Email',
          hidden: false),
      const SizedBox(
        height: 11.0,
      ),
      CustomTextField(
        fieldController: _phoneC,
        label: 'Phone',
        hint: '0811234567890',
        hidden: false,
      ),
      const SizedBox(
        height: 11.0,
      ),
      CustomTextField(
          fieldController: _passwordC,
          label: 'Password',
          hint: 'Your Password for Owner',
          hidden: true),
      const SizedBox(
        height: 20,
      ),
      GestureDetector(
        onTap: () {
          _umkmAuthC.register(
              name: _nameC.text,
              email: _emailC.text,
              password: _passwordC.text,
              phoneNumber: _phoneC.text);
        },
        child: Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
              color: appPrimary, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Obx(
              () => _umkmAuthC.isLoading.value == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text('Creating...',
                            style: GoogleFonts.montserrat(
                              color: appWhite,
                              fontWeight: FontWeight.bold,
                            ))
                      ],
                    )
                  : Text(
                      'Sign Up',
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
