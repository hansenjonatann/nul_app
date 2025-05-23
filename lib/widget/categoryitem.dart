import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CategoryItem extends StatelessWidget {
  CategoryItem({super.key, required this.categoryModel});

  final dynamic categoryModel;

  @override
  Widget build(BuildContext context) {
    // Ensure categoryModel is not null before accessing its properties
    final String icon = categoryModel != null && categoryModel.icon != null
        ? categoryModel.icon
        : '';
    final String name = categoryModel != null && categoryModel.name != null
        ? categoryModel.name
        : 'No Name';

    return GestureDetector(
      onTap: () {
        Get.toNamed('/category-detail',
            arguments: {'categoryId': categoryModel.id ?? 1});
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
            icon.isNotEmpty
                ? Image.network(
                    icon,
                    width: 40,
                    height: 40,
                  )
                : const Icon(Icons.image_not_supported, size: 40),
            const SizedBox(height: 7),
            Text(
              name,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
