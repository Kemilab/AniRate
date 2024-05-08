import 'package:flutter/material.dart';
class CategoryModel{
  String coverPath;

  CategoryModel({
    required this.coverPath,
  });

 static  List<CategoryModel> getCategories(){
    List<CategoryModel> categories = [];

    categories.add(
      CategoryModel(
        coverPath: 'assets/onepiece_main_cover.png',)
    );

    categories.add(
      CategoryModel(
        coverPath: 'assets/attackontitan_main_cover.png',)
    );

    categories.add(
      CategoryModel(
        coverPath: 'assets/mha_main_cover.png',)
    );

    categories.add(
      CategoryModel(
        coverPath: 'assets/jujutsukaisen_main_cover.png',)
    );

    return categories;
  }
}