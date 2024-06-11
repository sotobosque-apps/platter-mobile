// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http_hive_cache/http_hive_cache.dart';
import 'package:platter/models/AmazonProducts.dart';
import 'package:platter/models/Recipe.dart';
import 'package:platter/models/RecipeRecomendations.dart';
import 'package:platter/models/RecipeReview.dart';

String $LIKE =
    "$mainDomain/api/platterauth/recipelike/[recipe_id]?user=[user_id]";

String $SHOPPINGLIST =
    "$mainDomain/api/platterauth/recipeshopping/[recipe_id]?user=[user_id]";

String $USERLIKES = "$mainDomain/api/platterauth/recipeLikesByUser/[user_id]";

String $USERSHOPPINGLIST =
    "$mainDomain/api/platterauth/shoppingListsbyUser/[user_id]";

const String mainDomain = "https://74a6-186-120-37-14.ngrok-free.app";

final Map<String, Function> parseableStrings = {"Recipes": recipeUri};

String recipeUri(
        {String? search_expression, String? method, String? page_number}) =>
    "$mainDomain/api/fatsecretsource/recipes.search.v3?format=json&method=${method ?? "recipes.search.v3"}&search_expression=${search_expression ?? "rice"}&page_number=${page_number ?? 0}&must_have_images=true";

final dynamic castedResult = {
  "Recipes": "List_recipe",
};

class FatsecretSelector {
  
}
