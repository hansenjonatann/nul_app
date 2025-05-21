import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:get/get.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({
    super.key,
    required this.storeName,
    required this.storeDesc,
    required this.storeImage,
  });

  final String storeName;
  final String storeDesc;
  final String storeImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(storeImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(storeName,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 6),
                Text(storeDesc,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500, fontSize: 12)),
                const SizedBox(
                  height: 8.0,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                            color: appPrimary,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text('Book',
                                style: GoogleFonts.montserrat(
                                    color: appWhite,
                                    fontWeight: FontWeight.bold)))),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
