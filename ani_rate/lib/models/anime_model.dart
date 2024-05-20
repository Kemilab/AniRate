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

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      title: json['title']['romaji'] ?? '',
      englishTitle: json['title']['english'] ?? '',
      bannerImageUrl: json['bannerImage'] ?? '',
      coverImageUrl: json['coverImage']['large'] ?? '',
      averageScore:
          json['averageScore'] != null ? json['averageScore'] as int : 0,
      popularity: json['popularity'] != null ? json['popularity'] as int : 0,
      meanScore: json['meanScore'] != null ? json['meanScore'] as int : 0,
      episodes: json['episodes'] != null ? json['episodes'] as int : 0,
      runtime: json['duration'] != null ? json['duration'] as int : 0,
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      tags: (json['tags'] as List<dynamic>? ?? [])
          .map((tag) => tag['name'] as String)
          .toList(),
    );
  }

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
