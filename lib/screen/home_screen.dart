import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/models/card_model.dart';
import 'package:nul_app/models/category_model.dart';
import 'package:nul_app/screen/profile_screen.dart';
import 'package:nul_app/utils/image_dir.dart';
import 'package:nul_app/widget/card_item.dart';
import 'package:nul_app/widget/categoryitem.dart';
import 'package:nul_app/widget/custom_bottom_navbar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static const routeName = '/home-screen';

  List<CategoryModel> categoryList1 = [
    CategoryModel(iconPath: ImageDir.foodIcon, label: 'Food Stall'),
    CategoryModel(iconPath: ImageDir.marketIcon, label: 'Market'),
    CategoryModel(iconPath: ImageDir.cafeIcon , label: 'Cafe'),
    CategoryModel(iconPath: ImageDir.shirtIcon , label: 'Clothes'),
    CategoryModel(iconPath: ImageDir.toolsIcon , label: 'Tools'),


  ];

  List<CategoryModel> categoryList2 = [
    CategoryModel(iconPath: ImageDir.fitnessIcon , label: 'Fitness'),
    CategoryModel(iconPath: ImageDir.hairCutIcon , label: 'Barber'),
    CategoryModel(iconPath: ImageDir.menuIcon , label: 'More')
  ];

  

  List<CardModel> cardList = [
    CardModel(id: 1, title: "Solaria's Cafe" , description: "Solaria's Cafe menyajikan hindangan lezat yang cocok untuk segala suasana , beragam pilihan menu mulai dari masakan Indonesia hingga Western." , image: ImageDir.solariaImage),
    CardModel(id: 2, title: 'LUIS FruitShop' , description: 'Luis FruitShop menghadirkan buah - buahan segar berkualitas tingi dengan harga spesial! \n Segarkan hari Anda dengan buah-buahan terbaik dari Luis FruitShop' , image: ImageDir.luisFoodShop)
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
                    children: List.generate(categoryList1.length, (index) {
                      return Row(children: [CategoryItem(categoryModel: categoryList1[index],) , const SizedBox(width: 16) ],);
                    })
                    ,
                  ),
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(categoryList2.length ,  (index)  {
                      return Row(
                        children: [
                          CategoryItem(categoryModel: categoryList2[index],),
                          const SizedBox(width: 16),
                        ],
                      );
                    }),
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
                    return CardItem(cardModel: cardList[index]);
                  },
                ),
                const SizedBox(height: 120,),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavbar(currentIndex: 0),
    );
  }

  

 
}
