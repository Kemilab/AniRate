import 'package:ani_rate/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/anime_model.dart';
import '../providers/anime_provider.dart';
import 'anime_detail_page.dart';

class MyHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => ProfilePage(),
                );
              },
              child: const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://www.woolha.com/media/2020/03/eevee.png'), // Replace with actual profile image URL
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                onChanged: (query) {
                  Provider.of<AnimeProvider>(context, listen: false)
                      .searchAnime(query);
                },
                style: const TextStyle(color: Color.fromARGB(255, 255, 119, 29)),
                decoration: InputDecoration(
                  hintText: 'Search anime...',
                  hintStyle: const TextStyle(color: Color.fromARGB(255, 255, 119, 29)),
                  prefixIcon: const Icon(Icons.search, color: Color.fromARGB(255, 255, 119, 29)),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Color.fromARGB(255, 255, 119, 29)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.black,
        child: AnimeGridView(),
      ),
    );
  }
}

class AnimeGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AnimeProvider>(
      builder: (context, animeProvider, child) {
        if (animeProvider.isLoading && animeProvider.animeList.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: Color.fromARGB(255, 252, 131, 50)),
          );
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!animeProvider.isLoading &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
              animeProvider.fetchAnime();
              return true;
            }
            return false;
          },
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: animeProvider.animeList.length,
            itemBuilder: (context, index) {
              Anime anime = animeProvider.animeList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnimeDetailPage(anime: anime),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: anime.coverImageUrl,
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
