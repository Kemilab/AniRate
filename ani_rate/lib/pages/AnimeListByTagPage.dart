import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ani_rate/pages/anime_detail_page.dart';
import 'package:ani_rate/providers/anime_provider.dart';

class AnimeListByTagPage extends StatefulWidget {
  final String tag;

  const AnimeListByTagPage({Key? key, required this.tag}) : super(key: key);

  @override
  _AnimeListByTagPageState createState() => _AnimeListByTagPageState();
}

class _AnimeListByTagPageState extends State<AnimeListByTagPage> {
  late ScrollController _scrollController;
  bool _isLoading = false;
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _fetchAnimeByTag();
  }

  @override
  void dispose() {
    _isMounted = false;
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && !_isLoading) {
      _fetchAnimeByTag();
    }
  }

  Future<void> _fetchAnimeByTag() async {
    if (_isLoading || !_isMounted) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<AnimeProvider>(context, listen: false).fetchAnimeByTag(widget.tag);
    } catch (error) {
      print('Error fetching anime by tag: $error');
    } finally {
      if (_isMounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anime List - ${widget.tag}'),
      ),
      body: Consumer<AnimeProvider>(
        builder: (context, animeProvider, _) {
          final animeList = animeProvider.animeList.where((anime) => anime.tags.contains(widget.tag)).toList();
          final hasMore = animeProvider.hasMore;

          return GridView.builder(
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: animeList.length + (hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == animeList.length) {
                return Center(child: CircularProgressIndicator());
              }

              final anime = animeList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnimeDetailPage(anime: anime),
                    ),
                  );
                },
                child: Card(
                  elevation: 4.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: anime.coverImageUrl,
                      fit: BoxFit.cover,
                    ),
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
