import 'dart:convert';
import 'package:ani_rate/services/anime_service.dart';
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

  final AnimeService _animeService = AnimeService();

  AnimeProvider() {
    fetchAnime();
  }

  Future<void> fetchAnime() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;

    try {
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

        _hasMore = hasNextPage;
        _animeList.addAll(
          fetchedAnime.map((anime) => Anime.fromJson(anime)).toList(),
        );
        _page++;
      } else {
        throw Exception('Failed to fetch anime');
      }
    } catch (error) {
      print('Error fetching anime: $error');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> searchAnime(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      _animeList = await _animeService.searchAnime(query);
    } catch (error) {
      print('Error searching anime: $error');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchAnimeByTag(String tag) async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;

    try {
      const String url = 'https://graphql.anilist.co';

      const query = '''
      query (\$page: Int, \$perPage: Int, \$tag: String) {
        Page(page: \$page, perPage: \$perPage) {
          pageInfo {
            hasNextPage
          }
          media(type: ANIME, tag: \$tag, sort: POPULARITY_DESC) {
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

      final variables = {'page': _page, 'perPage': 10, 'tag': tag};

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'query': query, 'variables': variables}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> fetchedAnime = data['data']['Page']['media'];
        final hasNextPage = data['data']['Page']['pageInfo']['hasNextPage'];

        _hasMore = hasNextPage;

        // Clear _animeList if fetching the first page of anime by tag
        if (_page == 1) {
          _animeList.clear();
        }

        _animeList.addAll(
          fetchedAnime.map((anime) => Anime.fromJson(anime)).toList(),
        );
        if (hasNextPage) {
          _page++; // Increment page only if there are more pages to fetch
        }
      } else {
        throw Exception('Failed to fetch anime by tag');
      }
    } catch (error) {
      print('Error fetching anime by tag: $error');
    }

    _isLoading = false;
    notifyListeners();
  }
}
