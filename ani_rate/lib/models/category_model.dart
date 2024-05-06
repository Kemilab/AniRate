import 'package:flutter/material.dart';
class CategoryModel{
  String name;
  String coverPath;
  Color boxColor;

  CategoryModel({
    required this.name,
    required this.coverPath,
    required this.boxColor,
  });

 static  List<CategoryModel> getCategories(){
    List<CategoryModel> categories = [];

    categories.add(
      CategoryModel(
        name: 'One Piece',
        coverPath: 'assets/onepiece_main_cover.png',
        boxColor: Colors.pink)
    );

    categories.add(
      CategoryModel(
        name: 'Attack On Titan',
        coverPath: 'assets/attackontitan_main_cover.png',
        boxColor: const Color.fromARGB(255, 30, 209, 233))
    );

    categories.add(
      CategoryModel(
        name: 'My hero academia',
        coverPath: 'assets/mha_main_cover.png',
        boxColor: Colors.pink)
    );

    categories.add(
      CategoryModel(
        name: 'Dragon ball',
        coverPath: 'assets/dragonball_main_cover.png',
        boxColor: const Color.fromARGB(255, 30, 209, 233))
    );

    return categories;
  }
}