import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:get/get.dart';

class UMKMLocationScreen extends StatelessWidget {
  const UMKMLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(children: [
            const SizedBox(
              height: 10.0,
            ),
            Table(
              border: TableBorder.all(color: appWhite.withValues(alpha: 0.3)),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  decoration: BoxDecoration(color: appPrimary),
                  children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: Text('#' , style: GoogleFonts.montserrat(color: appWhite , fontSize: 16)),),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: Text('Name' , style: GoogleFonts.montserrat( fontWeight: FontWeight.bold, color: appWhite , fontSize: 16),),),
                      ),
                    ),
                     TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: Text('Image' , style: GoogleFonts.montserrat( fontWeight: FontWeight.bold, color: appWhite , fontSize: 16),),),
                      ),
                    ),
                     TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: Text('Action' , style: GoogleFonts.montserrat( fontWeight: FontWeight.bold, color: appWhite , fontSize: 16),),),
                      ),
                    ),
                  ],
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
