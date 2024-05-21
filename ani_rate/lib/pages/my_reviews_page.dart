import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyReviewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Reviews'),
        backgroundColor: Color.fromRGBO(35, 35, 35, 1),
      ),
      body: user != null
          ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collectionGroup('reviews')
                  .where('userId', isEqualTo: user.uid)
                  .orderBy('timestamp', descending: true) // Order by timestamp
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No reviews found'));
                }

                final reviews = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    final reviewData =
                        reviews[index].data() as Map<String, dynamic>;
                    final review =
                        reviewData['review'] as String? ?? 'No review';
                    final rating = reviewData['rating']?.toDouble() ?? 0.0;
                    final animeTitle =
                        reviewData['animeTitle'] as String? ?? 'No title';
                    final animeImage =
                        reviewData['animeImage'] as String? ?? '';

                    return Dismissible(
                      key: Key(reviews[index].id),
                      onDismissed: (direction) {
                        FirebaseFirestore.instance
                            .runTransaction((transaction) async {
                          final doc = reviews[index].reference;
                          transaction.delete(doc);
                        });
                    
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Review deleted')));
                      },
                      background: Container(color: Colors.red),
                      child: Card(
                        color: Color.fromRGBO(50, 50, 50, 1),
                        margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: animeImage.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: animeImage,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                )
                              : Icon(Icons.image, color: Colors.white),
                          title: Text(
                            animeTitle,
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review,
                                style: TextStyle(color: Colors.white70),
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
                );
              },
            )
          : Center(child: Text('Please log in to see your reviews')),
    );
  }
}
