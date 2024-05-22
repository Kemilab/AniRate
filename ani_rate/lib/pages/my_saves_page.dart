import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/anime_model.dart';
import 'anime_detail_page.dart';

class MySavesPage extends StatefulWidget {
  @override
  _MySavesPageState createState() => _MySavesPageState();
}

class _MySavesPageState extends State<MySavesPage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'my_saves'.tr(),
          style: const TextStyle(color: Color.fromARGB(255, 252, 131, 50)),
        ),
        backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 252, 131, 50)),
      ),
      body: user != null
          ? Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      color: Colors.black.withOpacity(0),
                    ),
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .collection('favorites')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('error_occurred'.tr()));
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('no_saves_found'.tr()));
                    }

                    final savedAnimes = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: savedAnimes.length,
                      itemBuilder: (context, index) {
                        final animeData =
                            savedAnimes[index].data() as Map<String, dynamic>;

                        // Debugging: Print animeData
                        print('Anime Data: $animeData');

                        Anime? anime;
                        try {
                          anime = Anime.fromJson(animeData);
                        } catch (e) {
                          print('Error parsing anime data: $e');
                          return ListTile(
                            title: Text('Error loading anime',
                                style: TextStyle(color: Colors.red)),
                          );
                        }

                        if (anime == null) {
                          return ListTile(
                            title: Text('Invalid anime data',
                                style: TextStyle(color: Colors.red)),
                          );
                        }

                        return Dismissible(
                          key: Key(savedAnimes[index].id),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          onDismissed: (direction) async {
                            final docReference = savedAnimes[index].reference;
                            final removedAnime = savedAnimes[index];

                            // Capture the context
                            final snackBarContext = context;

                            // Remove the item from the list immediately
                            setState(() {
                              savedAnimes.removeAt(index);
                            });

                            try {
                              await FirebaseFirestore.instance
                                  .runTransaction((transaction) async {
                                transaction.delete(docReference);
                              });

                              ScaffoldMessenger.of(snackBarContext)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text('save_deleted'.tr()),
                                  action: SnackBarAction(
                                    label: 'UNDO',
                                    onPressed: () {
                                      setState(() {
                                        savedAnimes.insert(index, removedAnime);
                                      });
                                    },
                                  ),
                                ),
                              );
                            } catch (e) {
                              // Re-insert the item in case of error
                              setState(() {
                                savedAnimes.insert(index, removedAnime);
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
                              leading: anime.coverImageUrl.isNotEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: anime.coverImageUrl,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    )
                                  : const Icon(Icons.image,
                                      color: Colors.white),
                              title: Text(
                                anime.title,
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    anime.englishTitle,
                                    style:
                                        const TextStyle(color: Colors.white70),
                                  ),
                                  Row(
                                    children: List.generate(5, (index) {
                                      return Icon(
                                        index <
                                                ((anime?.meanScore ?? 0) / 20)
                                                    .round()
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: Colors.amber,
                                      );
                                    }),
                                  ),
                                ],
                              ),
                              onTap: () {
                                if (anime != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AnimeDetailPage(anime: anime!),
                                    ),
                                  );
                                }
                              },
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
