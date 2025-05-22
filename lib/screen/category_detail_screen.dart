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
          _categoryC.detailedCategory.value.id != categoryId) {
        _categoryC.getDetailCategory(id: categoryId);
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (_categoryC.isLoading.value == true) {
            return const Center(child: CircularProgressIndicator());
          }

          final categoryModel = _categoryC.detailedCategory.value;

          if (categoryModel.id == null) {
            return const Center(child: Text("No Data"));
          }

          return Column(
            children: [
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Get.back(),
                      ),
                    ),
                    Center(
                      child: Text(
                        categoryModel.name.toString(),
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: categoryModel.locations?.length ?? 0,
                    itemBuilder: (context, index) {
                      final location = categoryModel.locations![index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed('/location-detail', arguments: {
                            'locationId': location.id,
                          });
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          shadowColor: Colors.grey.withOpacity(0.2),
                          margin: const EdgeInsets.only(bottom: 15),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: location.imageUrl != null
                                      ? Image.network(
                                          location.imageUrl!,
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          height: 80,
                                          width: 80,
                                          color: appPrimary.withAlpha(30),
                                          child: const Center(
                                            child: Icon(
                                              Icons.location_on,
                                              size: 30,
                                              color: appPrimary,
                                            ),
                                          ),
                                        ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Baris: Nama dan Bintang
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              location.name ?? "Location Name",
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.star,
                                                  color: Colors.amber,
                                                  size: 18),
                                              const SizedBox(width: 4),
                                              Text(
                                                location.rating?.toString() ??
                                                    '0',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 6),

                                      // Deskripsi singkat
                                      Text(
                                        location.desc ??
                                            "No description available.",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 13,
                                          color: Colors.grey[700],
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          );
        }),
      ),
    );
  }
}
