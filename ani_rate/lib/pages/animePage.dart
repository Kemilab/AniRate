// Import necessary packages and detail pages
import 'package:ani_rate/pages/animePages/onepiece_page.dart';
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
      // If the title is 'One Piece', navigate to the One Piece detail page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OnePiecePage(anime:anime)), // Pass the anime object to the detail page constructor
      );
    } else {
      // Add more conditions for other anime titles if needed
    }
  }
@override
Widget build(BuildContext context) {
  List<Anime> filteredAnime = filterAnimeByTag(tag);
  return Scaffold(
    appBar: AppBar(
      title: Text('$tag Anime', style: TextStyle(color: Color.fromARGB(255, 255, 119, 29)),),
      backgroundColor: Color.fromRGBO(35, 35, 35, 1),
      iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 119, 29)),
    ),
    body: Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(35, 35, 35, 1), // Background color
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Maximum 3 items per row
          crossAxisSpacing: 8.0, // Spacing between items
          mainAxisSpacing: 8.0, // Spacing between rows
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
                color: Color.fromARGB(255, 44, 44, 44), 
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
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
                      style: TextStyle(
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