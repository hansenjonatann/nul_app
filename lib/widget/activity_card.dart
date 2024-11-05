import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({super.key , required this.placeName , required this.menu , required this.total , required this.orderDate , required this.orderTime});

  final String placeName;
  final String menu;
  final String total;
  final String orderDate; 
  final String orderTime;


  @override
  Widget build(BuildContext context) {
    return Container(
              height: 136,
              decoration: BoxDecoration(
                color: appLightBlue
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8 , horizontal: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(placeName , style: GoogleFonts.montserrat(fontSize: 16 , fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10,),
                            Text(menu, style: GoogleFonts.montserrat(fontSize: 12 )),
                            const SizedBox(height: 8,),
                           Row(
                              children: [
                                Text('Total' , style: GoogleFonts.montserrat(fontSize: 12)),
                                const SizedBox(width: 10),
                                Text(total , style: GoogleFonts.montserrat(fontSize: 12)),
                                
                              ],
                            ),
                            const SizedBox(height: 18,),
                            Row(
                              children: [
                                  const Icon(Icons.trolley),
                                  const SizedBox(width: 14,),
                                  Text('Order lagi' , style: GoogleFonts.montserrat(fontWeight: FontWeight.bold))
                                ],)
                          ],
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          
                          child:   Container(

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                            
                              children: [
                                Text(orderDate , style: GoogleFonts.montserrat(fontSize: 12, )),
                                const SizedBox(height: 20),
                                Text(orderTime , style: GoogleFonts.montserrat(fontSize: 12)),
                              ],
                            ),
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