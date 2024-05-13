class TopRatingModel{
  String coverPath;

  TopRatingModel({
    required this.coverPath,
  });

 static  List<TopRatingModel> getTopRatings(){
    List<TopRatingModel> topRatings = [];

    topRatings.add(
      TopRatingModel(
        coverPath: 'assets/onepiece_main_cover.png',)
    );

    topRatings.add(
      TopRatingModel(
        coverPath: 'assets/attackontitan_main_cover.png',)
    );

    topRatings.add(
      TopRatingModel(
        coverPath: 'assets/mha_main_cover.png',)
    );

    topRatings.add(
      TopRatingModel(
        coverPath: 'assets/jujutsukaisen_main_cover.png',)
    );

    return topRatings;
  }
}