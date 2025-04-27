import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/models/activity_model.dart';

class ActivityDetailScreen extends StatelessWidget {
  const ActivityDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    ActivityModel activityModel = arguments['activityModel'] as ActivityModel;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Order date    : ',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(activityModel.orderDate,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold, fontSize: 16))
                      ],
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Row(
                      children: [
                        Text('Order Time    : ',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(activityModel.orderTime,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold, fontSize: 16))
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: [
                        Text('Place Name   : ',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(activityModel.placeName,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Address          : ',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text('Jl.Nagoya , No.24 ',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ))
                      ],
                    ),
                  ],
                )
              ]),
              const SizedBox(
                height: 20.0,
              ),
              Text('Order Detail',
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(
                height: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${activityModel.menu} (${activityModel.qty} x Rp${activityModel.price}) ',
                      style: GoogleFonts.montserrat(fontSize: 18)),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tax', style: GoogleFonts.montserrat(fontSize: 18)),
                      Text(
                          '${(activityModel.price * activityModel.qty) * (11 / 100)}',
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ))
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [Text('Total')],
                  )
                ],
              )
            ],
          ),
        )));
  }
}
