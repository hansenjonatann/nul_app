import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({ required this.activityModel});

  final activityModel;


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
                            Text(activityModel.placeName , style: GoogleFonts.montserrat(fontSize: 16 , fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10,),
                            Text(activityModel.menu, style: GoogleFonts.montserrat(fontSize: 12 )),
                            const SizedBox(height: 8,),
                           Row(
                              children: [
                                Text('Total' , style: GoogleFonts.montserrat(fontSize: 12)),
                                const SizedBox(width: 10),
                                Text(activityModel.total.toString() , style: GoogleFonts.montserrat(fontSize: 12)),
                                
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
                                Text(activityModel.orderDate , style: GoogleFonts.montserrat(fontSize: 12, )),
                                const SizedBox(height: 20),
                                Text(activityModel.orderTime , style: GoogleFonts.montserrat(fontSize: 12)),
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