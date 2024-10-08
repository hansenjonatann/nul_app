import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/utils/image_dir.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
          
            children: [
              SizedBox(height: 30,),
            Padding(
              padding: EdgeInsets.only(left: 34 , right: 25),
              child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Text('Selamat Datang,' , style: GoogleFonts.montserrat(fontSize: 20 , fontWeight: FontWeight.w500)),
                    Text('Hansen Jonatan' , style: GoogleFonts.montserrat(fontWeight: FontWeight.bold , fontSize: 22))
                  ],
                ),
              Container( width:50  , height: 50 , decoration: BoxDecoration(color: appPrimary , borderRadius: BorderRadius.circular(50) ))
             ],),
            ),
          
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  SizedBox(height: 24 ,),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                hintText: 'Cari keperluanmu...',
                prefixIcon: Icon(Icons.search)
              )
            ),
          
            SizedBox(height: 16,),
            Container(width: double.infinity , child: Image.asset(ImageDir.banner , fit: BoxFit.fill,)
             ),
            SizedBox(height: 47,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: appLightGrey
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(ImageDir.foodIcon),
                        SizedBox(height: 7,),
                        Text('Food Stall' , style: GoogleFonts.montserrat(fontWeight: FontWeight.bold , fontSize: 10))
              
                      ]
                    )
                  )
                  
                  ,SizedBox(width: 16,),
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: appLightGrey
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(ImageDir.marketIcon),
                        SizedBox(height: 7,),
                        Text('Market' , style: GoogleFonts.montserrat(fontWeight: FontWeight.bold , fontSize: 10))
              
                      ]
                    ),
                  ),
              
                   SizedBox(width: 16,),
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: appLightGrey
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(ImageDir.cafeIcon),
                        SizedBox(height: 7,),
                        Text('Cafe' , style: GoogleFonts.montserrat(fontWeight: FontWeight.bold , fontSize: 10))
              
                      ]
                    ),
                  ),
                  SizedBox(width: 16,),
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: appLightGrey
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(ImageDir.shirtIcon),
                        SizedBox(height: 7,),
                        Text('Clothes' , style: GoogleFonts.montserrat(fontWeight: FontWeight.bold , fontSize: 10))
              
                      ]
                    ),
                  ),
                  
              
                ],
              ),
            )
              
            
            , SizedBox(height: 20,)  
            
            ,SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: appLightGrey
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(ImageDir.fitnessIcon),
                        SizedBox(height: 7,),
                        Text('Fitness' , style: GoogleFonts.montserrat(fontWeight: FontWeight.bold , fontSize: 10))
              
                      ]
                    )
                  )
                  
                  ,SizedBox(width: 16,),
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: appLightGrey
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(ImageDir.hairCutIcon),
                        SizedBox(height: 7,),
                        Text('Barber' , style: GoogleFonts.montserrat(fontWeight: FontWeight.bold , fontSize: 10))
              
                      ]
                    ),
                  ),
              
                   SizedBox(width: 16,),
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: appLightGrey
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(ImageDir.toolsIcon),
                        SizedBox(height: 7,),
                        Text('Tools' , style: GoogleFonts.montserrat(fontWeight: FontWeight.bold , fontSize: 10))
              
                      ]
                    ),
                  ),
                  SizedBox(width: 16,),
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: appLightGrey
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(ImageDir.menuIcon),
              
                      ]
                    ),
                  ),
                  
              
                ],
          
              ),
            ),
          
            SizedBox(height: 40,),
            Align(alignment: Alignment.centerLeft, child: Text('Rekomendasi dari kami' , style: GoogleFonts.montserrat(fontWeight: FontWeight.bold , fontSize: 16))),
            SizedBox(height: 7,)
           ,
            Row(
              children: [
                Container(
                  width: 140,
                  height: 165,
                  decoration: BoxDecoration(color: appLightGrey , borderRadius: BorderRadius.circular(20) , 
                   ),
                   child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(width: double.infinity, child: Image.asset(
                        ImageDir.solariaImage
                      )),
                      SizedBox(height: 7,),
                      Text("Solaria’s Cafe" , style: GoogleFonts.montserrat(fontWeight: FontWeight.bold , fontSize: 10)),
                      SizedBox(height: 3,),
                    ],
                   )
                ),
                
              ],
            )
              
                ],
              )
            )
            
          
            ],
          ),
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        fixedColor: Colors.black,
        unselectedItemColor: appDarkGrey,
        elevation: 10,
        
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home) , label: 'Home' ),
        BottomNavigationBarItem(icon: Icon(Icons.discount) , label: 'Promo'),
        BottomNavigationBarItem(icon: Icon(Icons.work_history) , label: 'Activities'),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark) , label: 'Wish List'),
      ]),
    );
  }
}