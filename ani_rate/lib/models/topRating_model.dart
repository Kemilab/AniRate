class top_rating_model{
  String coverPath;

  top_rating_model({
    required this.coverPath,
  });

 static  List<top_rating_model> getTopRatings(){
    List<top_rating_model> topRatings = [];

    topRatings.add(
      top_rating_model(
        coverPath: 'assets/onepiece_main_cover.png',)
    );

    topRatings.add(
      top_rating_model(
        coverPath: 'assets/attackontitan_main_cover.png',)
    );

    topRatings.add(
      top_rating_model(
        coverPath: 'assets/mha_main_cover.png',)
    );

    topRatings.add(
      top_rating_model(
        coverPath: 'assets/jujutsukaisen_main_cover.png',)
    );

    return topRatings;
  }
}