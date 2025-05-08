import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/controller/umkm/location_controller.dart';

class UMKMLocationScreen extends StatelessWidget {
  UMKMLocationScreen({super.key});
  UMKMLocationController _locationC = Get.put(UMKMLocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Location',
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold, fontSize: 20)),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Obx(
                () => _locationC.isLoading.value == true
                    ? Center(child: CircularProgressIndicator())
                    : _locationC.locations.value.length < 1
                        ? Center(
                            child: Text('No Locations data',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    color: appRed,
                                    fontSize: 18)))
                        : const ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                "https://res.cloudinary.com/dotz74j1p/raw/upload/v1716044962/tje4vyigverxlotuhvpb.png",
                              ),
                            ),
                            title: Text("John doe"),
                            subtitle: Text("john.doe@gmail.com"),
                            trailing: Icon(
                              Icons.add,
                              size: 24.0,
                            ),
                          ),
              ),
             
            ],
          ),
        ),
      ),

      floatingActionButton:  GestureDetector(
              onTap: () {
                Get.bottomSheet(Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: appPrimary
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                         Text("This is a bottom sheet"),
                          SizedBox(height: 20),
                          ElevatedButton(
                            child: Text("Close"),
                            onPressed: Get.back,
                          ),
                      ],
                    )
                  ),
                ));
              },
              child: Container(
                 width: 50, 
                height: 50,
                decoration: BoxDecoration(color: appPrimary , borderRadius: BorderRadius.circular(50)),
                    
                    child: Center(
        child: Text('+',
            style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: appWhite)))),
            ),
     
      
    
    );
  }
}
