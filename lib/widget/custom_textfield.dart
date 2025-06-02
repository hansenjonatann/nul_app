import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    this.fieldController,
    this.hidden = false,
    this.type,
  });

  final String label;
  final String hint;
  final TextEditingController? fieldController;
  final bool hidden;
  final TextInputType? type;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.hidden;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
            style: GoogleFonts.montserrat(
                fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        TextField(
          obscureText: _obscureText,
          controller: widget.fieldController,
          decoration: InputDecoration(
            suffixIcon: widget.hidden
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off),
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            hintText: widget.hint,
            hintStyle: GoogleFonts.montserrat(
              color: appGrey,
              fontSize: 15,
            ),
          ),
          keyboardType: widget.type,
        ),
        const SizedBox(height: 23),
      ],
    );
  }
}
