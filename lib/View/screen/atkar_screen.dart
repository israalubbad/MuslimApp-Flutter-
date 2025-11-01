import 'package:flutter/material.dart';
import '../widgets/altker_card.dart';
import 'MisbahaScreen.dart';
import 'AzkarListScreen.dart';
import 'package:fquran_app/services/Linked.dart';

class AzkarCategoriesScreen extends StatefulWidget {
  const AzkarCategoriesScreen({super.key});

  @override
  State<AzkarCategoriesScreen> createState() => _AzkarCategoriesScreenState();
}

class _AzkarCategoriesScreenState extends State<AzkarCategoriesScreen> {
  Map<String, dynamic> azkarData = {};

  @override
  void initState() {
    super.initState();
    Linked().loadAzkarData().then((data) {
      setState(() {
        azkarData = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'أذكار المسلم',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff201E43),
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: azkarData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            AltkerCard(
              label: "المسبحة",
              imagePath: 'assets/images/xx.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const MisbahaScreen()),
                );
              },
            ),
            ...azkarData.keys.take(10).toList().asMap().entries.map((entry) {
              final index = entry.key;
              final category = entry.value;
              final imagePath =
                  'assets/images/zekr${(index % 10) + 1}.png';

              return AltkerCard(
                label: category,
                imagePath: imagePath,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AzkarListScreen(
                        title: category,
                        azkarList: azkarData[category],
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
