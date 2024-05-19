import 'package:hive/hive.dart';

part 'anime_model.g.dart';

@HiveType(typeId: 0)
class Anime {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String englishTitle;

  @HiveField(2)
  final String coverImageUrl;

  @HiveField(3)
  final String bannerImageUrl;

  @HiveField(4)
  final int averageScore;

  @HiveField(5)
  final int popularity;

  @HiveField(6)
  final int meanScore;

  @HiveField(7)
  final int episodes;

  @HiveField(8)
  final String description;

  @HiveField(9)
  final String type;

  @HiveField(10)
  final int runtime;

  @HiveField(11)
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

  Map<String, dynamic> toJson() {
    return {
      'title': {'romaji': title, 'english': englishTitle},
      'coverImage': {'large': coverImageUrl},
      'bannerImage': bannerImageUrl,
      'averageScore': averageScore,
      'popularity': popularity,
      'meanScore': meanScore,
      'episodes': episodes,
      'description': description,
      'type': type,
      'duration': runtime,
      'tags': tags.map((tag) => {'name': tag}).toList(),
    };
  }
}
