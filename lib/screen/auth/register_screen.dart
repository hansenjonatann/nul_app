import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/screen/auth/login_screen.dart';
import 'package:nul_app/utils/svg_dir.dart';
import 'package:nul_app/widget/custom_textfield.dart';
import 'package:nul_app/widget/login_alternative.dart';

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
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: appPrimary
                ),
                child: Center(child: Text('Sign Up' , style: GoogleFonts.montserrat(color: appWhite , fontWeight: FontWeight.bold , fontSize: 24)))
              ),
             ),
             SizedBox(height: 8),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account? Login ' , style: GoogleFonts.montserrat(fontSize: 12 , fontWeight: FontWeight.bold)),
                GestureDetector(  
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text('here' , style: GoogleFonts.montserrat(fontSize: 12 , fontWeight: FontWeight.bold , color: appGold)),)

              ],
             ),
             SizedBox(height: 30,),
             Row(
              children: [
                SvgPicture.asset(SvgDir.lineLight),
                SizedBox(width: 2,),
                Text('Or Sign Up With' , style: GoogleFonts.montserrat(fontSize: 12 , fontWeight: FontWeight.w500)),
                SizedBox(width: 3,),
                SvgPicture.asset(SvgDir.lineLightRight)
              ],
             ),
             SizedBox(height: 28,),
             LoginAlternative()

            


             
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