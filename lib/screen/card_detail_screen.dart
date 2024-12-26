import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/core/navigation.dart';
import 'package:nul_app/models/card_model.dart';

class CardDetailScreen extends StatelessWidget {
  static const String routeName = '/card-detail';
  const CardDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String,dynamic>{}) as Map;
    CardModel cardModel = arguments['cardModel'] as CardModel;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 300,
            child: Image.asset(cardModel.image.toString() , fit: BoxFit.cover)
          ),
          const SizedBox(
          height: 8.0,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cardModel.title , style: GoogleFonts.montserrat(fontSize: 24 , fontWeight: FontWeight.bold,),),
        const SizedBox(
        height: 10.0,
        ),
        SingleChildScrollView(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          Text(cardModel.description, style: GoogleFonts.montserrat(fontSize: 16)),
          const SizedBox(height: 10.0),
          Text("MENU", style: GoogleFonts.montserrat(fontSize: 40, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: cardModel.menu!.map<Widget>((menuItem) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(menuItem.name, style: GoogleFonts.montserrat(fontSize: 16)),
              Text('\$${menuItem.price.toString()}', style: GoogleFonts.montserrat(fontSize: 16)),
            ],
                ),
              );
            }).toList(),
          ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: appPrimary,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Center(child: Text('Book Now' , style: GoogleFonts.montserrat(color: appWhite , fontWeight: FontWeight.bold,)))
        ),
        const SizedBox(
        height: 10.0,
        ),
        
            ],
          )
        ),
        

        ],
        ),
      ),
    );
  }
}