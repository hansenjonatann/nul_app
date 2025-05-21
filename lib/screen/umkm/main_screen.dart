import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/controller/umkm/auth_controller.dart';
import 'package:nul_app/controller/location_controller.dart';
import 'package:nul_app/controller/umkm/umkm-booking_controller.dart';
import 'package:nul_app/core.dart';

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
                  height: 15.0,
                ),
                _buildFeaturesSection(),
                const SizedBox(
                  height: 12.0,
                ),
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
    },
    {
      "icon": Icons.logout,
      "label": "Sign Out",
      "onTap": () {
        _authC.logout();
      }
    }
  ];
  return GridView.count(
    shrinkWrap: true, // Jika berada di dalam scrollable lain
    physics: NeverScrollableScrollPhysics(), // Supaya tidak scroll sendiri
    crossAxisCount: 2,
    mainAxisSpacing: 14,
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

    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: appPrimary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(30),
          topLeft: Radius.circular(30),
          topRight: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(120),
              ),
              child: const CircleAvatar(
                radius: 120,
                backgroundImage: AssetImage(ImageDir.profile),
              ),
            ),
            const SizedBox(width: 20.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name ?? 'No Name',
                  style: GoogleFonts.montserrat(
                    color: appWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  user.email ?? 'No Email',
                  style: GoogleFonts.montserrat(
                    color: appWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
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
