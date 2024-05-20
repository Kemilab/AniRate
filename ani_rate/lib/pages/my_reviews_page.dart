// lib/pages/my_reviews_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyReviewsPage extends StatelessWidget {
  Future<List<Map<String, dynamic>>> _fetchReviews() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final reviewsSnapshot = await FirebaseFirestore.instance
          .collectionGroup('reviews')
          .where('user', isEqualTo: user.email)
          .get();

      return reviewsSnapshot.docs
          .map((doc) => {
                ...doc.data(),
                'id': doc.id,
                'anime': doc.reference.parent.parent?.id
              })
          .toList();
    }
    return [];
  }

  Future<void> _deleteReview(String animeId, String reviewId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('anime')
          .doc(animeId)
          .collection('reviews')
          .doc(reviewId)
          .delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 35, 35, 35),
        title: const Text('My Reviews',
            style: TextStyle(color: Color.fromARGB(255, 252, 131, 50))),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchReviews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text('No reviews found',
                    style: TextStyle(color: Colors.white)));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final review = snapshot.data![index];
              return Dismissible(
                key: Key(review['id']),
                direction: DismissDirection.endToStart,
                background: Container(color: Colors.red),
                onDismissed: (direction) {
                  _deleteReview(review['anime'], review['id']);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Review deleted')),
                  );
                },
                child: ListTile(
                  tileColor: Color.fromARGB(255, 35, 35, 35),
                  title: Text(
                    review['anime'] ?? 'Unknown Anime',
                    style: TextStyle(color: Color.fromARGB(255, 252, 131, 50)),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review['review'] ?? '',
                        style: TextStyle(color: Colors.white),
                      ),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < review['rating']
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
