import 'package:ani_rate/models/spotlight_model.dart';
import 'package:ani_rate/models/topRating_model.dart';
import 'package:ani_rate/pages/animePage.dart';
import 'package:ani_rate/pages/animePages/aot_page.dart';
import 'package:ani_rate/pages/animePages/jk_page.dart';
import 'package:ani_rate/pages/animePages/mha_page.dart';
import 'package:ani_rate/pages/animePages/onepiece_page.dart';
import 'package:ani_rate/pages/profile_page.dart';
import 'package:flutter/material.dart';

class MyHomeScreen extends StatefulWidget {
  MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  final TextEditingController searchController = TextEditingController();

  List<TopRatingModel> topRatings = [];
  List<SpotlightModel> spotlights = [];
  List<Anime> animeList = [];

  void _getAnimeList() {
    // Simulated function to fetch anime list from somewhere
    animeList = [
      Anime(title: 'One Piece', imagePath: 'assets/onepiece_main_cover.png'),
      Anime(title: 'Attack on Titan', imagePath: 'assets/attackontitan_main_cover.png'),
      Anime(title: 'My hero academia', imagePath: 'assets/mha_main_cover.png'),
      Anime(title: 'Jujutsu Kaisen', imagePath: 'assets/jujutsukaisen_main_cover.png'),
      // Add more anime entries as needed
    ];
  }

  void _getTopRatings() {
    topRatings = TopRatingModel.getTopRatings();
  }

  void _getSpotlights() {
    spotlights = SpotlightModel.getSpotlights();
  }

  @override
  void initState() {
    super.initState();
    _getTopRatings();
    _getSpotlights();
    _getAnimeList();
  }

  @override
  Widget build(BuildContext context) {
    _getTopRatings();
    _getSpotlights();
    return Scaffold(
      backgroundColor: Color.fromRGBO(35, 35, 35, 1),
      appBar: appBar(),
      body: Stack(
        children: [
          Positioned(
            top: 0.0, // Top position set to 0.0
            left: 0.0, // Left position set to 0.0
            right: 0.0, // Right position set to 0.0 (stretch to full width)
            height: 200.0, // Adjust height as needed
            child: Image.asset(
              'assets/onepiece_spotlight.png',
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
                      'Top ratings',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 119, 29),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: 250,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: animeList.length,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(left: 20, right: 20),
                      itemBuilder: (context, index) {
                        Anime anime = animeList[index];
                        return GestureDetector(
                          onTap: () {
                            // Navigate to the corresponding anime page
                            _navigateToAnimePage(context, anime);
                          },
                          child: Container(
                            width: 166,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    anime.imagePath,
                                    width: 200,
                                    height: 250,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              const Padding(padding: EdgeInsets.only(left:10.0),
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
    );
  }

  AppBar appBar() {
    return AppBar(
      title: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search anime...',
          hintStyle: const TextStyle(color: Color.fromARGB(255, 255, 119, 29)),
          prefixIcon: const Icon(Icons.search),
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), // Add rounded corners
            borderSide: const BorderSide(
              color: Color.fromARGB(
                  255, 255, 119, 29), // Adjust border color as desired
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), // Add rounded corners
            borderSide: const BorderSide(
              color: Colors.blue, // Adjust border color for focus state
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
            borderRadius: BorderRadius.circular(10)),
        child: GestureDetector(
          onTap: () {
            showModalBottomSheet(
                useSafeArea: true,
                enableDrag: true,
                context: context,
                builder: ((context) {
                  return ProfilePage();
                }));
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
}

void _navigateToAnimePage(BuildContext context, Anime anime) {
    // Navigate to the corresponding anime page based on anime title
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
    // Add more conditions for other anime titles if needed
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
          // Navigate to page displaying anime with 'Action' tag
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  AnimePage(tag: 'Action')),
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
      ],
    );
  }
class TagWidget extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap; // Add onTap callback

  const TagWidget({
    Key? key,
    required this.text,
    required this.color,
    required this.onTap, // Receive onTap callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // Wrap with GestureDetector for onTap functionality
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