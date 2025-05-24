import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/constants/url.dart';
import 'package:nul_app/controller/homepage_controller.dart';
import 'package:nul_app/core.dart';
import 'package:nul_app/utils/image_dir.dart';
import 'package:nul_app/widget/card_item.dart';
import 'package:nul_app/widget/categoryitem.dart';
import 'package:nul_app/widget/custom_bottom_navbar.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileSection(),
                const SizedBox(height: 24),
                // Search bar
                _buildSearchWithDropdown(),
                const SizedBox(height: 16),
                // Banner
                _buildBanner(),
                const SizedBox(height: 32),
                // Grid of categorie_b
                _buildCategorySection(),

                const SizedBox(height: 40),

                _buildRecomendationSection(),

                const SizedBox(
                  height: 120,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavbar(currentIndex: 0),
    );
  }
}

Widget _buildProfileSection() {
  return Obx(() {
    final AuthController _authC = Get.find<AuthController>();
    final user = _authC.userProfile.value;
    return _authC.isLoading.value
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              const SizedBox(height: 30),
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat Datang,',
                        style: GoogleFonts.montserrat(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        user.name ?? 'No Name',
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/profile');
                    },
                    child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: appPrimary,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: CircleAvatar(
                            backgroundColor: appPrimary,
                            radius: 50,
                            backgroundImage: user.pictureUrl != null
                                ? NetworkImage(
                                    '${API_DEV_URL}api${user.pictureUrl}')
                                : null,
                            child: user.pictureUrl == null
                                ? Center(
                                    child: Icon(Icons.person, color: appWhite))
                                : null)),
                  ),
                ],
              ),
            ],
          );
  });
}

Widget _buildBanner() {
  return SizedBox(
    width: double.infinity,
    child: Image.asset(
      ImageDir.banner,
      fit: BoxFit.fill,
    ),
  );
}

Widget _buildSearchWithDropdown() {
  final controller = Get.find<HomePageController>();

  return Stack(
    children: [
      TextField(
        onChanged: (value) async {
          if (value.isNotEmpty) {
            await controller.search(value);
            controller.isSearching.value = true;
          } else {
            controller.isSearching.value = false;
            controller.searchResults.value.clear();
          }
        },
        decoration: InputDecoration(
          hintText: 'Cari keperluanmu...',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      Obx(() {
        if (!controller.isSearching.value ||
            controller.searchResults.value.isEmpty) {
          return const SizedBox.shrink();
        }
        return Container(
          margin: const EdgeInsets.only(top: 60),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.searchResults.value.length,
            itemBuilder: (context, index) {
              final location = controller.searchResults.value[index];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    location.imageUrl.toString(),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image_not_supported),
                  ),
                ),
                title: Text(
                  location.name.toString(),
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  location.desc ?? '',
                  style: GoogleFonts.montserrat(fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  controller.isSearching.value = false;
                  controller.searchResults.value.clear();
                  Get.toNamed('/location-detail',
                      arguments: {'locationId': location.id});
                  // Tambahkan navigasi jika perlu
                },
              );
            },
          ),
        );
      }),
    ],
  );
}

Widget _buildCategorySection() {
  final CategoryController _categoryC = Get.put(CategoryController());

  return Obx(() {
    if (_categoryC.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    final categories = _categoryC.categories.value;

    final categoryList1 = categories.take(3).toList();
    final categoryList2 = categories.skip(3).take(3).toList();
    final categoryList3 = categories.skip(6).take(1).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // List 1
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categoryList1.map((category) {
              return Row(
                children: [
                  CategoryItem(categoryModel: category),
                  const SizedBox(width: 16),
                ],
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),
        // List 2
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categoryList2.map((category) {
              return Row(
                children: [
                  CategoryItem(categoryModel: category),
                  const SizedBox(width: 16),
                ],
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),
        // List 3
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categoryList3.map((category) {
              return Row(
                children: [
                  CategoryItem(categoryModel: category),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {},
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
                          Image.asset(ImageDir.menuIcon),
                          const SizedBox(height: 7),
                          Text(
                            'More',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  });
}

Widget _buildRecomendationSection() {
  final homePageC = Get.find<HomePageController>();

  return Obx(() {
    final recomendations = homePageC.recommendations.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rekomendasi dari kami',
          style:
              GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.7,
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: recomendations.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return CardItem(cardModel: recomendations[index]);
          },
        ),
      ],
    );
  });
}
