import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/core/navigation.dart';
import 'package:nul_app/screen/auth/login_screen.dart';
import 'package:nul_app/screen/seller/home_seller_screen.dart';
import 'package:nul_app/widget/custom_textfield.dart';

class LoginSellerScreen extends StatelessWidget {
  const LoginSellerScreen({super.key});

   static const routeName= '/login-seller-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
            height: 10.0,
            ),
            const Center(child: Icon(Icons.store_mall_directory_outlined , size: 220, color: appPrimary)),
            Text("Seller's Login " , style: GoogleFonts.montserrat(fontSize: 40 , fontWeight: FontWeight.bold,)),
            const SizedBox(
            height: 20.0,
            ),
            Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 20),
              child:  Column(
                children: [
                   const CustomTextField(label: "Seller's Code", hint: "H64JSY"),
                    const SizedBox(
                  height: 8.0,
                  ),
                  const CustomTextField(label: "Seller's Password", hint: "*******"),
                  const SizedBox(
                 height: 10.0,
                 ),
                 InkWell(
                  onTap: () {
                    NullAppNavigation().pushReplacementNamed(HomeSellerScreen.routeName);
                  } ,
                   child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 60,
                    decoration: BoxDecoration(color: appPrimary , borderRadius: BorderRadius.circular(10))
                   , child: Center(child: Text('Login' , style: GoogleFonts.montserrat(color: appWhite , fontWeight: FontWeight.bold, fontSize: 24)))
                   ),
                 ),
                 const SizedBox(
                 height: 10.0,
                 ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('You are not a seller? ' , style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)), 
                    InkWell(onTap: () {
                      NullAppNavigation().pushReplacementNamed(LoginScreen.routeName);
                    }, child: Text('Login as user' , style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: appPrimary)))
                  ]
                 )
                
                 
                ],
              )
            )
          ]
        )
      )
    );
  }
}