import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/anime_model.dart';

class AnimeProvider with ChangeNotifier {
  List<Anime> _animeList = [];
  List<Anime> get animeList => _animeList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _page = 1;
  bool _hasMore = true;
  bool get hasMore => _hasMore;

  Future<void> fetchAnime() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    const String url = 'https://graphql.anilist.co';

    const query = '''
      query (\$page: Int, \$perPage: Int) {
        Page(page: \$page, perPage: \$perPage) {
          pageInfo {
            hasNextPage
          }
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
      final hasNextPage = data['data']['Page']['pageInfo']['hasNextPage'];
      
      if (!hasNextPage) {
        _hasMore = false;
      }

      final List<Anime> animeList =
          fetchedAnime.map((anime) => Anime.fromJson(anime)).toList();
      _animeList.addAll(animeList);

      _page++;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> searchAnime(String query) async {
    _isLoading = true;
    notifyListeners();

    const String url = 'https://graphql.anilist.co';

    const searchQuery = '''
      query (\$search: String, \$page: Int, \$perPage: Int) {
        Page(page: \$page, perPage: \$perPage) {
          pageInfo {
            hasNextPage
          }
          media(type: ANIME, search: \$search) {
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

    final variables = {'search': query, 'page': 1, 'perPage': 10};

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'query': searchQuery, 'variables': variables}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> searchedAnime = data['data']['Page']['media'];
      final hasNextPage = data['data']['Page']['pageInfo']['hasNextPage'];
      
      if (!hasNextPage) {
        _hasMore = false;
      }

      _animeList.clear(); // Clear previous anime list
      final List<Anime> animeList =
          searchedAnime.map((anime) => Anime.fromJson(anime)).toList();
      _animeList.addAll(animeList);
    }

    _isLoading = false;
    notifyListeners();
  }
}
