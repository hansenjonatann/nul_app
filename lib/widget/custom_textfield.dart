import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.label,
      required this.hint,
      this.fieldController,
      required this.hidden,
      this.type});

  final String label;
  final String hint;
  final TextEditingController? fieldController;
  final bool hidden;
  final TextInputType? type;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.montserrat(
                fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 10,
        ),
        TextField(
          obscureText: hidden,
          controller: fieldController,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              hintText: hint,
              hintStyle: GoogleFonts.montserrat(color: appGrey, fontSize: 15)),
          keyboardType: type,
        ),
        const SizedBox(
          height: 23,
        ),
      ],
    );
  }
}
