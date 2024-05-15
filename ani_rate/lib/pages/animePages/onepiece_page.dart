import 'package:ani_rate/models/Anime.dart';
import 'package:ani_rate/pages/animePage.dart';
import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';

class OnePiecePage extends StatefulWidget {
  final Anime? anime;

  const OnePiecePage({Key? key, this.anime}) : super(key: key);

  @override
  State<OnePiecePage> createState() => _OnePiecePageState();
}


class _OnePiecePageState extends State<OnePiecePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(35, 35, 35, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/onepiece_spotlight.png',
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20.0),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'One Piece',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 119, 29),
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
             const Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                child: Text(
                  'Eichiro Oda',
                  style: TextStyle(
                    color: Color.fromARGB(197, 255, 119, 29),
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              categoriesUnderTitle(),
              const SizedBox(height:10.0),
              const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                'Summary',
                style: TextStyle(
                  color: Color.fromARGB(197, 255, 119, 29),
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),),
              const SizedBox(height:5.0),
              summary(),
              divider(),
              const Padding(padding: EdgeInsets.only(left:10.0),
              child: Text(
                'SERIES INFO',
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.72),
                  fontSize: 19.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ),
              seriesInfo(),
              SizedBox(height: 30,),
              tags(context),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

 Widget tags(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: [
        TagWidget(text: 'Action', color: Colors.blue, onTap: () {
          // Navigate to page displaying anime with 'Action' tag
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  AnimePage(tag: 'Action')),
          );
        }),
        TagWidget(text: 'Adventure', color: Colors.green, onTap: () {
          // Navigate to page displaying anime with 'Adventure' tag
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AnimePage(tag: 'Adventure')),
          );
        }),
        TagWidget(text: 'Shounen', color: Colors.orange, onTap: () {
          // Navigate to page displaying anime with 'Shounen' tag
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AnimePage(tag: 'Shounen')),
          );
        }),
        TagWidget(text: 'Comedy', color: const Color.fromARGB(255, 0, 255, 225), onTap: () {
          // Navigate to page displaying anime with 'Shounen' tag
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AnimePage(tag: 'Comedy')),
          );
        }),
        TagWidget(text: 'Pirates', color: Color.fromARGB(255, 255, 0, 0), onTap: () {
          // Navigate to page displaying anime with 'Shounen' tag
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AnimePage(tag: 'Pirates')),
          );
        }),
        // Add more tags as needed
      ],
    );
  }
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


  Column seriesInfo() {
    return Column(
              children: [
                Wrap(
                spacing: 30.0, 
                children: [
                  Column(
                    children: [
                  Container(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: const Text(
                      'TYPE',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.72),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 70.0),
                    child: const Text(
                      'TV',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  ],
                  ),
                  Column(
                    children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: const Text(
                      'RUNTIME',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.72),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: const Text(
                      '24 minutes per episode',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  ],
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Wrap(
                spacing: 100.0, 
                children: [
                  Column(
                    children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: const Text(
                      'AIRING',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.72),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: const Text(
                      '20.10.1999. - ?',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  ],
                  ),
                  Column(
                    children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: const Text(
                      'NATIVE NAME',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.72),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: const Text(
                      'ONE PIECE',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  ],
                  ),
                ],
              ),
              ],
            );
  }

  Padding divider() {
    return const Padding(
                      padding: EdgeInsets.only(left:20.0,top:20.0,right:20.0, bottom:10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 2.5,
                              color: Color.fromARGB(255, 161, 22, 22),
                            ),
                          ),
                        ],
                      ),
                    );
  }

  Padding summary() {
    return const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: ExpandableText(
                'An alternate version of Earth, and one that is currently in the midst of the "Golden Age of Pirates". Ruthless cut-throat pirates rule the seas, and only the strongest have the chance to lay claim to the mythical treasure known as "One Piece" that was left behind by the greatest pirate of them all Gold Roger. Years after the death of Gold Roger, a young boy by the name of Monkey D. Luffy has dreams of raising his own crew, finding One Piece, and declaring himself as Pirate King. After eating a devil fruit that grants Luffy the power to make his body like rubber, it gives him enormous strength and agility. When Luffy finally comes of age, he sets sail from Foosha Village in East Blue and sets upon his grand adventure to become the next Pirate King.',
                expandText: 'Show more',
                collapseText: ' Show less',
                maxLines: 4,
                linkEllipsis: true,
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.justify,
              ),
            );
  }



  Column categoriesUnderTitle() {
    return Column(
crossAxisAlignment: CrossAxisAlignment.start, 
children: [
Wrap(
  spacing: 1.0, 
  children: [
    Column(
      children: [
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        'STUDIO',
        style: TextStyle(
          color: Color.fromARGB(255, 252, 75, 6),
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        'TOEI ANIMATION',
        style: TextStyle(
          fontSize: 15.0,
          color: Color.fromARGB(255, 252, 75, 6),
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    ],
    ),
    Column(children: [
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        'AVERAGE SCORE',
        style: TextStyle(
          color: Color.fromARGB(255, 252, 75, 6),
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        '★★★★☆',
        style: TextStyle(
          fontSize: 15.0,
          color: Color.fromARGB(255, 252, 75, 6),
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    ],
    ),
    Column(children: [
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        'EPISODES',
        style: TextStyle(
          color: Color.fromARGB(255, 252, 75, 6),
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        '1105 (Airing)',
        style: TextStyle(
          fontSize: 15.0,
          color: Color.fromARGB(255, 252, 75, 6),
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    ],
    ),
  ],
),
],
);
}
