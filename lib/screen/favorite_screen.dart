import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/controller/location_favorite_controller.dart';
import 'package:nul_app/widget/custom_bottom_navbar.dart';
import 'package:nul_app/widget/favorite_card.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});

  final LocationFavoriteController _locationFavoriteC =
      Get.put(LocationFavoriteController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed('/home');
                      },
                      child: const Icon(
                        Icons.arrow_circle_left_outlined,
                        size: 30,
                      )),
                  const SizedBox(
                    width: 55,
                  ),
                  Row(
                    children: [
                      Text('Favorit Saya',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      Obx(
                        () => Text(
                            '(${_locationFavoriteC.favoriteLocations.value.length.toString()})',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 41,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Obx(() {
                  if (_locationFavoriteC.loading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final favorites = _locationFavoriteC.favoriteLocations.value;

                  if (favorites.isEmpty) {
                    return const Center(
                        child: Text("Tidak ada lokasi favorit"));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      final location = favorites[index];

                      return FavoriteCard(
                        storeName: location.location?.name.toString() ?? '',
                        storeDesc: location.location?.desc.toString() ?? '',
                        storeImage:
                            location.location?.imageUrl.toString() ?? '',
                      );
                    },
                  );
                }),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavbar(currentIndex: 3),
    );
  }
}
