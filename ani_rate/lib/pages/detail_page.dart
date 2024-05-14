import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'One Piece',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 119, 29),
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
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
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: ExpandableText(
                  'An alternate version of Earth, and one that is currently in the midst of the "Golden Age of Pirates". Ruthless cut-throat pirates rule the seas, and only the strongest have the chance to lay claim to the mythical treasure known as "One Piece" that was left behind by the greatest pirate of them all Gold Roger. Years after the death of Gold Roger, a young boy by the name of Monkey D. Luffy has dreams of raising his own crew, finding One Piece, and declaring himself as Pirate King. After eating a devil fruit that grants Luffy the power to make his body like rubber, it gives him enormous strength and agility. When Luffy finally comes of age, he sets sail from Foosha Village in East Blue and sets upon his grand adventure to become the next Pirate King.',
                  expandText: 'Show more',
                  collapseText: ' Show less',
                  maxLines: 5,
                  linkEllipsis: true,
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 119, 29),
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
