import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:fquran_app/Model/Surah.dart';
import 'package:fquran_app/services/Linked.dart';
import '../../utils/helper/constans.dart';
import 'SurahPage.dart';
import '../widgets/surah_tile.dart';
import '../widgets/tafsir_bottom_sheet.dart';

class SurahsList extends StatefulWidget {
  final List<Surah> suars;
  const SurahsList({super.key, required this.suars});

  @override
  State<SurahsList> createState() => _SurahsListState();
}

class _SurahsListState extends State<SurahsList> {
  final Linked lin = Linked();
  final TextEditingController _searchController = TextEditingController();
  List<Surah> filteredSurahs = [];
  List<dynamic> ayahResults = [];
  bool isSearchingAyah = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    filteredSurahs = widget.suars;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor:  Colors.white,
        appBar: AppBar(
          title: const Text(
            "فهرس القرآن",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                textAlign: TextAlign.right,
                onChanged: (query) {
                  if (isSearchingAyah) {
                    _searchAyat(query);
                  } else {
                    _filterSurahs(query);
                  }
                },
                decoration: InputDecoration(
                  hintText: isSearchingAyah
                      ? 'ابحث عن آية'
                      : 'ابحث عن سورة',
                  prefixIcon: const Icon(Icons.search, color: kPrimaryColor),
                  filled: true,
                  fillColor: kliColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: kliColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor:
                          !isSearchingAyah ? kPrimaryColor : null,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isSearchingAyah = false;
                            _searchController.clear();
                            filteredSurahs = widget.suars;
                          });
                        },
                        child: Text(
                          "السور",
                          style: TextStyle(
                              color: !isSearchingAyah
                                  ? Colors.white
                                  : kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor:
                          isSearchingAyah ? kPrimaryColor : null,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isSearchingAyah = true;
                            _searchController.clear();
                            ayahResults.clear();
                          });
                        },
                        child: Text(
                          "الآيات",
                          style: TextStyle(
                              color: isSearchingAyah
                                  ? Colors.white
                                  : kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // عرض النتائج
              Expanded(
                child: isSearchingAyah
                    ? _buildAyatResults(context)
                    : _buildSurahList(),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildSurahList() {
    return filteredSurahs.isEmpty
        ? const Center(
      child: Text(
        "لم يتم العثور على نتائج.",
        style: TextStyle(color: kPrimaryColor, fontSize: 16),
      ),
    )
        : ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: filteredSurahs.length,
      itemBuilder: (context, index) {
        final surah = filteredSurahs[index];
        final originalIndex = widget.suars.indexOf(surah);

        return SurahTile(
          index: originalIndex,
          surah: surah,
          onTap: prepareSurahPages,
        );
      },
    );
  }

  Widget _buildAyatResults(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (ayahResults.isEmpty) {
      return const Center(
          child: Text("ابدأ بالبحث لعرض نتائج الآيات.",
              style: TextStyle(color:kPrimaryColor)));
    }
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: ayahResults.length,
      itemBuilder: (context, index) {
        final ayah = ayahResults[index];
        final text = ayah["text"] ?? "";
        final surahName = ayah["verse_key"] ?? "غير معروف";
        final ayahId = ayah["verse_id"].toString();

        return Card(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 6),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            title: Text(
              text,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 16, color:kPrimaryColor),
            ),
            subtitle: Text(
              "سورة $surahName",
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 13),
            ),
            onTap: () async {
              final tafsir = await Linked().getTafsir(ayahId);
              showTafsirSheet(context, text, surahName, tafsir);
            },
          ),
        );
      },
    );
  }


  void prepareSurahPages(int surahnum) {
    lin.prepareAudioURL(surahnum).then((audio) {
      lin.prepareSurahPages(surahnum).then((pages) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                QuranAudio(surahPages: pages, audioUrllink: audio),
          ),
        );
      });
    });
  }

  // Search  the Surah
  void _filterSurahs(String query) {
    query = query.trim().toLowerCase();
    if (query.isEmpty) {
      setState(() => filteredSurahs = widget.suars);
    } else {
      setState(() {
        filteredSurahs = widget.suars.where((s) {
          final name = s.name.toLowerCase();
          return name.contains(query) || name.replaceAll("ال", "").contains(query);
        }).toList();
      });
    }
  }
  // Search  the Ayat
  Future<void> _searchAyat(String query) async {
    if (query.trim().isEmpty) return;
    setState(() {
      isLoading = true;
      ayahResults.clear();
    });

    try {
      final res = await http.get(Uri.parse('$baseSearchAPI$query'));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final List results = data["search"]["results"] ?? [];

        setState(() {
          ayahResults = results;
        });
      } else {
        debugPrint("Search API Error: ${res.statusCode}");
      }
    } catch (e) {
      debugPrint("Error in ayah search: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }




}
