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
                    final review = reviewData['review'] as String;
                    final rating = reviewData['rating'] as double;
                    final animeTitle = reviewData['animeTitle'] as String;
                    final animeImage = reviewData['animeImage'] as String;

                    return Card(
                      color: Color.fromRGBO(50, 50, 50, 1),
                      margin: EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: animeImage,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
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
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            FirebaseFirestore.instance
                                .runTransaction((transaction) async {
                              final doc = reviews[index].reference;
                              transaction.delete(doc);
                            });
                          },
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
