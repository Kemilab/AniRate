import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';

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
                  .orderBy('timestamp', descending: true)
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
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        FirebaseFirestore.instance
                            .runTransaction((transaction) async {
                          final doc = reviews[index].reference;
                          transaction.delete(doc);
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Review deleted')));
                      },
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        color: Colors.red,
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      child: Card(
                        color: Color.fromRGBO(50, 50, 50, 1),
                        margin: EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: CachedNetworkImage(
                                  imageUrl: animeImage,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  height: 100,
                                  width: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      animeTitle,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    ExpandableText(
                                      review,
                                      expandText: 'show more',
                                      collapseText: 'show less',
                                      maxLines: 2,
                                      linkColor: Colors.orangeAccent,
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
