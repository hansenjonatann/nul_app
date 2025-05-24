import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/controller/booking_controller.dart';
import 'package:nul_app/controller/location_controller.dart';
import 'package:nul_app/core.dart';
import 'package:intl/intl.dart';

class LocationDetailScreen extends StatelessWidget {
  LocationDetailScreen({super.key});

  final LocationController _locationC = Get.find<LocationController>();
  final BookingController _bookingC = Get.find<BookingController>();

  final TextEditingController _headCountC = TextEditingController();
  final TextEditingController _dateC = TextEditingController();
  final TextEditingController _timeC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final int locationId =
        args != null && args['locationId'] != null ? args['locationId'] : 0;

    _locationC.detailLocation(id: locationId);

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios))),
      body: SafeArea(
        child: Obx(
          () {
            final location = _locationC.selectedLocation.value;
            // final isFavorite = location.favorites?.isNotEmpty ?? false;
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                      width: double.infinity,
                      child: location.imageUrl != null
                          ? Image.network(
                              location.imageUrl.toString(),
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Icon(
                                Icons.location_on,
                                size: 30,
                                color: appPrimary,
                              ),
                            )),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(location.name.toString(),
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber),
                                const SizedBox(width: 5.0),
                                Text(
                                  location.rating != null
                                      ? location.rating.toString()
                                      : '0',
                                  style: GoogleFonts.montserrat(fontSize: 14),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(width: 5.0),
                                // IconButton(
                                //   onPressed: () {
                                //     if (!isFavorite) {
                                //       _locationC.unfavorite(id: locationId);
                                //     } else {
                                //       _locationC.favorite(id: locationId);
                                //     }
                                //   },
                                //   icon: Icon(
                                //     !isFavorite
                                //         ? Icons.favorite
                                //         : Icons.favorite_border,
                                //     color: !isFavorite ? appRed : null,
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 15.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.location_on, color: appRed),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Expanded(
                              child: Text(
                                ' ${location.address}',
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(location.desc.toString()),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Get.bottomSheet(
                Container(
                  color: appWhite,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 10.0),
                          CustomTextField(
                            fieldController: _headCountC,
                            label: 'Head Count',
                            hint: 'Number of People',
                            type: TextInputType.number,
                            hidden: false,
                          ),
                          const SizedBox(height: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Booking Date',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: _dateC,
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Select Date',
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.calendar_today),
                                ),
                                onTap: () async {
                                  final DateTime? pickedDate =
                                      await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2101),
                                  );
                                  if (pickedDate != null) {
                                    _dateC.text = DateFormat('yyyy-MM-dd')
                                        .format(pickedDate);
                                  }
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Booking Time',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: _timeC,
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Select Time',
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.access_time),
                                ),
                                onTap: () async {
                                  final TimeOfDay? pickedTime =
                                      await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (pickedTime != null) {
                                    _timeC.text = pickedTime.format(context);
                                  }
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const SizedBox(height: 20.0),
                          GestureDetector(
                              onTap: () {
                                _bookingC.book(
                                    headCount: int.parse(_headCountC.text),
                                    bookingTime: _timeC.text,
                                    locationId: locationId,
                                    dateTime: _dateC.text);
                              },
                              child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(color: appPrimary),
                                  child: Center(
                                      child: Text('Book',
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.bold,
                                              color: appLightGrey,
                                              fontSize: 16))))),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: appPrimary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(
              'Book Now',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
