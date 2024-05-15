class Anime {
  final String title;
  final List<String> tags;
  final String imagePath;

  Anime({
    required this.title,
    required this.tags,
    required this.imagePath,
  });
}
List<Anime> animeList = [
  Anime(title: 'Dragon Ball', tags: ['Action', 'Adventure', 'Shounen', 'Supernatural', 'Comedy'], imagePath: 'assets/dragonball_main_cover.png'),
  Anime(title: 'One Piece', tags: ['Action', 'Adventure', 'Shounen', 'Comedy', 'Pirates', 'Supernatural'], imagePath: 'assets/onepiece_main_cover.png'),
  Anime(title: 'Attack on Titan', tags: ['Action', 'Fantasy', 'Shounen', 'Supernatural', 'War'], imagePath: 'assets/attackontitan_main_cover.png'),
  Anime(title: 'My hero academia', tags: ['Action', 'Hero', 'Shounen', 'Supernatural', 'Comedy'], imagePath: 'assets/mha_main_cover.png'),
  Anime(title: 'Jujutsu Kaisen', tags: ['Action', 'Fantasy', 'Shounen', 'Magic', 'Supernatural'], imagePath: 'assets/jujutsukaisen_main_cover.png'),
  // Add more anime objects with tags as needed
];
