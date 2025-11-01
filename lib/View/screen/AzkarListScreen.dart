import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kPrimaryColor = Color(0xff201E43);

class AzkarListScreen extends StatefulWidget {
  final String title;
  final List<dynamic> azkarList;

  const AzkarListScreen({
    super.key,
    required this.title,
    required this.azkarList,
  });

  @override
  State<AzkarListScreen> createState() => _AzkarListScreenState();
}

class _AzkarListScreenState extends State<AzkarListScreen> {
  final Map<int, int> _counters = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.title,
          style: GoogleFonts.almarai(
            color: kPrimaryColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: kPrimaryColor),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: widget.azkarList.length,
        itemBuilder: (context, index) {
          final item = widget.azkarList[index];

          final maxCount = int.tryParse(item['count'].toString()) ?? 1;
          final currentCount = _counters[index] ?? maxCount;
          final bool isFinished = currentCount <= 0;

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 6,
                  offset: const Offset(2, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  const SizedBox(height: 8),
                  Text(
                    item['zekr'],
                    textAlign: TextAlign.right,
                    style: GoogleFonts.almarai(
                      color: Colors.black87,
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (item['reference'] != null && item['reference'] != "")
                    Text(
                      item['reference'],
                      textAlign: TextAlign.right,
                      style: GoogleFonts.almarai(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (currentCount > 0) {
                          _counters[index] = currentCount - 1;
                        }
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color:
                        isFinished ? Colors.grey.shade400 : kPrimaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          '$currentCount',
                          style: GoogleFonts.almarai(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
