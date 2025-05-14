import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/controller/location_controller.dart';
import 'package:nul_app/core.dart';

class LocationDetailScreen extends StatelessWidget {
  LocationDetailScreen({super.key});

  final LocationController _locationC = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    final int locationId = Get.arguments['locationId'];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (locationId != 0 &&
          _locationC.selectedLocation.value.id != locationId) {
        _locationC.detailLocation(id: locationId);
      }
    });

    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios))),
        body: SafeArea(
          child: Obx(() {
            final location = _locationC.selectedLocation.value;
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                      width: double.infinity,
                      child: location.imageUrl != null
                          ? Image.network(location.imageUrl.toString())
                          : Center(
                              child: Icon(
                                Icons.location_on,
                                size: 30,
                                color: appPrimary,
                              ),
                            )),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(location.name.toString(),
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              location.rateCount != null
                                  ? location.rateCount.toString()
                                  : '0',
                              style: GoogleFonts.montserrat(fontSize: 14),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
        ));
  }
}
