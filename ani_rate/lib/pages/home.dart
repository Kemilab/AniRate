import 'package:ani_rate/pages/animePage.dart';
import 'package:ani_rate/pages/animePages/aot_page.dart';
import 'package:ani_rate/pages/animePages/demonslayer_page.dart';
import 'package:ani_rate/pages/animePages/dragonball_page.dart';
import 'package:ani_rate/pages/animePages/jk_page.dart';
import 'package:ani_rate/pages/animePages/mha_page.dart';
import 'package:ani_rate/pages/animePages/onepiece_page.dart';
import 'package:ani_rate/pages/animePages/spyxfamily_page.dart';
import 'package:ani_rate/pages/profile_page.dart';
import 'package:flutter/material.dart';

class MyHomeScreen extends StatefulWidget {
  MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  final TextEditingController searchController = TextEditingController();

  List<Anime> animeList = [];
  List<Anime> allAnimeList = [];
  List<Anime> displayedAnimeList = [];

  void filterAnimeByName(String query) {
  List<Anime> filteredList = allAnimeList.where((anime) =>
    anime.title.toLowerCase().contains(query.toLowerCase())).toList();
  setState(() {
    displayedAnimeList = filteredList;
  });
}
  void _getAnimeList() {
    animeList = [
      Anime(title: 'One Piece', imagePath: 'assets/onepiece_main_cover.png'),
      Anime(title: 'Attack on Titan', imagePath: 'assets/attackontitan_main_cover.png'),
      Anime(title: 'My hero academia', imagePath: 'assets/mha_main_cover.png'),
      Anime(title: 'Jujutsu Kaisen', imagePath: 'assets/jujutsukaisen_main_cover.png'),
      Anime(title: 'Dragon Ball', imagePath: 'assets/dragonball_main_cover.png'),
      Anime(title: 'Demon Slayer', imagePath: 'assets/demonslayer_main_cover.jpg'),
      Anime(title: 'Spy x Family', imagePath: 'assets/spyxfamily_main_cover.jpg'),
    ];
    allAnimeList.addAll(animeList); // Store all anime in a separate list
  }

  @override
  void initState() {
    super.initState();
    _getAnimeList();
    displayedAnimeList = animeList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(35, 35, 35, 1),
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              height: 200.0,
              child: Image.asset(
                'assets/title.png',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 225),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'All anime',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 119, 29),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
  height: 300, // Increase the height of the container
  child: GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, // Maximum 2 items per row
      crossAxisSpacing: 8.0, // Spacing between items
      mainAxisSpacing: 8.0, // Spacing between rows
    ),
    itemCount: displayedAnimeList.length,
    padding: EdgeInsets.all(.0),
    itemBuilder: (context, index) {
      Anime anime = displayedAnimeList[index];
      return GestureDetector(
        onTap: () {
          _navigateToAnimePage(context, anime);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              anime.imagePath,
              width: double.infinity,
              height: double.infinity, // Allow the image to take up the entire container height
              fit: BoxFit.cover, // Ensure images are scaled properly
            ),
          ),
        ),
      );
    },
  ),
),


                  ],
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'TAGS',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.72),
                      fontSize: 19.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                tags(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: TextField(
  controller: searchController,
  onChanged: (query) {
    // Call a method to filter anime based on the search query
    filterAnimeByName(query);
  },
  style: TextStyle(color: Color.fromARGB(255, 255, 119, 29),), // Change text color here
  decoration: InputDecoration(
    hintText: 'Search anime...',
    hintStyle: const TextStyle(color: Color.fromARGB(255, 255, 119, 29),),
    prefixIcon: const Icon(Icons.search),
    enabledBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(
        color: Color.fromARGB(255, 255, 119, 29),
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(
        color: Colors.blue,
      ),
    ),
  ),
),

      backgroundColor: Color.fromRGBO(35, 35, 35, 1),
      leading: Container(
        margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(35, 35, 35, 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              useSafeArea: true,
              enableDrag: true,
              context: context,
              builder: ((context) {
                return ProfilePage();
              }),
            );
          },
          child: Image.asset(
            'assets/logo.png',
            height: 50,
            width: 50,
          ),
        ),
      ),
    );
  }

  void _navigateToAnimePage(BuildContext context, Anime anime) {
    if (anime.title == 'Attack on Titan') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AOTPage(anime: null)),
      );
    } else if (anime.title == 'One Piece') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OnePiecePage(anime: null)),
      );
    }
    else if (anime.title == 'My hero academia') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MHAPage(anime: null)),
      );
    }
    else if (anime.title == 'Jujutsu Kaisen') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const JKPage(anime: null)),
      );
    }
    else if (anime.title == 'Dragon Ball') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DGPage(anime: null)),
      );
    }
    else if (anime.title == 'Demon Slayer') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DSPage(anime: null)),
      );
    }
    else if (anime.title == 'Spy x Family') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SXFPage(anime: null)),
      );
    }
  }
}

class Anime {
  final String title;
  final String imagePath;

  Anime({required this.title, required this.imagePath});
}

Widget tags(BuildContext context) {
  return Wrap(
    spacing: 10,
    children: [
      TagWidget(text: 'Action', color: Color.fromARGB(154, 252, 76, 6), onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  const AnimePage(tag: 'Action')),
        );
      }),
      TagWidget(text: 'Adventure', color: Color.fromARGB(154, 252, 76, 6), onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  const AnimePage(tag: 'Action')),
        );
      }),
      TagWidget(text: 'Shounen', color: Color.fromARGB(154, 252, 6, 6), onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AnimePage(tag: 'Shounen')),
        );
      }),
      TagWidget(text: 'Supernatural', color: Color.fromARGB(154, 252, 207, 6), onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AnimePage(tag: 'Supernatural')),
        );
      }),
      TagWidget(text: 'War', color: Color.fromARGB(154, 252, 76, 6), onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AnimePage(tag: 'War')),
        );
      }),
      TagWidget(text: 'Hero', color: Color.fromARGB(154, 252, 76, 6), onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AnimePage(tag: 'Hero')),
        );
      }),
      TagWidget(text: 'Comedy', color: Color.fromARGB(255, 135, 39, 1), onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AnimePage(tag: 'Comedy')),
        );
      }),
      TagWidget(text: 'Pirates', color: Color.fromARGB(255, 156, 46, 3), onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AnimePage(tag: 'Pirates')),
        );
      }),
      TagWidget(text: 'Magic', color: Color.fromARGB(255, 156, 46, 3), onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AnimePage(tag: 'Magic')),
        );
      }),
      TagWidget(text: 'Family', color: Color.fromARGB(255, 156, 46, 3), onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AnimePage(tag: 'Family')),
        );
      }),
      TagWidget(text: 'Spy', color: Color.fromARGB(255, 156, 46, 3), onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AnimePage(tag: 'Spy')),
        );
      }),
    ],
  );
}

class TagWidget extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;

  const TagWidget({
    Key? key,
    required this.text,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
