import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/controller/umkm/auth_controller.dart';
import 'package:nul_app/controller/location_controller.dart';
import 'package:nul_app/controller/umkm/umkm-booking_controller.dart';
import 'package:nul_app/core.dart';
import 'package:table_calendar/table_calendar.dart';

final _authC = Get.find<AuthController>();

// ignore: must_be_immutable

class UMKMMainScreen extends StatelessWidget {
  const UMKMMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                _buildProfileSection(),
                const SizedBox(
                  height: 20.0,
                ),
                _buildStatsSection(),
                const SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Menu',
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(
                        height: 10.0,
                      ),
                      _buildFeaturesSection(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                _buildBookingCalendar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildFeaturesSection() {
  final List<Map<String, dynamic>> features = [
    {
      "icon": Icons.location_on_outlined,
      "label": "Location",
      "onTap": () {
        Get.toNamed('/umkm/location');
      },
    },
    {
      "icon": Icons.book,
      "label": "Booking",
      "onTap": () {
        Get.toNamed('/umkm/booking');
      },
    },
    {
      "icon": Icons.analytics_outlined,
      "label": "Report",
      "onTap": () {},
    }
  ];
  return GridView.count(
    shrinkWrap: true, // Jika berada di dalam scrollable lain
    physics: NeverScrollableScrollPhysics(), // Supaya tidak scroll sendiri
    crossAxisCount: 3,
    mainAxisSpacing: 1,
    crossAxisSpacing: 14,
    childAspectRatio: 1, // Untuk menjaga rasio 1:1
    children: List.generate(
      features.length,
      (index) {
        final feature = features[index];
        return InkWell(
          onTap: feature['onTap'],
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: appLightGrey,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(feature['icon'], size: 30),
                const SizedBox(height: 7),
                Text(
                  feature['label'],
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

Widget _buildProfileSection() {
  final _umkmAuthC = Get.put(UMKMAuthController());

  return Obx(() {
    final user = _umkmAuthC.umkmProfile.value;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: appPrimary,
                  borderRadius: BorderRadius.circular(120),
                ),
                child: const CircleAvatar(
                  backgroundColor: appPrimary,
                  child: Center(child: Icon(Icons.person, color: appWhite)),
                ),
              ),
              const SizedBox(width: 17.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name ?? 'No Name',
                    style: GoogleFonts.montserrat(
                      color: appDarkGrey,
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    user.role ?? 'No Email',
                    style: GoogleFonts.montserrat(
                      color: appDarkGrey,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          IconButton(onPressed: () => _authC.logout(), icon: Icon(Icons.logout))
        ],
      ),
    );
  });
}

Widget _buildStatsSection() {
  LocationController _locationC = Get.put(LocationController());
  UMKMBookingController _umkmBookingC = Get.put(UMKMBookingController());
  return Row(
    children: [
      Expanded(
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: appPrimary.withValues(alpha: 0.3),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Text(_umkmBookingC.bookings.value.length.toString(),
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: appRed))),
              const SizedBox(
                width: 10.0,
              ),
              Text('Bookings',
                  style: GoogleFonts.montserrat(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ),
      ),
      const SizedBox(
        width: 10.0,
      ),
      Expanded(
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: appPrimary.withValues(alpha: 0.8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Text(_locationC.locations.value.length.toString(),
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: appWhite))),
              const SizedBox(
                width: 10.0,
              ),
              Text('Locations',
                  style: GoogleFonts.montserrat(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: appWhite)),
            ],
          ),
        ),
      )
    ],
  );
}

Widget _buildBookingCalendar() {
  final UMKMBookingController _bookingC = Get.put(UMKMBookingController());

  return Obx(() {
    final bookings = _bookingC.bookings.value;

    // Mapping tanggal ke list booking
    Map<DateTime, List<String>> events = {};
    for (var booking in bookings) {
      final date =
          DateTime.parse(booking.dateTime.toString()); // Sesuaikan field 'date'
      events.update(
        DateTime(date.year, date.month, date.day),
        (existing) => [...existing, booking.user?.name.toString() ?? ''],
        ifAbsent: () => [booking.user?.name.toString() ?? ''],
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Booking Calendar",
              style: GoogleFonts.montserrat(
                  fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          TableCalendar(
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: DateTime.now(),
            eventLoader: (day) {
              return events[DateTime(day.year, day.month, day.day)] ?? [];
            },
            calendarStyle: CalendarStyle(
              markerDecoration: BoxDecoration(
                color: appPrimary,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: appRed,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: appPrimary.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
            ),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isNotEmpty) {
                  return Positioned(
                    right: 1,
                    bottom: 1,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  });
}
