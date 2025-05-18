import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/controller/location_controller.dart';
import 'package:nul_app/core.dart';
import 'package:intl/intl.dart';

class LocationDetailScreen extends StatelessWidget {
  LocationDetailScreen({super.key});

  final LocationController _locationC = Get.put(LocationController());

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

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
                                  location.rateCount != null
                                      ? location.rateCount.toString()
                                      : '0',
                                  style: GoogleFonts.montserrat(fontSize: 14),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(width: 5.0),
                                Obx(() => IconButton(
                                      onPressed: () {},
                                      icon: _locationC.isFavorite == true
                                          ? Icon(
                                              Icons.favorite,
                                              color: appRed,
                                            )
                                          : Icon(Icons.favorite),
                                    )),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 15.0),
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10.0),
                        CustomTextField(
                          label: 'Head Count',
                          hint: 'Number of People',
                          type: TextInputType.number,
                          hidden: false,
                        ),
                        const SizedBox(height: 10.0),
                        TextField(
                          controller: _dateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Select Date',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          onTap: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              _dateController.text =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                            }
                          },
                        ),
                        const SizedBox(height: 10.0),
                        TextField(
                          controller: _timeController,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Select Time',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.access_time),
                          ),
                          onTap: () async {
                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              _timeController.text = pickedTime.format(context);
                            }
                          },
                        ),
                        const SizedBox(height: 20.0),
                      ],
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
              'Book ',
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
