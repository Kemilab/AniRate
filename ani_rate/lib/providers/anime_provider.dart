// lib/providers/anime_provider.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import '../models/anime_model.dart';

class AnimeProvider with ChangeNotifier {
  List<Anime> _animeList = [];
  List<Anime> get animeList => _animeList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _page = 1;

  Future<void> fetchAnime() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    const String url = 'https://graphql.anilist.co';

    const query = '''
      query (\$page: Int, \$perPage: Int) {
        Page(page: \$page, perPage: \$perPage) {
          media(type: ANIME, sort: POPULARITY_DESC) {
            title {
              romaji
              english
            }
            coverImage {
              large
            }
            bannerImage
            averageScore
            popularity
            meanScore
            episodes
            description
            type
            duration
            tags {
              name
            }
          }
        }
      }
    ''';

    final variables = {'page': _page, 'perPage': 10};

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'query': query, 'variables': variables}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> fetchedAnime = data['data']['Page']['media'];
      final List<Anime> animeList =
          fetchedAnime.map((anime) => Anime.fromJson(anime)).toList();
      _animeList.addAll(animeList);

      // Cache data locally
      var box = await Hive.openBox('animeBox');
      box.put('animeList', _animeList);

      _page++;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadCachedAnime() async {
    var box = await Hive.openBox('animeBox');
    _animeList = (box.get('animeList', defaultValue: []) as List)
        .map((anime) => Anime.fromJson(anime))
        .toList();
    notifyListeners();
  }
}
