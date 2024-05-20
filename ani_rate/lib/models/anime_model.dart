// lib/models/anime_model.dart
class Anime {
  final String title;
  final String englishTitle;
  final String bannerImageUrl;
  final String coverImageUrl;
  final int averageScore;
  final int popularity;
  final int meanScore;
  final int episodes;
  final int runtime;
  final String description;
  final String type;
  final List<String> tags;

  Anime({
    required this.title,
    required this.englishTitle,
    required this.bannerImageUrl,
    required this.coverImageUrl,
    required this.averageScore,
    required this.popularity,
    required this.meanScore,
    required this.episodes,
    required this.runtime,
    required this.description,
    required this.type,
    required this.tags,
  });

  // Add the fromJson method
  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      title: json['title']['romaji'] as String,
      englishTitle: json['title']['english'] as String,
      bannerImageUrl: json['bannerImage'] as String,
      coverImageUrl: json['coverImage']['large'] as String,
      averageScore: json['averageScore'] as int,
      popularity: json['popularity'] as int,
      meanScore: json['meanScore'] as int,
      episodes: json['episodes'] as int,
      runtime: json['duration'] as int,
      description: json['description'] as String,
      type: json['type'] as String,
      tags: (json['tags'] as List).map((tag) => tag['name'] as String).toList(),
    );
  }

  // Add the toJson method
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'englishTitle': englishTitle,
      'bannerImageUrl': bannerImageUrl,
      'coverImageUrl': coverImageUrl,
      'averageScore': averageScore,
      'popularity': popularity,
      'meanScore': meanScore,
      'episodes': episodes,
      'runtime': runtime,
      'description': description,
      'type': type,
      'tags': tags,
    };
  }
}
