import 'package:flutter/material.dart';

import '../../utils/helper/constans.dart';

class SurahTile extends StatelessWidget {
  final int index;
  final dynamic surah;
  final Function(int) onTap;

  const SurahTile({
    super.key,
    required this.index,
    required this.surah,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => onTap(index + 1),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: primaryColor1,
                child: Text(
                  "${index + 1}",
                  style: const TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      surah.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: kPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "عدد الآيات:${surah.noOfAyah}",
                      style: const TextStyle(
                        color: kSeconderColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Image(image: surah.imgSurah(), height: 28, width: 28),
                  const SizedBox(height: 4),
                  Text(
                    surah.isMadnia ? "مدنية" : "مكية",
                    style: const TextStyle(fontSize: 12, color: kPrimaryColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
