class SpotlightModel{
  String spotlightPath;

  SpotlightModel({
    required this.spotlightPath,
  });

 static  List<SpotlightModel> getSpotlights(){
    List<SpotlightModel> spotlights = [];

    spotlights.add(
      SpotlightModel(
        spotlightPath: 'assets/aot_spotlight.svg',)
    );

    return spotlights;
  }
}