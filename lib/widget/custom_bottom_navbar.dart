import 'package:flutter/material.dart';
import 'package:nul_app/constants/color.dart';
import 'package:get/get.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  int selectedIndex = 0;
  onTapped(int index) {
    setState(() {
      selectedIndex = widget.currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        showSelectedLabels: true,
        currentIndex: selectedIndex,
        showUnselectedLabels: true,
        fixedColor: Colors.black,
        unselectedItemColor: appDarkGrey,
        elevation: 10,
        items: [
          BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () {
                    onTapped(0);
                    Get.offNamed('/home');
                  },
                  icon: Icon(Icons.home,
                      color: widget.currentIndex == 0
                          ? appPrimary
                          : Colors.black)),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () {
                    onTapped(1);
                    Get.offNamed('/activity');
                  },
                  icon: Icon(Icons.menu,
                      color: widget.currentIndex == 1
                          ? appPrimary
                          : Colors.black)),
              label: 'Aktivitas'),
          BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () {
                    onTapped(2);
                  Get.offNamed('/favorite');
                  },
                  icon: const Icon(Icons.favorite),
                  color: widget.currentIndex == 2 ? appPrimary : Colors.black),
              label: 'Favorit'),
        ]);
  }
}
