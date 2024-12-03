import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/core/navigation.dart';
import 'package:nul_app/screen/auth/login_screen.dart';
import 'package:nul_app/utils/image_dir.dart';
import 'package:nul_app/widget/custom_textfield.dart';

class UMKMLoginScreen extends StatelessWidget {
  const UMKMLoginScreen({super.key});

   static const String routeName = '/umkm/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appWhite,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
            height: 49.0,
            ),
            Center(child: Image.asset(ImageDir.waterAuthLogo , fit: BoxFit.fitWidth)),
            const SizedBox(
            height: 60.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                 const CustomTextField(label: 'Kode UMKM', hint: '00119292939'),
                  const SizedBox(
                  height: 10.0,
                  ),
                 const CustomTextField(label: 'Password UMKM', hint: '*********'),
                 Container(
                 height: 70,

                 width: MediaQuery.of(context).size.width * 0.9,
                 decoration:  BoxDecoration(
                 color: appPrimary,
                  borderRadius: BorderRadius.circular(5)
                 ),
                 child: Center(
                  child: Text('Login ' , style: GoogleFonts.montserrat(color: appWhite , fontSize: 24 , fontWeight: FontWeight.bold,
                  ))
                 )
                 ),
                ],
              )
            ),
            const SizedBox(
            height: 8.0,
            ),
            Center(child: Text('Create UMKM account for free!' , style: GoogleFonts.montserrat(fontSize: 16 , fontWeight: FontWeight.w600))),
            const SizedBox(
            height: 20.0,
            ),
            InkWell(
              onTap: () {
                NullAppNavigation().pushReplacementNamed(LoginScreen.routeName);
              },
              child: Container(
              height: 43,
              width: MediaQuery.of(context).size.width * 0.75,
              decoration:  BoxDecoration(
              color: appGrey,
              borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Text('Login as User' , style: GoogleFonts.montserrat(color: appWhite , fontSize: 18 , fontWeight: FontWeight.bold,)))
              ),
            ),
          ],
        ),
      )
    );
  }
}