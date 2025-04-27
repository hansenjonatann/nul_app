import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/models/activity_model.dart';
import 'package:nul_app/utils/image_dir.dart';
import 'package:nul_app/widget/activity_card.dart';
import 'package:nul_app/widget/custom_bottom_navbar.dart';

// ignore: must_be_immutable
class ActivityScreen extends StatelessWidget {
   ActivityScreen({super.key});


  List<ActivityModel> activityList = [
    ActivityModel(placeName: 'RM Bakso Wonogiri', menu: 
      'Mie Ayam ' , qty: 2 , price: 55000,
     total: 65000, orderDate: '14 Oktober 2024', orderTime: '18:04:37' , image: ImageDir.baksoWonogiri),
                   ActivityModel(placeName: "Solaria's Cafe", menu: 
                    'Nasi Goreng Kambing ' , price: 33500 , qty: 1
                   , total: 33500, orderDate: '13 Oktober 2024', orderTime: '11:22:41' , image: ImageDir.solariaImage),
                   ActivityModel(placeName: "Solaria's Cafe", menu: 'Kwetiau Seafood Siram', qty: 4, price: 31000, total: 124000, orderDate: '11 Oktober 2024', orderTime: '17:04:30' , image: ImageDir.solariaImage),
                   ActivityModel(placeName: "KFC Batu Aji, Batam", menu: 'Super Komplit Paket ', price: 21000, qty: 3, total: 63000, orderDate: '8 Oktober 2024', orderTime: '19:04:37' , image: ImageDir.kfc),
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
      bottomNavigationBar: const CustomBottomNavbar(currentIndex: 1),
    );
  }
}