import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/controller/category_controller.dart';
import 'package:get/get.dart';

class CategoryDetailScreen extends StatelessWidget {
  CategoryDetailScreen({super.key});

  final CategoryController _categoryC = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    final int? categoryId = Get.arguments['categoryId'];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (categoryId != null &&
          _categoryC.selectedCategory.value.id != categoryId) {
        _categoryC.getDetailCategory(id: categoryId);
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (_categoryC.isLoading.value == true) {
            return const Center(child: CircularProgressIndicator());
          }

          final categoryModel = _categoryC.selectedCategory.value;

          if (categoryModel.id == null) {
            return const Center(child: Text("No Data"));
          }

          return Column(
            children: [
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                    Text(
                      categoryModel.name ?? "Category",
                      style: GoogleFonts.montserrat(
                        color: appPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30.0),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: categoryModel.locations?.length ?? 0,
                  itemBuilder: (context, index) {
                    final location = categoryModel.locations![index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed('/location-detail', arguments: {
                            'locationId': location.id,
                          });
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            location.imageUrl != null
                                ? Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Image.network(
                                      location.imageUrl.toString(),
                                      fit: BoxFit.cover,
                                    ))
                                : Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: appPrimary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.location_on,
                                        size: 30,
                                        color: appPrimary,
                                      ),
                                    ),
                                  ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    location.name ?? "Location Name",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.yellow),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        location.rateCount != null
                                            ? location.rateCount.toString()
                                            : '0',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
