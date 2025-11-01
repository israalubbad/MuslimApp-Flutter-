import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../utils/helper/constans.dart';
void showTafsirSheet(BuildContext context, String ayah, String surahName, String tafsir) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12)),
            ),
            const SizedBox(height: 16),
            Text(
              surahName,
              style: const TextStyle(
                  color: kPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              ayah,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color:kPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Text(
              tafsir,
              textAlign: TextAlign.justify,
              style: const TextStyle(color: kPrimaryColor, fontSize: 15),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => Share.share('$ayah\n\n$tafsir\n\n$surahName'),
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.share, color: Colors.white),
              label: const Text("مشاركة الآية",
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    ),
  );
}
