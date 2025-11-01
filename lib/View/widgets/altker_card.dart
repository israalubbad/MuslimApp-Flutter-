import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/atkar_list.dart';
import '../../utils/helper/constans.dart';

class AltkerCard extends StatelessWidget {
  final String label;
  final String? imagePath;
  final IconData? icon;
  final VoidCallback? onTap;

  const AltkerCard({
    super.key,
    required this.label,
    this.imagePath,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
              () {
            String randomText = AtkarList().getRandomText(label);

            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                title: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.almarai(fontWeight: FontWeight.bold),
                ),
                content: Text(
                  randomText,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.almarai(fontSize: 16, height: 1.6),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("إغلاق"),
                  ),
                ],
              ),
            );
          },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.shade200,
              blurRadius: 6,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath != null)
              Image.asset(imagePath!, height: 60)
            else if (icon != null)
              Icon(icon, size: 48, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.almarai(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
