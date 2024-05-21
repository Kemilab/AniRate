import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/anime_model.dart';

class AnimeService {
  static const String url = 'https://graphql.anilist.co';

  Future<List<Anime>> fetchAnime(int page) async {
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
          }
        }
      }
    ''';

    final variables = {'page': page, 'perPage': 10};

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'query': query, 'variables': variables}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> fetchedAnime = data['data']['Page']['media'];
      return fetchedAnime.map((anime) => Anime.fromJson(anime)).toList();
    } else {
      throw Exception('Failed to fetch anime');
    }
  }

  Future<List<Anime>> searchAnime(String query) async {
    const searchQuery = '''
      query (\$search: String) {
        Page(page: 1, perPage: 10) {
          media(search: \$search, type: ANIME) {
            title {
              romaji
              english
            }
            coverImage {
              large
            }
          }
        }
      }
    ''';

    final variables = {'search': query};

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'query': searchQuery, 'variables': variables}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> fetchedAnime = data['data']['Page']['media'];
      return fetchedAnime.map((anime) => Anime.fromJson(anime)).toList();
    } else {
      throw Exception('Failed to search anime');
    }
  }
}
