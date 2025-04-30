import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/core.dart';

class UMKMMainScreen extends StatelessWidget {
  UMKMMainScreen({super.key});

  AuthController _authC = Get.put(AuthController());

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
                Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        _authC.logout();
                      },
                      child: Container(
                        width: 108,
                        height: 108,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: appRed,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.logout, size: 30, color: appWhite),
                            const SizedBox(height: 7),
                           Obx(() => _authC.isLoading.value == true ?  Text(
                              'Please wait...',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: appWhite),
                              textAlign: TextAlign.center,
                            ) : Text(
                              'Sign Out',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: appWhite),
                              textAlign: TextAlign.center,
                            ), )
                          ],
                        ),
                      ),
                    )),
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
      "onTap": () {},
    },
    {
      "icon": Icons.analytics_outlined,
      "label": "Report",
      "onTap": () {},
    },
  ];
  return Row(
    children: List.generate(
      features.length,
      (index) {
        final feature = features[index];
        return InkWell(
          onTap: feature['onTap'],
          child: Container(
            margin: EdgeInsets.only(left: 14),
            width: 108,
            height: 108,
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
  return Container(
    width: double.infinity,
    height: 120,
    decoration: BoxDecoration(
      color: appPrimary,
      borderRadius: BorderRadius.only(
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(120)),
            child: CircleAvatar(
              radius: 120,
              backgroundImage: AssetImage(
                ImageDir.profile,
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama Owner',
                style: GoogleFonts.montserrat(
                    color: appWhite, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                'Nama Owner',
                style: GoogleFonts.montserrat(
                    color: appWhite, fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildStatsSection() {
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('7',
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown)),
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
              Text('7',
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: appWhite)),
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
