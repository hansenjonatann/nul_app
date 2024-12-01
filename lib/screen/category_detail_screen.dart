import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/core/navigation.dart';
import 'package:nul_app/models/card_model.dart';
import 'package:nul_app/models/category_model.dart';
import 'package:nul_app/utils/image_dir.dart';
import 'package:nul_app/widget/favorite_card.dart';

class CategoryDetailScreen extends StatelessWidget {

  static const String routeName = '/category-detail';
  CategoryDetailScreen({super.key});

  List<CardModel> cardList = [
    CardModel(id: 1, title: "Solaria's Cafe" , description: "Solaria's Cafe menyajikan hindangan lezat yang cocok untuk segala suasana , beragam pilihan menu mulai dari masakan Indonesia hingga Western." , image: ImageDir.solariaImage),
    CardModel(id: 2, title: 'LUIS FruitShop' , description: 'Luis FruitShop menghadirkan buah - buahan segar berkualitas tingi dengan harga spesial! \n Segarkan hari Anda dengan buah-buahan terbaik dari Luis FruitShop' , image: ImageDir.luisFoodShop)
   ];

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    CategoryModel categoryModel = arguments['categoryModel'] as CategoryModel;
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    NullAppNavigation().pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
                   SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2
                  ),
              Text(categoryModel.label,
                  style: GoogleFonts.montserrat(
                    color: appPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ))
            ],
          ),
        ),
        const SizedBox(
        height: 30.0,
        ),
        Column(
          children: List.generate(cardList.length , (index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Container(
                      height: 120,
                      width: 120,
                      decoration:  BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20)
                      
                      ),
                      child: Image.asset(
                        cardList[index].image.toString(),
                        fit: BoxFit.cover
                      )
                      ),
                      const SizedBox(
                      width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cardList[index].title , style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,)),
                          const SizedBox(
                          height: 10.0,
                          ),
                          Text(cardList[index].description , overflow: TextOverflow.fade,)
                        ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                height: 15.0,
                ),
              ],
            );
          }),
        )
       
        
      ],
    )));
  }
}
