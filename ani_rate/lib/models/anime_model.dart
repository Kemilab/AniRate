// lib/models/anime_model.dart
class Anime {
  final String title;
  final String englishTitle;
  final String coverImageUrl;
  final String bannerImageUrl;
  final int averageScore;
  final int popularity;
  final int meanScore;
  final int episodes;
  final String description;
  final String type;
  final int runtime;
  final List<String> tags;

  Anime({
    required this.title,
    required this.englishTitle,
    required this.coverImageUrl,
    required this.bannerImageUrl,
    required this.averageScore,
    required this.popularity,
    required this.meanScore,
    required this.episodes,
    required this.description,
    required this.type,
    required this.runtime,
    required this.tags,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      title: json['title']['romaji'],
      englishTitle: json['title']['english'] ?? '',
      coverImageUrl: json['coverImage']['large'],
      bannerImageUrl: json['bannerImage'] ?? '',
      averageScore: json['averageScore'] ?? 0,
      popularity: json['popularity'] ?? 0,
      meanScore: json['meanScore'] ?? 0,
      episodes: json['episodes'] ?? 0,
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      runtime: json['duration'] ?? 0,
      tags: (json['tags'] as List).map((tag) => tag['name'] as String).toList(),
    );
  }
}
