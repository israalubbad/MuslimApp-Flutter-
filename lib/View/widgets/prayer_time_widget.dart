import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class PrayerTimeWidget extends StatelessWidget {
 final String name;
 final String time;
 final String imagePath;
  const PrayerTimeWidget({super.key,
  required this.name,
  required this.time,
  required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 4),
            color: Colors.black.withOpacity(0.5),
            child: Text(
              time,
              textAlign: TextAlign.center,
              style:  GoogleFonts.almarai(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ) ;
  }
}