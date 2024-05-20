import 'package:ani_rate/pages/anime_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/anime_model.dart';

class AnimeListByTagPage extends StatelessWidget {
  final String tag;

  const AnimeListByTagPage({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anime List - $tag'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('anime')
            .where('tags', arrayContains: tag)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color.fromARGB(255, 252, 131, 50)));
          }
          final docs = snapshot.data?.docs ?? [];
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final anime = Anime.fromJson((docs[index].data() as Map<String, dynamic>));
              return ListTile(
                title: Text(anime.title),
                subtitle: Text('Type: ${anime.type}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnimeDetailPage(anime: anime),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}