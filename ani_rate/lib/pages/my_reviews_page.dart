import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:ui'; // Import for the BackdropFilter

class MyReviewsPage extends StatefulWidget {
  @override
  _MyReviewsPageState createState() => _MyReviewsPageState();
}

class _MyReviewsPageState extends State<MyReviewsPage> {
  List<DocumentSnapshot> _reviews = [];

  @override
  void initState() {
    super.initState();
    _fetchReviews();
  }

  Future<void> _fetchReviews() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collectionGroup('reviews')
          .where('userId', isEqualTo: user.uid)
          .orderBy('timestamp', descending: true)
          .get();
      setState(() {
        _reviews = snapshot.docs;
      });
    }
  }

  void _deleteReview(int index) async {
    final doc = _reviews[index].reference;
    await doc.delete();
    setState(() {
      _reviews.removeAt(index);
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Review deleted')));
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Reviews',
          style: TextStyle(color: Color.fromARGB(255, 252, 131, 50)),
        ),
        backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 252, 131, 50)),
      ),
      body: user != null
          ? Stack(
              children: [
                // Background image with blur effect
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/background.png'), // Replace with your image path
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      color: Colors.black.withOpacity(
                          0), // Transparent color to apply the blur
                    ),
                  ),
                ),
                // Foreground content
                _reviews.isEmpty
                    ? const Center(child: Text('No reviews found'))
                    : ListView.builder(
                        itemCount: _reviews.length,
                        itemBuilder: (context, index) {
                          final reviewData =
                              _reviews[index].data() as Map<String, dynamic>;
                          final review =
                              reviewData['review'] as String? ?? 'No review';
                          final rating =
                              reviewData['rating']?.toDouble() ?? 0.0;
                          final animeTitle =
                              reviewData['animeTitle'] as String? ?? 'No title';
                          final animeImage =
                              reviewData['animeImage'] as String? ?? '';

                          return Dismissible(
                            key: Key(_reviews[index].id),
                            onDismissed: (direction) {
                              _deleteReview(index);
                            },
                            background: Container(color: Colors.red),
                            child: Card(
                              color: const Color.fromRGBO(50, 50, 50, 1),
                              margin: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: animeImage.isNotEmpty
                                    ? CachedNetworkImage(
                                        imageUrl: animeImage,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      )
                                    : const Icon(Icons.image,
                                        color: Colors.white),
                                title: Text(
                                  animeTitle,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      review,
                                      style: const TextStyle(
                                          color: Colors.white70),
                                    ),
                                    Row(
                                      children: List.generate(5, (index) {
                                        return Icon(
                                          index < rating
                                              ? Icons.star
                                              : Icons.star_border,
                                          color: Colors.amber,
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ],
            )
          : const Center(child: Text('Please log in to see your reviews')),
    );
  }
}
