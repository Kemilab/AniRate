class Anime {
  final String title;
  final String englishTitle;
  final String coverImageUrl;
  final String bannerImageUrl;
  final String description;
  final List<String> tags;
  final int episodes;
  final double averageScore;
  final int popularity;
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
      title: json['title']['romaji'] ?? '',
      englishTitle: json['title']['english'] ?? '',
      coverImageUrl: json['coverImage']['large'] ?? '',
      bannerImageUrl: json['bannerImage'] ?? '',
      description: json['description'] ?? '',
      tags: (json['tags'] as List<dynamic>?)
              ?.map((tag) => tag['name'] as String)
              .toList() ??
          [],
      episodes: json['episodes'] ?? 0,
      averageScore: (json['averageScore'] as num?)?.toDouble() ?? 0.0,
      popularity: (json['popularity'] as num?)?.toInt() ?? 0,
      meanScore: (json['meanScore'] as num?)?.toDouble() ?? 0.0,
      type: json['type'] ?? '',
      runtime: (json['duration'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': {'romaji': title, 'english': englishTitle},
      'coverImage': {'large': coverImageUrl},
      'bannerImage': bannerImageUrl,
      'description': description,
      'tags': tags.map((tag) => {'name': tag}).toList(),
      'episodes': episodes,
      'averageScore': averageScore,
      'popularity': popularity,
      'meanScore': meanScore,
      'type': type,
      'runtime': runtime,
    };
  }
}
