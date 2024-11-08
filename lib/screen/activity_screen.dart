import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/models/activity_model.dart';
import 'package:nul_app/widget/activity_card.dart';
import 'package:nul_app/widget/custom_bottom_navbar.dart';

class ActivityScreen extends StatelessWidget {
   ActivityScreen({super.key});

  static const routeName = '/activity-screen';

  List<ActivityModel> activityList = [
    ActivityModel(placeName: 'RM Bakso Wonogiri', menu: 
      'Mie Ayam x2 (55.000)',
     total: 65000, orderDate: 'Senin , 14 Oktober 2024', orderTime: '18:04:37'),
                   ActivityModel(placeName: "Solaria's Cafe", menu: 
                    'Nasi Goreng Kambing x1 (33.500)'
                   , total: 33500, orderDate: 'Minggu , 13 Oktober 2024', orderTime: '11:22:41'),
                   ActivityModel(placeName: "Solaria's Cafe", menu: 'Kwetiau Seafood Siram x4 (124.000)', total: 124000, orderDate: 'Jumat , 11 Oktober 2024', orderTime: '17:04:30'),
                   ActivityModel(placeName: "KFC Batu Aji, Batam", menu: 'Super Komplit Paket x3 (144.000)', total: 144000, orderDate: 'Selasa , 8 Oktober 2024', orderTime: '19:04:37'),
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            const SizedBox(height: 20,),
            
            Center(child:  Text('Aktivitas' , style: GoogleFonts.montserrat(fontWeight: FontWeight.bold , fontSize: 20))),
          
            const SizedBox(height: 20,),
            Center(
              child: Container(
                width: 290,
                height: 82,
                decoration: BoxDecoration(
                  color: appLightBlue,
                  borderRadius: BorderRadius.circular(10)
          
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 7,),
                    Text('PERINGATAN: ' , style: GoogleFonts.montserrat(fontSize: 16 , fontWeight: FontWeight.bold) ),
                    Text('AKTIVITAS HANYA AKAN ' , style: GoogleFonts.montserrat(fontWeight: FontWeight.bold , fontSize: 16)),
                    Text('MENYIMPAN REKORD 1 MINGGU ' , style: GoogleFonts.montserrat(fontWeight: FontWeight.bold , fontSize: 16))
                  ],
                )
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: List.generate(activityList.length, (index) => Column(
                  children: [
                    ActivityCard(activityModel: activityList[index]),
                    const SizedBox(
                    height: 15.0,
                    ),
                  ],
                )),
              )
            )
          ],),
        )
      ),
      bottomNavigationBar: CustomBottomNavbar(currentIndex: 1),
    );
  }
}