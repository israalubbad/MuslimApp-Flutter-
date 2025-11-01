import 'package:flutter/material.dart';
import 'package:fquran_app/View/screen/home_screen.dart';
import 'package:fquran_app/View/screen/quran_screen.dart';
import 'package:fquran_app/View/screen/atkar_screen.dart';

import '../../Model/Surah.dart';
import '../../utils/location.dart';
import '../widgets/custom_floating_nav_bar.dart';

class MainAppView extends StatefulWidget {
  final UserLocation userLocation;
  final Map<String, dynamic> prayerData;
  final List<Surah> suars;

  static String id = '/mainAppView';

  const MainAppView({
    super.key,
    required this.userLocation,
    required this.prayerData,
    required this.suars,
  });

  @override
  State<MainAppView> createState() => _MainAppViewState();
}

class _MainAppViewState extends State<MainAppView> {
  int _currentIndex = 0;
  late List<Widget> screensList;

  @override
  void initState() {
    super.initState();
    screensList = [
      HomeScreen(
        userLocation: widget.userLocation,
        prayerData: widget.prayerData,
      ),
      SurahsList(suars: widget.suars),
      const AzkarCategoriesScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screensList[_currentIndex],
      extendBody: true,
      bottomNavigationBar: CustomFloatingNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
