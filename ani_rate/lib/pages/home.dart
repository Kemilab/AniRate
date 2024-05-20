import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/anime_provider.dart';
import 'anime_detail_page.dart';
import 'profile_page.dart';

class MyHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final animeProvider = Provider.of<AnimeProvider>(context);

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
                  'https://www.woolha.com/media/2020/03/eevee.png',
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                onChanged: (query) {
                  animeProvider.searchAnime(query);
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
    final animeProvider = Provider.of<AnimeProvider>(context);

    return animeProvider.isLoading
        ? Center(child: CircularProgressIndicator())
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: animeProvider.animeList.length,
            itemBuilder: (context, index) {
              final anime = animeProvider.animeList[index];
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
                    child: Image.network(
                      anime.coverImageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              );
            },
          );
  }
}
