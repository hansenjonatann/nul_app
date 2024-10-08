import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/screen/auth/register_screen.dart';
import 'package:nul_app/screen/home_screen.dart';
import 'package:nul_app/utils/image_dir.dart';
import 'package:nul_app/utils/svg_dir.dart';
import 'package:nul_app/widget/login_alternative.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
          children: [
            SizedBox(height: 49,),
            Center(child: Image.asset(ImageDir.waterAuthLogo)),
            SizedBox(height: 60,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30) ,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
          
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Login Details' , style: GoogleFonts.montserrat(fontWeight: FontWeight.w500 , fontSize: 24))
                  ),
                  SizedBox(height: 11,),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)
                      ),
                      hintText: 'Username , email & phone number'
                      
                    ),
                  ),
                  SizedBox(height: 11,),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)
                      ),
                      hintText: 'Password'
                    ),
                    
                  ),
                  SizedBox(height: 7,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton( onPressed: () {} , child: Text('Forgot Password?' , style: GoogleFonts.montserrat(color: appDarkGrey , fontSize: 16 , fontWeight: FontWeight.w500)),)
                  ),
                  SizedBox(height: 34,),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
                    },
                    child: Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      color: appPrimary , 
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Center(child: Text('Login' , style: GoogleFonts.montserrat(fontWeight: FontWeight.bold , fontSize: 24, color: appWhite)))
                  ),),
                   SizedBox(height: 8),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account yet ? Register " , style: GoogleFonts.montserrat(fontSize: 12 , fontWeight: FontWeight.bold)),
                  GestureDetector(  
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RegisterScreen()));
                    },
                    child: Text('here' , style: GoogleFonts.montserrat(fontSize: 12 , fontWeight: FontWeight.bold , color: appGold)),)
          
                ],
               ),
               SizedBox(height: 30,),
               Row(
                children: [
                  SvgPicture.asset(SvgDir.lineLight),
                  SizedBox(width: 2,),
                  Text('Or Login With' , style: GoogleFonts.montserrat(fontSize: 12 , fontWeight: FontWeight.w500)),
                  SizedBox(width: 3,),
                  SvgPicture.asset(SvgDir.lineLightRight)
                ],
               ),
               SizedBox(height: 28,),
               LoginAlternative(),
               SvgPicture.asset(SvgDir.wave)
                ],
              )
            )
          ],
                ),
        )
      )
    );
  }
}