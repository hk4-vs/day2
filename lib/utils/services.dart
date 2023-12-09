import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



import '../data/music_data_class.dart';

class ApiService {
  Future<List<MusicData>> getAllFetchMusicData() async {
    const url = "https://storage.googleapis.com/uamp/catalog.json";
    Uri uri = Uri.parse(url);
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);
        final result = json['music'] as List<dynamic>;
        final musicList = result.map((e) {
          return MusicData.fromJson(e);
        }).toList();

        debugPrint(response.body.toString());
        
        return musicList;
      } else {
        return throw ("Data fetch failed");
      }
    } catch (e) {
      return throw ("Data fetch failed");
    }
  }
}
