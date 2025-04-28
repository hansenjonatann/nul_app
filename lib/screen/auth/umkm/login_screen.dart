import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import'package:get/get.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/utils/image_dir.dart';

class UMKMLoginScreen extends StatelessWidget {
  const UMKMLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        const SizedBox(
          height: 49.0,
        ),
        Center(
          child: Image.asset(ImageDir.waterAuthLogo),
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
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Get.offNamed('/home');
                  },
                  child: Container(
                      width: double.infinity,
                      height: 70,
                      decoration: BoxDecoration(
                          color: appPrimary,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text('Login',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: appWhite)))),
                ),
                const SizedBox(
                  height: 34,
                ),
                Center(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('You are not registered UMKM? ' , style: GoogleFonts.montserrat(fontWeight: FontWeight.w600))
                    ,
                    const SizedBox(
                      width: 5.0,
                    ),
                    GestureDetector(onTap: () {
                      Get.offNamed('/umkm/register');
                    }, child: Text('Sign up ' , style: GoogleFonts.montserrat(color: appPrimary , fontWeight: FontWeight.bold , fontSize: 16))),
                  ],
                )),

                const SizedBox(
                  height: 20.0,
                ),
                GestureDetector( onTap: () {
                  Get.offNamed('/login');
                } , child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text('Login as User' , style: GoogleFonts.montserrat(color: appWhite, fontWeight: FontWeight.bold , fontSize: 16)))
                ))
              ],
            ))
      ],
    )));
  }
}

Widget _buildLoginFormField() {
  return Column(children: [
    Align(
        alignment: Alignment.centerLeft,
        child: Text('Login UMKM',
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500, fontSize: 24))),
    const SizedBox(
      height: 11,
    ),
    TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          hintText: 'Email'),
    ),
    const SizedBox(
      height: 11,
    ),
    TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          hintText: 'Password'),
    )
  ]);
}
