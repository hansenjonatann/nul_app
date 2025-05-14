import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/models/category_model.dart'; // Import modelnya
import 'package:get/get.dart';

class CategoryItem extends StatelessWidget {
   CategoryItem({super.key, required this.categoryModel});

 



  final Category categoryModel;

  @override
  Widget build(BuildContext context) {
    final String icon = categoryModel.icon ?? '';
    final String name = categoryModel.name ?? 'No Name';

    return GestureDetector(
      onTap: () {
        if (categoryModel.id != null) {

          // Setelah dapat detail, navigate ke detail screen
          Get.toNamed('/category-detail', arguments: {
            'categoryId': categoryModel.id,
          });
        } else {
          Get.snackbar(
            'Error',
            'Invalid category data',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: appRed,
            colorText: Colors.white,
          );
        }
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
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.broken_image,
                      size: 40,
                      color: Colors.grey,
                    ),
                  )
                : const Icon(Icons.image_not_supported, size: 40),
            const SizedBox(height: 7),
            Text(
              name,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
