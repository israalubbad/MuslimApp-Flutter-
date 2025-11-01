import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class UserLocation {
  double latitude = 0;
  double longitude = 0;
  String city = '';
  String country = '';

  Future<void> getLocation() async {
    try {

      Position p = await getCurrentLocation();
      latitude = p.latitude;
      longitude = p.longitude;

      // get country & city
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];

      city = place.locality ?? '';
      country = place.country ?? '';

    } catch (e) {
      print('Error fetching location: $e');
    }
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission was denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permission is permanently denied. Cannot access location.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}