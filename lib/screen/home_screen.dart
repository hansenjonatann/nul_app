import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/screen/profile_screen.dart';
import 'package:nul_app/utils/image_dir.dart';
import 'package:nul_app/widget/custom_bottom_navbar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  List cardList = [
    {
      "id": 1,
      "title": "Solaria's Cafe ",
      "description": "Solaria's Cafe menyajikan hidangan lezat yang cocok untuk segala suasana. Beragam pilihan menu mulai dari masakan Indonesia hingga Western.",
      "image": ImageDir.solariaImage
    },
    {
      "id": 2,
      "title": "LUIS FruitShop",
      "description": "Luis FruitShop menghadirkan buah-buahan segar berkualitas tinggi dengan harga spesial! Segarkan hari Anda dengan buah-buahan terbaik dari Luis FruitShop.",
      "image": ImageDir.luisFoodShop
    }
  ];

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
                          style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '白鹿',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen()));
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: appPrimary,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const CircleAvatar( radius: 50, backgroundImage: AssetImage(ImageDir.profile ),)
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Search bar
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                    hintText: 'Cari keperluanmu...',
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 16),
                // Banner
                Container(
                  width: double.infinity,
                  child: Image.asset(
                    ImageDir.banner,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 32),
                // Grid of categories
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      buildCategoryItem(ImageDir.foodIcon, 'Food Stall'),
                      const SizedBox(width: 16),
                      buildCategoryItem(ImageDir.marketIcon, 'Market'),
                      const SizedBox(width: 16),
                      buildCategoryItem(ImageDir.cafeIcon, 'Cafe'),
                      const SizedBox(width: 16),
                      buildCategoryItem(ImageDir.shirtIcon, 'Clothes'),
                      const SizedBox(
                      height: 16.0,
                      ),
                      buildCategoryItem(ImageDir.toolsIcon, 'Tools')
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      buildCategoryItem(ImageDir.fitnessIcon, 'Fitness'),
                      const SizedBox(width: 16),
                      buildCategoryItem(ImageDir.hairCutIcon, 'Barber'),
                      const SizedBox(width: 16),
                      buildCategoryItem(ImageDir.menuIcon, 'Menu'),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
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
                    var cardItem = cardList[index];
                    return buildCardItem(cardItem);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavbar(currentIndex: 0),
    );
  }

  Widget buildCategoryItem(String iconPath, String label) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: appLightGrey,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconPath),
          const SizedBox(height: 7),
          Text(
            label,
            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget buildCardItem(Map cardItem) {
    return Container(
      decoration: BoxDecoration(
        color: appWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(
              cardItem['image'],
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardItem['title'],
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  cardItem['description'],
                  style: GoogleFonts.montserrat(fontSize: 10),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
