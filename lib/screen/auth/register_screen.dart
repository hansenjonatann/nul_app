import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/utils/svg_dir.dart';
import 'package:nul_app/widget/custom_textfield.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
              const SizedBox(height: 19,),
              Center(child: Text('Register' , style: GoogleFonts.montserrat(fontSize: 24 , fontWeight: FontWeight.w500))),
              const SizedBox(height: 9,),
              CustomTextField(label: 'Name', hint: 'Your name , e.g: John Doe'),
              CustomTextField(label: 'Email', hint: 'Your email, e.g : johndoe@gmail.com'),
              CustomTextField(label: 'Phone Number', hint: 'Your phone number, e.g : +01 112 xxx xxx',),
              CustomTextField(label: 'Password', hint: 'Your password, at least 8 character.',),
              CustomTextField(label: 'Confirm Password' , hint: 'Re-type your password'),
              SizedBox(height: 22,),
             Align(
              alignment: Alignment.centerRight,
              child:  Text('Forgot password?' , style: GoogleFonts.montserrat(color: appDarkGrey , fontWeight: FontWeight.w500))
             ),
             SizedBox(height: 34,),
             GestureDetector(
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: appPrimary
                ),
                child: Center(child: Text('Sign Up' , style: GoogleFonts.montserrat(color: appWhite , fontWeight: FontWeight.bold , fontSize: 24)))
              ),
             ),
            


             
            ],

          ),
          ),
          Container(
            margin: EdgeInsets.zero,
            width: double.infinity,
          child: SvgPicture.asset(SvgDir.wave) 
          )
            ],
          )
          ,)

        ),
        
    );
  }
}