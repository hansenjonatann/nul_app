import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
// import 'package:nul_app/models/card_model.dart';
import 'package:nul_app/models/category_model.dart';
// import 'package:nul_app/utils/image_dir.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CategoryDetailScreen extends StatelessWidget {
  CategoryDetailScreen({super.key});

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
                   Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
              SizedBox(width: MediaQuery.of(context).size.width * 0.2),
              Text(categoryModel.name,
                  style: GoogleFonts.montserrat(
                      color: appPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20))
            ],
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        // Column(
        //   children: List.generate(cardList.length, (index) {
        //     return Column(
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 10),
        //           child: Row(
        //             children: [
        //               InkWell(
        //                 onTap: () {
                          
        //                   Get.toNamed('/card-detail'  , arguments: {'cardModel' : cardList[index]});
        //                 },
        //                 child: Container(
        //                     height: 120,
        //                     width: 120,
        //                     decoration: BoxDecoration(
        //                         color: Colors.transparent,
        //                         borderRadius: BorderRadius.circular(20)),
        //                     child: Image.asset(cardList[index].image.toString(),
        //                         fit: BoxFit.cover)),
        //               ),
        //               const SizedBox(
        //                 width: 10.0,
        //               ),
        //               Expanded(
        //                 child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Text(cardList[index].title,
        //                         style: GoogleFonts.montserrat(
        //                           fontWeight: FontWeight.bold,
        //                         )),
        //                     const SizedBox(
        //                       height: 10.0,
        //                     ),
        //                     Text(
        //                       cardList[index].description,
        //                       overflow: TextOverflow.fade,
        //                     )
        //                   ],
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //         const SizedBox(
        //           height: 15.0,
        //         ),
        //       ],
        //     );
        //   }),
        // )
      ],
    )));
  }
}
