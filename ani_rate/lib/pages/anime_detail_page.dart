import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import '../models/anime_model.dart';

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
              child: CachedNetworkImage(
                imageUrl: anime.bannerImageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Dark overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          // Main content with SafeArea
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: anime.bannerImageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                    SizedBox(height: 20),
                    Text(
                      anime.englishTitle.isNotEmpty
                          ? anime.englishTitle
                          : anime.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          onPressed: () {
                            // Add to list functionality
                          },
                          child: Text("Add to List",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 252, 150, 33))),
                        ),
                        Text(
                          "Episodes: ${anime.episodes}",
                          style: TextStyle(color: Colors.white),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          onPressed: () {
                            // Review functionality
                          },
                          child: Text("Review",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 252, 150, 33))),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ExpandableText(
                        anime.description,
                        expandText: 'Show more',
                        collapseText: 'Show less',
                        maxLines: 4,
                        linkColor: const Color.fromARGB(255, 253, 253, 253),
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
                          Text(
                            "Type",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            anime.type,
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Episodes",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            anime.episodes.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Runtime",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${anime.runtime} min",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Tags",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          ExpandableTags(tags: anime.tags),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExpandableTags extends StatefulWidget {
  final List<String> tags;

  const ExpandableTags({required this.tags});

  @override
  _ExpandableTagsState createState() => _ExpandableTagsState();
}

class _ExpandableTagsState extends State<ExpandableTags> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final displayedTags =
        isExpanded ? widget.tags : widget.tags.take(6).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 4.0,
          runSpacing: 2.0,
          children: displayedTags.map((tag) {
            return Chip(
              backgroundColor: const Color.fromARGB(255, 252, 131, 50),
              label: Text(
                tag,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              elevation: 0,
            );
          }).toList(),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(
            isExpanded ? 'Show less' : 'Show more',
            style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
      ],
    );
  }
}
