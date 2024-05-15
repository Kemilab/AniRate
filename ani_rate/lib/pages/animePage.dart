import 'package:ani_rate/pages/animePages/aot_page.dart';
import 'package:ani_rate/pages/animePages/demonslayer_page.dart';
import 'package:ani_rate/pages/animePages/dragonball_page.dart';
import 'package:ani_rate/pages/animePages/jk_page.dart';
import 'package:ani_rate/pages/animePages/mha_page.dart';
import 'package:ani_rate/pages/animePages/onepiece_page.dart';
import 'package:ani_rate/pages/animePages/spyxfamily_page.dart';
import 'package:flutter/material.dart';
import 'package:ani_rate/models/Anime.dart';

class AnimePage extends StatelessWidget {
  final String tag;

  const AnimePage({Key? key, required this.tag}) : super(key: key);

  // This method filters anime by tag
  List<Anime> filterAnimeByTag(String tag) {
    // Implement your logic here to filter anime by the specified tag
    // For now, let's assume you have a global list called 'animeList'
    return animeList.where((anime) => anime.tags.contains(tag)).toList();
  }

  // This method navigates to the detail page based on the anime title
  void navigateToDetailPage(BuildContext context, Anime anime) {
    // Check the title of the anime
    if (anime.title == 'One Piece') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OnePiecePage(anime:anime)),
      );
    } else if (anime.title == 'Attack on Titan')
       {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AOTPage(anime:anime)),
      );
    }
    else if (anime.title == 'My hero academia') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MHAPage(anime:anime)),
      );
    }
    else if (anime.title == 'Jujutsu Kaisen') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => JKPage(anime:anime)),
      );
    }
    else if (anime.title == 'Dragon Ball') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DGPage(anime:anime)),
      );
    }
    else if (anime.title == 'Demon Slayer') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DSPage(anime:anime)),
      );
    }
    else if (anime.title == 'Spy x Family') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SXFPage(anime:anime)),
      );
    }
    
  }
@override
Widget build(BuildContext context) {
  List<Anime> filteredAnime = filterAnimeByTag(tag);
  return Scaffold(
    appBar: AppBar(
      title: Text('$tag Anime', style: const TextStyle(color: Color.fromARGB(255, 255, 119, 29)),),
      backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
      iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 119, 29)),
    ),
    body: Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(35, 35, 35, 1), // Background color
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: filteredAnime.length,
        itemBuilder: (context, index) {
          Anime anime = filteredAnime[index];
          return GestureDetector(
            onTap: () {
              navigateToDetailPage(context, anime);
            },
            child: Container(
              height: 250, // Adjust the height as needed
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 44, 44, 44), 
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                      child: Image.asset(
                        anime.imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      anime.title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255)
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
}