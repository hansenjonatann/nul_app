import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({required this.label , required this.hint});

  final String  label;
  final  String  hint; 



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label , style: GoogleFonts.montserrat(fontSize: 16 , fontWeight: FontWeight.bold)),
              SizedBox(height: 10,),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5)
                  ),
                
                  hintText: hint,
                  hintStyle: GoogleFonts.montserrat(color: appGrey ,  fontSize: 15)
                ),
              ),
              SizedBox(height: 23,),
      ],
    );
  }
}