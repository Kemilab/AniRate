class Anime {
  final String title;
  final String englishTitle;
  final String coverImageUrl;
  final String bannerImageUrl;
  final String description;
  final List<String> tags;
  final int episodes;
  final double averageScore;
  final double popularity;
  final double meanScore;
  final String type;
  final int runtime;

  Anime({
    required this.title,
    required this.englishTitle,
    required this.coverImageUrl,
    required this.bannerImageUrl,
    required this.description,
    required this.tags,
    required this.episodes,
    required this.averageScore,
    required this.popularity,
    required this.meanScore,
    required this.type,
    required this.runtime,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      title: json['title'],
      englishTitle: json['englishTitle'] ?? '',
      coverImageUrl: json['coverImageUrl'],
      bannerImageUrl: json['bannerImageUrl'],
      description: json['description'],
      tags: List<String>.from(json['tags']),
      episodes: json['episodes'],
      averageScore: (json['averageScore'] as num).toDouble(),
      popularity: (json['popularity'] as num).toDouble(),
      meanScore: (json['meanScore'] as num).toDouble(),
      type: json['type'],
      runtime: json['runtime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'englishTitle': englishTitle,
      'coverImageUrl': coverImageUrl,
      'bannerImageUrl': bannerImageUrl,
      'description': description,
      'tags': tags,
      'episodes': episodes,
      'averageScore': averageScore,
      'popularity': popularity,
      'meanScore': meanScore,
      'type': type,
      'runtime': runtime,
    };
  }
}
