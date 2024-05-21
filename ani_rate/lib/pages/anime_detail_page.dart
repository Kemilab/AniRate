import 'dart:ui';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/anime_model.dart';
import 'my_reviews_page.dart';

class AnimeDetailPage extends StatelessWidget {
  final Anime anime;

  const AnimeDetailPage({required this.anime});

  Future<void> _addToFavorites(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final favoriteRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .doc(anime.title);
      await favoriteRef.set(anime.toJson());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added to favorites!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please log in first')),
      );
    }
  }

  Future<void> _submitReview(
      BuildContext context, String review, double rating) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final reviewsRef = FirebaseFirestore.instance
          .collection('anime')
          .doc(anime.title)
          .collection('reviews')
          .doc(user.uid);
      await reviewsRef.set({
        'review': review,
        'rating': rating,
        'user': user.email,
        'userId': user.uid,
        'animeTitle': anime.englishTitle,
        'animeImage': anime.bannerImageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Review submitted!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please log in first')),
      );
    }
  }

  void _showReviewDialog(BuildContext context) {
    final TextEditingController reviewController = TextEditingController();
    double rating = 3.0;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: const Text(
          'Submit Review',
          style: TextStyle(color: Color.fromARGB(255, 252, 131, 50)),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding:
                    EdgeInsets.symmetric(horizontal: 2.0), // Adjusted padding
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (newRating) {
                  rating = newRating;
                },
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: reviewController,
                style:
                    const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                decoration: const InputDecoration(
                  hintText: 'Write your review here...',
                  hintStyle:
                      TextStyle(color: Color.fromARGB(160, 252, 131, 50)),
                ),
                maxLines: 5,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color.fromARGB(255, 252, 131, 50)),
            ),
          ),
          TextButton(
            onPressed: () {
              _submitReview(context, reviewController.text, rating);
            },
            child: const Text(
              'Submit',
              style: TextStyle(color: Color.fromARGB(255, 252, 131, 50)),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _checkIfReviewed() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final reviewDoc = await FirebaseFirestore.instance
          .collection('anime')
          .doc(anime.title)
          .collection('reviews')
          .doc(user.uid)
          .get();
      return reviewDoc.exists;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    List<String> initialTags =
        anime.tags.length > 5 ? anime.tags.sublist(0, 5) : anime.tags;
    List<String> hiddenTags =
        anime.tags.length > 5 ? anime.tags.sublist(5) : [];

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          onPressed: () => _addToFavorites(context),
                          child: Text("Add to List",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 252, 150, 33))),
                        ),
                        Text(
                          "Episodes: ${anime.episodes}",
                          style: TextStyle(color: Colors.white),
                        ),
                        FutureBuilder<bool>(
                          future: _checkIfReviewed(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }
                            if (snapshot.data == true) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 0, 0, 0),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyReviewsPage(),
                                    ),
                                  );
                                },
                                child: Text("My Review",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 252, 150, 33))),
                              );
                            }
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 0, 0, 0),
                              ),
                              onPressed: () => _showReviewDialog(context),
                              child: Text("Review",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 252, 150, 33))),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ExpandableText(
                      anime.description,
                      expandText: 'Show more',
                      collapseText: 'Show less',
                      maxLines: 4,
                      linkColor: Color.fromARGB(255, 255, 255, 255),
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
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          anime.type,
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Episodes",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          anime.episodes.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Runtime",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${anime.runtime} min",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Tags",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Wrap(
                          spacing: 4.0,
                          runSpacing: 2.0,
                          children: initialTags.map((tag) {
                            return Chip(
                              backgroundColor:
                                  const Color.fromARGB(255, 252, 131, 50),
                              label: Text(
                                tag,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              elevation: 0,
                            );
                          }).toList(),
                        ),
                        if (hiddenTags.isNotEmpty)
                          ExpandableNotifier(
                            child: Column(
                              children: [
                                Expandable(
                                  collapsed: Container(),
                                  expanded: Wrap(
                                    spacing: 4.0,
                                    runSpacing: 2.0,
                                    children: hiddenTags.map((tag) {
                                      return Chip(
                                        backgroundColor: const Color.fromARGB(
                                            255, 252, 131, 50),
                                        label: Text(
                                          tag,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 4.0),
                                        elevation: 0,
                                      );
                                    }).toList(),
                                  ),
                                ),
                                ExpandableButton(
                                  child: Text(
                                    hiddenTags.isNotEmpty
                                        ? 'Show more'
                                        : 'Show less',
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255)),
                                  ),
                                ),
                              ],
                            ),
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
}
