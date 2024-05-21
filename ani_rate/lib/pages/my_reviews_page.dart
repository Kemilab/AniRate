import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyReviewsPage extends StatefulWidget {
  @override
  _MyReviewsPageState createState() => _MyReviewsPageState();
}

class _MyReviewsPageState extends State<MyReviewsPage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'my_reviews'.tr(),
          style: const TextStyle(color: Color.fromARGB(255, 252, 131, 50)),
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
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collectionGroup('reviews')
                      .where('userId', isEqualTo: user.uid)
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('error_occurred'.tr()));
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('no_reviews_found'.tr()));
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
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          onDismissed: (direction) async {
                            final docReference = reviews[index].reference;
                            final removedReview = reviews[index];

                            // Capture the context
                            final snackBarContext = context;

                            // Remove the item from the list immediately
                            setState(() {
                              reviews.removeAt(index);
                            });

                            try {
                              await FirebaseFirestore.instance
                                  .runTransaction((transaction) async {
                                transaction.delete(docReference);
                              });

                              ScaffoldMessenger.of(snackBarContext)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text('review_deleted'.tr()),
                                  action: SnackBarAction(
                                    label: 'UNDO',
                                    onPressed: () {
                                      setState(() {
                                        reviews.insert(index, removedReview);
                                      });
                                    },
                                  ),
                                ),
                              );
                            } catch (e) {
                              // Re-insert the item in case of error
                              setState(() {
                                reviews.insert(index, removedReview);
                              });

                              ScaffoldMessenger.of(snackBarContext)
                                  .showSnackBar(
                                SnackBar(
                                    content:
                                        Text('${'delete_failed'.tr()}: $e')),
                              );
                            }
                          },
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
                                    style:
                                        const TextStyle(color: Colors.white70),
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
                ),
              ],
            )
          : Center(child: Text('please_log_in'.tr())),
    );
  }
}
