import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fquran_app/services/Network.dart';
import 'package:http/http.dart' as http;

import '../Model/Surah.dart';
import '../Model/Surah_search_model.dart';

class Linked {
  Network network = Network();
  Future<String> prepareAudioURL(int surahnum) async {
    String audiourl = await network.audioUrlLink(surahnum);
    return audiourl;
  }

  Future<Map<String, dynamic>> loadAzkarData() async {
    final String response = await rootBundle.loadString('assets/json/azkar.json');
    final data = json.decode(response);
    return data;
  }


  Future<List<Surah>> getSurahList() async {
    List<Surah> allSurahs = [];
    Map<String, dynamic> data = await network.fetchData();
    for (int i = 0; i < 114; ++i) {
      allSurahs.add(
        Surah(
          name: data['data']['surahs']['references'][i]['name'],
          noOfAyah: data['data']['surahs']['references'][i]['numberOfAyahs'],
          isMadnia:
              data['data']['surahs']['references'][i]['revelationType'] ==
              'Medinan',
        ),
      );
    }
    return allSurahs;
  }

  Future<List<NetworkImage>> prepareSurahPages(int surahnum) async {
    List<NetworkImage> surahPages = [];
    Map<String, dynamic> data = await network.fectchDatapages(surahnum);
    int from = data["chapter"]["pages"][0];
    int to = data["chapter"]["pages"][1];

    for (int i = from; i <= to; i++) {
      String imageUrl = network.SurahImage(i);
      surahPages.add(NetworkImage(imageUrl));
    }

    return surahPages;
  }

  Future<List<SearchModel>> getResults(String value) async {
    List<SearchModel> searchResult = [];
    Map<String, dynamic> data = await network.ayahSerarchResult(value);
    for (int i = 1; i <= data['search']['ayas'].length; ++i) {
      int page_num = data['search']['ayas']['$i']['position']['page'];
      int juz = data['search']['ayas']['$i']['position']['juz'];
      String aya_text =
          data['search']['ayas']['$i']['aya']['text_no_highlight'];
      String surah = data['search']['ayas']['$i']['sura']['arabic_name'];
      int aya_num = data['search']['ayas']['$i']['aya']['id'];
      searchResult.add(
        SearchModel(
          aya_num: aya_num,
          aya_text: aya_text,
          juz: juz,
          page_num: page_num,
          surah: surah,
        ),
      );
    }
    searchResult.sort((a, b) => a.juz.compareTo(b.juz));
    return searchResult;
  }

  Future<String> getTafsir(String ayahId) async {
    try {
      final url = Uri.parse("https://api.quran.com/api/v4/verses/$ayahId/tafsirs");
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data["tafsirs"].isNotEmpty) {
          return data["tafsirs"][0]["text"] ?? "لا يوجد تفسير متاح.";
        }
      }
      return "لا يوجد تفسير متاح.";
    } catch (e) {
      return "حدث خطأ أثناء جلب التفسير.";
    }
  }



}
