import 'package:flutter/material.dart';
import 'package:platter/models/Recipe.dart';

class AppNotifier extends ChangeNotifier {
  List<num> likedRecipe = [];
  List<num> favoriteRecipe = [];

  // -1 means: none
  num reviewRecipe = -1;

  // -1 means: default library section
  num currentLibrarySection = -1;

  AppNotifier();

  List<Recipe> likedRecipesCollection() {
    return [];
  }

  List<Recipe> favoriteRecipesCollection() {
    return [];
  }

  // Stream<Recipe> reviewRecipeStream(num _reviewRecipe) {
  //   reviewRecipe = _reviewRecipe;
  //   // notifyListeners();
  //   // return Future(() => Recipe()).asStream();
  // }
}
