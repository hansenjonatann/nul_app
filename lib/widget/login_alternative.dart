import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/utils/svg_dir.dart';

class LoginAlternative extends StatelessWidget {
  const LoginAlternative({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(52),
                    color: appLightGrey
                  ),
                  child: GestureDetector(child: Center(child: SvgPicture.asset(SvgDir.google)),)
                ),
                const SizedBox(width: 16,),
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: appLightGrey , 
                    borderRadius: BorderRadius.circular(52)
                  ),
                  child: GestureDetector(child: Center(child: SvgPicture.asset(SvgDir.facebook)))
                ),
                const SizedBox(height: 16),
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: appLightGrey , 
                    borderRadius: BorderRadius.circular(52)
                  ),
                  child: GestureDetector(child: Center(child: SvgPicture.asset(SvgDir.apple)))
                )
              ],
             );
  }
}