import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:get/get.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.categoryModel});

  final categoryModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        

        Get.toNamed('/category-detail' , arguments: {'categoryModel' : categoryModel});
      },
      child: Container(
        width: 108,
        height: 108,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: appLightGrey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              categoryModel.icon,
            ),
            const SizedBox(height: 7),
            Text(
              categoryModel.name,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
