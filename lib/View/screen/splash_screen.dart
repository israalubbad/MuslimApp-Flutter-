import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fquran_app/services/Linked.dart';
import 'package:fquran_app/services/prayer_service.dart';
import 'package:fquran_app/utils/location.dart';
import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';

import 'main_app_view.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late UserLocation userLocation;
  Map<String, dynamic>? prayerData;

  @override
  void initState() {
    super.initState();
    _initAppData();
  }

  Future<void> _initAppData() async {
    try {

      userLocation = UserLocation();
      await userLocation.getLocation();
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

      }

      final service = PrayerInfoService(
        coordinates: Coordinates(userLocation.latitude, userLocation.longitude),
      );
      prayerData = service.getPrayerData();

      Linked().getSurahList().then((allSurah) {

      Future.delayed(const Duration(seconds: 5), () {
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainAppView(
              suars: allSurah,
              userLocation: userLocation,
              prayerData: prayerData ?? {
              },

            ),
          ),
        );
      });

      });
    } catch (e) {
      debugPrint("Error initializing app data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: const Center(
          child: Image(image: AssetImage('assets/images/logo.png')),
        ),
      ),
    );
  }
}
