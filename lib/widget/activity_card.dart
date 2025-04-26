import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/core/navigation.dart';
import 'package:nul_app/screen/activity_detail_screen.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({super.key, required this.activityModel});

  final activityModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NullAppNavigation().pushNamed(ActivityDetailScreen.routeName,
            arguments: {'activityModel': activityModel});
      },
      child: Container(
        height: 136,
        decoration: BoxDecoration(
          color: appWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: appPrimary, width: 1),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('${activityModel.orderDate} ,'),
                      const SizedBox(
                        width: 2.0,
                      ),
                      Text(activityModel.orderTime)
                    ],
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Row(children: [
                    Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset(
                          activityModel.image,
                          fit: BoxFit.cover,
                        )),
                    const SizedBox(width: 8.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(activityModel.placeName,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                            )),
                        Row(
                          children: [
                            Text(activityModel.menu,
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400)),
                            Text('${activityModel.qty.toString()} x',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400)),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text('${activityModel.price.toString()} ',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400))
                          ],
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Row(
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Rp ${activityModel.total}',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  const SizedBox(
                                    height: 4.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.trolley, color: appPrimary),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Text('Order lagi?',
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.bold,
                                          ))
                                    ],
                                  )
                                ])
                          ],
                        )
                      ],
                    )
                  ]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
