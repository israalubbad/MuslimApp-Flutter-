import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kPrimaryColor = Color(0xff201E43);

class MisbahaScreen extends StatefulWidget {
  const MisbahaScreen({super.key});

  @override
  State<MisbahaScreen> createState() => _MisbahaScreenState();
}

class _MisbahaScreenState extends State<MisbahaScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;
  int count = 0;

  final List<String> tasbeehList = [
    'سبحان الله',
    'الحمد لله',
    'الله أكبر',
    'لا إله إلا الله',
    'أستغفر الله',
    'سبحان الله وبحمده',
  ];

  void incrementCounter() {
    setState(() {
      count++;
    });
  }

  void resetCounter() {
    setState(() {
      count = 0;
    });
  }

  void nextPage() {
    if (currentPage < tasbeehList.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _pageController.jumpToPage(0);
    }
    resetCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'المسبحة',
          style: GoogleFonts.almarai(
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: PageView.builder(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              currentPage = index;
              count = 0;
            });
          },
          itemCount: tasbeehList.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tasbeehList[index],
                  style: GoogleFonts.almarai(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  '$count',
                  style: GoogleFonts.almarai(
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: incrementCounter,
                  onLongPress: nextPage,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/msbaha.png'),
                        fit: BoxFit.cover,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12,
                          offset: const Offset(2, 4),
                        ),
                      ],
                    ),

                  ),
                ),
                const SizedBox(height: 25),
                TextButton.icon(
                  onPressed: resetCounter,
                  icon: const Icon(Icons.refresh, color: kPrimaryColor),
                  label: Text(
                    'إعادة التصفير',
                    style: GoogleFonts.almarai(
                      color: kPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

              ],
            )
            ;
          },
        ),
      ),
    );
  }
}
