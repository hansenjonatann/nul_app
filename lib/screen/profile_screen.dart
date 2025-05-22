import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/constants/url.dart';
import 'package:nul_app/controller/auth/auth_controller.dart';
import 'package:nul_app/utils/image_dir.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final authC = Get.put(AuthController());
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.offNamed('/home'),
            icon: const Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Profile',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onSelected: (value) {
              // Add action based on value
              if (value == 1) {
                // Example: Logout or Edit Profile
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: 1,
                  child: GestureDetector(
                      onTap: () => Get.toNamed('/edit-profile'),
                      child: Text("Edit Profile"))),
              PopupMenuItem(
                  value: 2,
                  child: GestureDetector(
                      onTap: () {
                        authC.logout();
                      },
                      child: Text("Logout"))),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          final user = authC.userProfile.value;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 24),
                Center(
                  child: user.pictureUrl != null
                      ? CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(
                              '${API_DEV_URL}api${user.pictureUrl}'),
                        )
                      : CircleAvatar(
                          backgroundColor: appPrimary,
                          radius: 70,
                          child: Center(
                              child: Icon(Icons.person,
                                  size: 80, color: appWhite))),
                ),
                const SizedBox(height: 16),
                Text(
                  user.name ?? 'No Name',
                  style: GoogleFonts.montserrat(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  user.email ?? 'noname@gmail.com',
                  style: GoogleFonts.montserrat(
                      fontSize: 16, color: Colors.grey[700]),
                ),
                const SizedBox(height: 24),
                Divider(),
                const SizedBox(height: 8),

                _buildProfileTile('Gender', user.gender ?? 'Not Set'),
                _buildProfileTile('Phone', user.phone ?? '0123456789'),
                _buildProfileTile(
                    'Date of Birth',
                    user.dob ??
                        'Not Set'), // Bisa tambahkan tombol set DOB kalau kosong
                _buildProfileTile('Country', user.country ?? 'Not Set'),

                const SizedBox(height: 20),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildProfileTile(String title, String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(Icons.info_outline, color: appPrimary),
      title: Text(
        title,
        style:
            GoogleFonts.montserrat(fontWeight: FontWeight.w500, fontSize: 16),
      ),
      subtitle: Text(
        value,
        style:
            GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
