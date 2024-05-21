import 'package:ani_rate/pages/anime_detail_page.dart';
import 'package:ani_rate/providers/anime_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimeListByTagPage extends StatefulWidget {
  final String tag;

  const AnimeListByTagPage({Key? key, required this.tag}) : super(key: key);

  @override
  _AnimeListByTagPageState createState() => _AnimeListByTagPageState();
}

class _AnimeListByTagPageState extends State<AnimeListByTagPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _fetchAnimeByTag();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        !_isLoading &&
        !_reachedEnd) {
      _fetchAnimeByTag();
    }
  }

  bool _isLoading = false;
  bool _reachedEnd = false;

  Future<void> _fetchAnimeByTag() async {
    if (_isLoading || _reachedEnd) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<AnimeProvider>(context, listen: false)
          .fetchAnimeByTag(widget.tag);
    } catch (error) {
      print('Error fetching anime by tag: $error');
    } finally {
      setState(() {
        _isLoading = false;
        _reachedEnd = _reachedEnd ||
            Provider.of<AnimeProvider>(context, listen: false)
                    .animeList
                    .length ==
                0;
      });
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
          final animeList = animeProvider.animeList;

          return GridView.builder(
            controller: _scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: animeList.length + (_isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == animeList.length && _isLoading) {
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
