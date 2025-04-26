import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/core/navigation.dart';
import 'package:nul_app/models/card_model.dart';
import 'package:nul_app/models/category_model.dart';
import 'package:nul_app/screen/profile_screen.dart';
import 'package:nul_app/utils/image_dir.dart';
import 'package:nul_app/widget/card_item.dart';
import 'package:nul_app/widget/categoryitem.dart';
import 'package:nul_app/widget/custom_bottom_navbar.dart';

import '../models/menu_model.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  static const routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //

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
                _buildSearch(),
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
  return Column(
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
                    fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Text(
                '白鹿',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              NullAppNavigation().pushNamed(ProfileScreen.routeName);
            },
            child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: appPrimary,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(ImageDir.profile),
                )),
          ),
        ],
      ),
    ],
  );
}

Widget _buildSearch() {
  return TextField(
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      hintText: 'Cari keperluanmu...',
      prefixIcon: const Icon(Icons.search),
    ),
  );
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

Widget _buildCategorySection() {
  List<CategoryModel> categoryList1 = [
    CategoryModel(id: 1, iconPath: ImageDir.foodIcon, label: 'Food Stall'),
    CategoryModel(id: 2, iconPath: ImageDir.marketIcon, label: 'Market'),
    CategoryModel(id: 3, iconPath: ImageDir.cafeIcon, label: 'Cafe'),
  ];

  List<CategoryModel> categoryList2 = [
    CategoryModel(id: 6, iconPath: ImageDir.fitnessIcon, label: 'Fitness'),
    CategoryModel(id: 4, iconPath: ImageDir.shirtIcon, label: 'Clothes'),
    CategoryModel(id: 5, iconPath: ImageDir.toolsIcon, label: 'Tools'),
  ];

  List<CategoryModel> categoryList3 = [
    CategoryModel(id: 7, iconPath: ImageDir.hairCutIcon, label: 'Barber'),
    CategoryModel(id: 0, iconPath: ImageDir.menuIcon, label: 'More')
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(categoryList1.length, (index) {
            return Row(
              children: [
                CategoryItem(
                  categoryModel: categoryList1[index],
                ),
                const SizedBox(width: 16)
              ],
            );
          }),
        ),
      ),
      const SizedBox(height: 20),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(categoryList2.length, (index) {
            return Row(
              children: [
                CategoryItem(
                  categoryModel: categoryList2[index],
                ),
                const SizedBox(width: 16),
              ],
            );
          }),
        ),
      ),
      const SizedBox(height: 20),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(categoryList3.length, (index) {
            return Row(
              children: [
                CategoryItem(
                  categoryModel: categoryList3[index],
                ),
                const SizedBox(width: 16),
              ],
            );
          }),
        ),
      ),
    ],
  );
}

Widget _buildRecomendationSection() {
  List<CardModel> cardList = [
    CardModel(
        id: 1,
        title: "Solaria's Cafe",
        description:
            "Solaria's Cafe menyajikan hindangan lezat yang cocok untuk segala suasana , beragam pilihan menu mulai dari masakan Indonesia hingga Western.",
        image: ImageDir.solariaImage,
        menu: [
          MenuModel(name: "Nasi Goreng", price: 20000),
          MenuModel(name: "Ayam Bakar", price: 25000)
        ]),
    CardModel(
        id: 2,
        title: 'LUIS FruitShop',
        description:
            'Luis FruitShop menghadirkan buah - buahan segar berkualitas tingi dengan harga spesial! \n Segarkan hari Anda dengan buah-buahan terbaik dari Luis FruitShop',
        image: ImageDir.luisFoodShop,
        menu: [
          MenuModel(name: 'Apple', price: 5000),
          MenuModel(name: 'Orange', price: 4000),
        ])
  ];
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(
      'Rekomendasi dari kami',
      style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 16),
    ),
    const SizedBox(height: 10),
    // GridView for recommendations
    GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.7,
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: cardList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return CardItem(cardModel: cardList[index]);
      },
    ),
  ]);
}
