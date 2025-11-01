import 'dart:convert';

import 'package:http/http.dart' as http;

import 'helper/constans.dart';

class NetworkHelper{
  void getData(){
    Future<Map<String, dynamic>> fetchData() async {
      var response = await http.get(Uri.parse(baseMetaDataAPI));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return Future.error('erorr');
    }

    Future<Map<String, dynamic>> fectchDatapages(int surahNumber) async {
      //from page number.. to page number ..
      var response = await http.get(Uri.parse('$baseFromToDataAPI$surahNumber'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return Future.error('erorr');
    }

  }
}