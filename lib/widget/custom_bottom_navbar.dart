import 'package:flutter/material.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/screen/home_screen.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({super.key , required this.currentIndex});

  final int currentIndex;


  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  
  int selectedIndex = 0;
  onTapped(int index ) {
    setState(() {
      selectedIndex = widget.currentIndex;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return  BottomNavigationBar(
        showSelectedLabels: true,
        currentIndex: selectedIndex,
        showUnselectedLabels: true,
        fixedColor: Colors.black,
        unselectedItemColor: appDarkGrey,
        elevation: 10,
        
        items: [
        BottomNavigationBarItem(icon: IconButton( onPressed: () {
          onTapped(0);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
        }  ,icon: Icon(Icons.home , color: widget.currentIndex == 0 ? appPrimary : Colors.black)) , label: 'Home'  ),
        BottomNavigationBarItem( icon: IconButton( onPressed: () {
          onTapped(1);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));

        }  ,icon: Icon(Icons.menu)) , label: 'Aktivitas'),
        BottomNavigationBarItem(icon: IconButton( onPressed: () {
          onTapped(2);
        }  ,icon: Icon(Icons.favorite)) , label: 'Favorit'),
      ]);
  }
}