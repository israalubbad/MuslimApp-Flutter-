import 'package:flutter/material.dart';

import '../../utils/helper/constans.dart';

class CustomFloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const CustomFloatingNavBar(
      {super.key, required this.currentIndex, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 24.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          backgroundColor:Colors.grey.shade200,
          selectedItemColor: kPrimaryColor,
          selectedIconTheme: const IconThemeData(size: 28),
          unselectedItemColor:  Colors.grey.shade600,
          currentIndex: currentIndex,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.mosque), label: 'Quran'),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded), label: 'Azkar')
          ],
        ),
      ),
    );
  }
}
