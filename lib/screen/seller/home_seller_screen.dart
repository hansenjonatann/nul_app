import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/core/navigation.dart';

class HomeSellerScreen extends StatelessWidget {
   HomeSellerScreen({super.key});

  static const routeName = '/homeseller-screen';

  final List tools = [
    {
      "id" : 1,
      "icon": Icons.dashboard,
      "label" : "Dashboard",
      "path" : '/dashboard-screen'
    },
    {
      "id" : 2,
      "icon" : Icons.discount,
      "label" : "Promotion",
      "path" : "/promotion-screen"
    },
    {
      "id" : 3,
      "icon" : Icons.storage,
      "label" : "Product",
      "path" : "/product-screen"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Seller's Name" , style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,)),
                    CircleAvatar(child: Icon(Icons.store_mall_directory))
                  ],
                  

                ),
                const SizedBox(
                  height: 10.0,
                  ),
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(color: appPrimary , borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 70 , 
                              decoration: BoxDecoration(
                                color: appWhite,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                  height: 4.0,
                                  ),
                                  Text('Total order hari ini' , style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                                  const SizedBox(
                                  height: 8.0,
                                  ),
                                  Text('8' , style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 20))
                                ],
                              )
                            ),
                          ),
                          const SizedBox(
                          width: 5.0,
                          ),
                          
                           Expanded(
                             child: Container(
                              height: 70 , 
                              decoration: BoxDecoration(
                                color: appWhite,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                  height: 4.0,
                                  ),
                                  Text('Total order minggu ini' , style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                                  const SizedBox(
                                  height: 8.0,
                                  ),
                                  Text('20' , style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 20))
                                ],
                              )
                                                       ),
                           )
                        ],
                      ),
                    )
                  ),
                  const SizedBox(
                  height: 20.0,
                  ),
                   Row(
          children: List.generate(tools.length, (index) {
            return Row(
              children: [
                InkWell(
                  onTap: () {
                    NullAppNavigation().pushNamed(tools[index].path);
                  },
                  child: Container(
                    width: 105,
                    height: 105, 
                    decoration: BoxDecoration(color: appPrimary , ),
                    child: Column(
                      children: [
                        Icon(tools[index].icon)
                      ]
                    )
                  ),
                ),
                const SizedBox(width: 16),
              ],
            );
          }),
        ),
              ]
            ),
          )
        )
      )
    );
  }
}