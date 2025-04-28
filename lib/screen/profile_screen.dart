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
                child: Text('Logout',
                    style: GoogleFonts.montserrat(color: appRed, fontSize: 15)))
          ],
          title: Text('Edit Profil',
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold, fontSize: 20)),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
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
                child: const CircleAvatar(
                  radius: 175,
                  backgroundImage: AssetImage(ImageDir.profile),
                ),
              ))
            ],
          ),
        ));
  }
}
