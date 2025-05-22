import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:nul_app/constants/color.dart';
import 'package:get/get.dart';

class CardItem extends StatelessWidget {
  const CardItem({super.key, required this.cardModel});

  final cardModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('/location-detail',
            arguments: {'locationId': cardModel.id});
      },
      child: Container(
        decoration: BoxDecoration(
          color: appWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
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
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: cardModel.imageUrl != null
                  ? Image.network(
                      cardModel.imageUrl,
                      width: double.infinity,
                      height: 120,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      cardModel.imageUrl,
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
                    cardModel.name,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold, fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    cardModel.desc,
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
