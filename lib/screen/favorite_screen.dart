import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/screen/home_screen.dart';
import 'package:nul_app/utils/image_dir.dart';
import 'package:nul_app/widget/custom_bottom_navbar.dart';
import 'package:nul_app/widget/favorite_card.dart';

class FavoriteScreen extends StatelessWidget {
   const FavoriteScreen({super.key});

  // List favoriteList = [
  //   {
  //     "id": 1,
  //     "name" : "RM Bakso Wonogiri",
  //     "tag" : "Aneka Bakso Cepat Saji",
  //     "total" : 40 , 
  //     "image" : ImageDir.baksoWonogiri

  //   },

  //   {
  //     "id": 2,
  //     "name" : "RIVS Kemeja",
  //     "tag" : "Kemeja Pria dan Wanita",
  //     "total" : 28 , 
  //     "image" : ImageDir.rivs
  //   },

  //   {
  //     "id": 3,
  //     "name" : "KFC Batu Aji, Batam",
  //     "tag" : "Aneka Ayam , Cepat Saji",
  //     "total" : 21 , 
  //     "image" : ImageDir.kfc
  //   },

  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                
                children: [
                  const SizedBox(width: 20,),
                  GestureDetector( onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
                  }  ,child: const Icon(Icons.arrow_circle_left_outlined, size: 30, )),
                  const SizedBox(width: 55,),
                  Row(
                    children: [
                      Text('Favorit Saya' , style: GoogleFonts.montserrat(fontWeight: FontWeight.bold , fontSize: 20)),
                      Text(' ( 23 )' , style: GoogleFonts.montserrat(fontWeight: FontWeight.bold , fontSize: 20)),
                    ],
                    
                  ),
                    
                ],
              ),
              const SizedBox(height: 41,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          FavoriteCard(storeName: 'RM Bakso Wonogiri', storeTag: 'Aneka Bakso , Cepat Saji', quantityTotalOrder: 40, storeImage: ImageDir.baksoWonogiri),
                          const SizedBox(
                          height: 30.0,
                          ),
                          FavoriteCard(storeName: 'RIVS Kemeja', storeTag: 'Kemeja Pria dan Wanita', quantityTotalOrder: 28, storeImage: ImageDir.rivs),
                          const SizedBox(
                          height: 30.0,
                          ),
                          FavoriteCard(storeName: 'KFC Batu Aji , Batam', storeTag: 'Aneka Ayam , Cepat Saji', quantityTotalOrder: 21, storeImage: ImageDir.kfc)
                        ],
                      )
                    )
            ],
          
          ),
        ),

        
      ),
      bottomNavigationBar: CustomBottomNavbar(currentIndex: 2),
    );
  }
}