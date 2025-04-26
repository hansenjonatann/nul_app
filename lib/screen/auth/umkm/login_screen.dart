import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/core.dart';

class UMKMLoginScreen extends StatelessWidget {
  const UMKMLoginScreen({super.key});
  static const routeName = '/login-umkm-screen';

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
                    NullAppNavigation()
                        .pushReplacementNamed(HomeScreen.routeName);
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
                  children: [
                    Text('You are not UMKM? ' , style: GoogleFonts.montserrat(fontWeight: FontWeight.w600))
                    ,
                    GestureDetector(onTap: () {
                      NullAppNavigation().pushReplacementNamed(LoginScreen.routeName);
                    }, child: Text('Login User' , style: GoogleFonts.montserrat(color: appPrimary , fontWeight: FontWeight.bold , fontSize: 16))),
                  ],
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
