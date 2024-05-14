import 'package:ani_rate/models/spotlight_model.dart';
import 'package:ani_rate/models/topRating_model.dart';
import 'package:ani_rate/pages/detail_page.dart';
import 'package:ani_rate/pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHomeScreen extends StatefulWidget {
  MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  final TextEditingController searchController = TextEditingController();

  List<TopRatingModel> topRatings = [];
  List<SpotlightModel> spotlights = [];

  void _getTopRatings() {
    topRatings = TopRatingModel.getTopRatings();
  }

  void _getSpotlights() {
    spotlights = SpotlightModel.getSpotlights();
  }

  @override
  void initState() {
    _getTopRatings();
    _getSpotlights();
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
            child: SvgPicture.asset(
              'assets/aot_spotlight.svg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 225,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Top ratings',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 119, 29),
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 250,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: topRatings.length,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(left: 20, right: 20),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailPage(), // Replace 'DetailPage()' with the desired page/widget
                              ),
                            );
                          },
                          child: Container(
                            width: 166,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.asset(
                                    topRatings[index].coverPath,
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
