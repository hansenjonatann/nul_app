import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/controller/auth/auth_controller.dart';
import 'package:nul_app/utils/image_dir.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final authC = Get.put(AuthController());
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          backgroundColor: Colors.transparent,
          actions: [
            TextButton(
                onPressed: () {
                  authC.logout();
                },
                child: Icon(Icons.logout, color: appRed))
          ],
          title: Text('Profil',
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold, fontSize: 20)),
          centerTitle: true,
        ),
        body: SafeArea(child: Obx(() {
          final user = authC.userProfile.value;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: Container(
                    width: 175,
                    height: 175,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(175)),
                    child: CircleAvatar(
                      radius: 175,
                      backgroundImage: user.pitcureUrl != null
                          ? NetworkImage(user.pitcureUrl.toString())
                          : AssetImage(ImageDir.profile),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Row(children: [
                  Text('Name :',
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(user.name != null ? user.name.toString() : 'No Name',
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold))
                ]),
                const SizedBox(
                  height: 8.0,
                ),
                Row(children: [
                  Text('Email :',
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                      user.email != null
                          ? user.email.toString()
                          : 'noname@gmail.com',
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold))
                ]),
                const SizedBox(
                  height: 8.0,
                ),
                Row(children: [
                  Text('Gender :',
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(user.gender != null ? user.gender.toString() : 'MALE',
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold))
                ]),
                const SizedBox(
                  height: 8.0,
                ),
                Row(children: [
                  Text('Phone :',
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                      user.phone != null ? user.phone.toString() : '0123456789',
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold))
                ]),
                const SizedBox(
                  height: 8.0,
                ),
                Row(children: [
                  Text('Date of Birth :',
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    width: 10.0,
                  ),
                  user.dob != null
                      ? Text(user.dob.toString(),
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold))
                      : Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: appPrimary,
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Set your date of birth',
                                style: GoogleFonts.montserrat(
                                    color: appWhite,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                          ))
                ]),
                const SizedBox(
                  height: 8.0,
                ),
                Row(children: [
                  Text('Country :',
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                      user.country != null
                          ? user.country.toString()
                          : 'Country not set',
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold))
                ]),
              ],
            ),
          );
        })));
  }
}
