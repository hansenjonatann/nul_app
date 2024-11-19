import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/core/navigation.dart';
import 'package:nul_app/screen/card_detail_screen.dart';

class CardItem extends StatelessWidget {
  const CardItem({required this.cardModel});

  final cardModel;

  @override

  Widget build(BuildContext context) {
    return   InkWell(
      onTap: () {
        NullAppNavigation().pushNamed(CardDetailScreen.routeName  , arguments: {'cardModel' : cardModel});
      },
      child: Container(
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
                cardModel.image,
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
                    cardModel.title,
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    cardModel.description,
                    style: GoogleFonts.montserrat(fontSize: 10),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}