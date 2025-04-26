import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard(
      {super.key,
      required this.storeName,
      required this.storeTag,
      required this.quantityTotalOrder,
      required this.storeImage});

  final String storeName;
  final String storeTag;
  final int quantityTotalOrder;
  final String storeImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Image.asset(storeImage)),
        const SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(storeName,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold, fontSize: 16)),
            Text('#$storeTag', style: GoogleFonts.montserrat(fontSize: 14)),
            const SizedBox(
              height: 11,
            ),
            Container(
              height: 72,
              width: 131,
              decoration: const BoxDecoration(
                color: appPrimary,
              ),
              child: Center(
                  child: Text('$quantityTotalOrder Order',
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: appWhite))),
            ),
            const SizedBox(
              height: 18,
            ),
          ],
        )
      ],
    );
  }
}
