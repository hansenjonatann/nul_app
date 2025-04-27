import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/controller/auth/auth_controller.dart';
import 'package:nul_app/utils/svg_dir.dart';
import 'package:nul_app/widget/custom_textfield.dart';
import 'package:nul_app/widget/login_alternative.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  final authC = Get.put(AuthController());

  final TextEditingController nameC = new TextEditingController();
  final TextEditingController emailC = new TextEditingController();
  final TextEditingController phoneC = new TextEditingController();
  final TextEditingController passwordC = new TextEditingController();
  final TextEditingController confirmPasswordC = new TextEditingController();

  RegisterScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const SizedBox(
                    height: 19,
                  ),
                  Center(
                      child: Text('Register',
                          style: GoogleFonts.montserrat(
                              fontSize: 24, fontWeight: FontWeight.w500))),
                  const SizedBox(
                    height: 9,
                  ),
                   CustomTextField(
                    hidden: false,
                    fieldController: nameC,
                      label: 'Name', hint: 'Your name , e.g: John Doe'),
                   CustomTextField(
                    hidden: false,
                      fieldController: emailC,
                      label: 'Email',
                      hint: 'Your email, e.g : johndoe@gmail.com'),
                   CustomTextField(
                    hidden: false,
                    fieldController: phoneC,
                    label: 'Phone Number',
                    hint: 'Your phone number, e.g : +01 112 xxx xxx',
                  ),
                   CustomTextField(
                    hidden: true,
                    fieldController: passwordC,
                    label: 'Password',
                    hint: 'Your password, at least 8 character.',
                  ),
                   CustomTextField(
                    hidden: true,
                    fieldController: confirmPasswordC,
                      label: 'Confirm Password', hint: 'Re-type your password'),
                  const SizedBox(
                    height: 34,
                  ),
                  GestureDetector(
                    onTap: () {
                  authC.register(name: nameC.text, email: emailC.text, phone: phoneC.text, password: passwordC.text, confirmPassword: confirmPasswordC.text);
                    },
                    child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: appPrimary),
                        child: Center(
                            child: Obx(() => Text(authC.isLoading.value == true ? 'Signuping...' : 'Sign Up',
                                style: GoogleFonts.montserrat(
                                    color: appWhite,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24)))),),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account? Login ',
                          style: GoogleFonts.montserrat(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                      GestureDetector(
                        onTap: () {
                        Get.offNamed('/login');
                        },
                        child: Text('here',
                            style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: appGold)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SvgPicture.asset(SvgDir.lineLight),
                        const SizedBox(
                          width: 2,
                        ),
                        Text('Or Sign Up With',
                            style: GoogleFonts.montserrat(
                                fontSize: 12, fontWeight: FontWeight.w500)),
                        const SizedBox(
                          width: 3,
                        ),
                        SvgPicture.asset(SvgDir.lineLightRight)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  const LoginAlternative()
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.zero,
                width: double.infinity,
                child: SvgPicture.asset(SvgDir.wave))
          ],
        ),
      )),
    );
  }
}
