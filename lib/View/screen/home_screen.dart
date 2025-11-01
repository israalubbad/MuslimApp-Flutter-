import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/helper/constans.dart';
import '../../utils/location.dart';
import '../widgets/altker_card.dart';
import '../widgets/prayer_time_widget.dart';

class HomeScreen extends StatefulWidget {
  final UserLocation userLocation;
  final Map<String, dynamic> prayerData;

  const HomeScreen({
    super.key,
    required this.userLocation,
    required this.prayerData,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Map<String, dynamic> data;

  @override
  void initState() {
    super.initState();
    data = widget.prayerData;
  }

  @override
  Widget build(BuildContext context) {
    final userLocation = widget.userLocation;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "${userLocation.country} - ${userLocation.city}",
              style: GoogleFonts.almarai(color: Colors.black, fontSize: 14),
            ),
            const SizedBox(width: 2),
            const Icon(Icons.location_on),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildNextPrayerCard(),

            const SizedBox(height: 16),

            _buildAllPrayerTimes(),

            const SizedBox(height: 20),

            _buildFeatureGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildNextPrayerCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage('assets/images/image.png'),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Text(
              '${data['date_gregorian']} | ${data['date_hijri']}',
              style:  GoogleFonts.almarai(color: Colors.white, fontSize: 14),
            ),
          ),
          const SizedBox(height: 12),
           Text(
            'الصلاة التالية',
            style:  GoogleFonts.almarai(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 4),
          Text(
            '${data!['prayer_next_time']}',
            style:  GoogleFonts.almarai(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${data!['prayer_next_name']}',
            style:  GoogleFonts.almarai(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'المتبقي: ${data['time_remaining']}',
            style: GoogleFonts.almarai(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'الصلاة الحالية: ${data['prayer_current_name']}',
              style:  GoogleFonts.almarai(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllPrayerTimes() {
    final times = data['times'];
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           Text('أوقات الصلاة', style:  GoogleFonts.almarai(color: Colors.white, fontSize: 18) , textAlign: TextAlign.end,),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrayerTimeWidget(name: "العشاء",time: times["isha"], imagePath: 'assets/images/im5.png'),
              PrayerTimeWidget(name: "المغرب",time: times["maghrib"], imagePath: 'assets/images/im1.png'),
              PrayerTimeWidget(name: "العصر",time:  times["asr"], imagePath: 'assets/images/im2.png'),
              PrayerTimeWidget(name: "الظهر", time: times["dhuhr"], imagePath: 'assets/images/dhuhr.png'),
              PrayerTimeWidget(name: "الفجر",time: times["fajr"], imagePath: 'assets/images/im4.png'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureGrid() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        AltkerCard(label:  "حديث اليوم", imagePath:  'assets/images/image1.png'),
        AltkerCard(label:  "آية اليوم",imagePath:'assets/images/image2.png'),
        AltkerCard(label: "اسم الله", imagePath: 'assets/images/image3.png'),
        AltkerCard(label: "دعاء اليوم", imagePath: 'assets/images/image4.png'),
      ],
    );
  }


}
