import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({super.key , required this.storeName , required this.storeTag , required this.quantityTotalOrder , required this.storeImage});

  final String storeName; 
  final String storeTag;
  final int quantityTotalOrder;
  final String storeImage;


  @override
  Widget build(BuildContext context) {
    return Row(children: [
                      Container(
                        width: 185,
                        height: 185,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                        child: Image.asset(storeImage)
                      ),
                      const SizedBox(width: 16,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(storeName , style: GoogleFonts.montserrat(fontWeight: FontWeight.bold , fontSize: 16 )),
                          Text('#${storeTag}' , style: GoogleFonts.montserrat(fontSize: 12)),
                          const SizedBox(height: 11,),
                          Container(
                          height: 72,
                          width: 131,
                          decoration: const BoxDecoration(
                          color: Colors.blue,
                          ),
                          child: Center(
                            child: Text('${quantityTotalOrder} ORDER' , style: GoogleFonts.montserrat(fontSize: 16 , fontWeight: FontWeight.bold, ))
                          ),
                          ),

                          const SizedBox(height: 18,),
                          Row(
                            children: [
                              Icon(Icons.trolley),
                              SizedBox(width: 16),
                              Text('Cek Lagi' , style: GoogleFonts.montserrat(color: appPrimary , fontWeight: FontWeight.bold,))
                            ],
                          )


                        ],
                      )
                    ],);
  }
}