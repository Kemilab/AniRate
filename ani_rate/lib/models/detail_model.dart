class DetailModel{
  String imagepath;
  String title;
  

  DetailModel({
    required this.imagepath,
    required this.title,
  });

 static  List<DetailModel> getDetails(){
    List<DetailModel> details = [];

    details.add(
      DetailModel(
        imagepath: 'assets/onepiece_spotlight.png',
        title: 'One Piece',
      )
    );

    return details;
  }
}