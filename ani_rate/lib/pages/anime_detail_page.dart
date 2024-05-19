// lib/pages/anime_detail_page.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import '../models/anime_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AnimeDetailPage extends StatelessWidget {
  final Anime anime;

  const AnimeDetailPage({required this.anime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Blurred background image
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Image.network(
                anime.bannerImageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          //Dark overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          // Main content with SafeArea
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      Image.network(
                        anime.bannerImageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      ),
                      Positioned(
                        top: 100, // 50% of the banner height
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(anime.coverImageUrl),
                            ),
                            border: Border.all(
                              color: Colors.white,
                              width: 4.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 60),
                  Text(
                    anime.englishTitle.isNotEmpty
                        ? anime.englishTitle
                        : anime.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Avg Score: ${anime.averageScore}",
                          style: TextStyle(color: Colors.orangeAccent),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Popularity: ${anime.popularity}",
                          style: TextStyle(color: Colors.orangeAccent),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Mean Score: ${anime.meanScore}",
                          style: TextStyle(color: Colors.orangeAccent),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 229, 243, 255),
                          ),
                          onPressed: () {
                            // Add to list functionality
                          },
                          child: Text("Add to List"),
                        ),
                        Text(
                          "Episodes: ${anime.episodes}",
                          style: TextStyle(color: Colors.white),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 229, 243, 255),
                          ),
                          onPressed: () {
                            // Review functionality
                          },
                          child: Text("Review"),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ExpandableText(
                      anime.description,
                      expandText: 'show more',
                      collapseText: 'show less',
                      maxLines: 4,
                      linkColor: Colors.blue,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Divider(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Series Info",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        buildSeriesInfoRow("Type", anime.type),
                        buildSeriesInfoRow(
                            "Episodes", anime.episodes.toString()),
                        buildSeriesInfoRow("Runtime", "${anime.runtime} min"),
                        SizedBox(height: 10),
                        Text(
                          "Tags",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                          spacing: 4.0,
                          runSpacing: 4.0,
                          children: anime.tags.map((tag) {
                            return Chip(
                              backgroundColor: Colors.blueGrey.withOpacity(0.2),
                              label: Text(
                                tag,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSeriesInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
