// To parse this JSON data, do
//
//     final recipeList = recipeListFromJson(jsonString);

import 'dart:convert';

RecipeList recipeListFromJson(String str) => RecipeList.fromJson(json.decode(str));

String recipeListToJson(RecipeList data) => json.encode(data.toJson());

class RecipeList {
    final Recipes? recipes;

    RecipeList({
        this.recipes,
    });

    factory RecipeList.fromJson(Map<String, dynamic> json) => RecipeList(
        recipes: json["recipes"] == null ? null : Recipes.fromJson(json["recipes"]),
    );

    Map<String, dynamic> toJson() => {
        "recipes": recipes?.toJson(),
    };
}

class Recipes {
    final String? maxResults;
    final String? pageNumber;
    final List<Recipe>? recipe;
    final String? totalResults;

    Recipes({
        this.maxResults,
        this.pageNumber,
        this.recipe,
        this.totalResults,
    });

    factory Recipes.fromJson(Map<String, dynamic> json) => Recipes(
        maxResults: json["max_results"],
        pageNumber: json["page_number"],
        recipe: json["recipe"] == null ? [] : List<Recipe>.from(json["recipe"]!.map((x) => Recipe.fromJson(x))),
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "max_results": maxResults,
        "page_number": pageNumber,
        "recipe": recipe == null ? [] : List<dynamic>.from(recipe!.map((x) => x.toJson())),
        "total_results": totalResults,
    };
}

class Recipe {
    final String? recipeDescription;
    final String? recipeId;
    final String? recipeImage;
    final RecipeIngredients? recipeIngredients;
    final String? recipeName;
    final RecipeNutrition? recipeNutrition;
    final RecipeTypes? recipeTypes;

    Recipe({
        this.recipeDescription,
        this.recipeId,
        this.recipeImage,
        this.recipeIngredients,
        this.recipeName,
        this.recipeNutrition,
        this.recipeTypes,
    });

    factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        recipeDescription: json["recipe_description"],
        recipeId: json["recipe_id"],
        recipeImage: json["recipe_image"],
        recipeIngredients: json["recipe_ingredients"] == null ? null : RecipeIngredients.fromJson(json["recipe_ingredients"]),
        recipeName: json["recipe_name"],
        recipeNutrition: json["recipe_nutrition"] == null ? null : RecipeNutrition.fromJson(json["recipe_nutrition"]),
        recipeTypes: json["recipe_types"] == null ? null : RecipeTypes.fromJson(json["recipe_types"]),
    );

    Map<String, dynamic> toJson() => {
        "recipe_description": recipeDescription,
        "recipe_id": recipeId,
        "recipe_image": recipeImage,
        "recipe_ingredients": recipeIngredients?.toJson(),
        "recipe_name": recipeName,
        "recipe_nutrition": recipeNutrition?.toJson(),
        "recipe_types": recipeTypes?.toJson(),
    };
}

class RecipeIngredients {
    final List<String>? ingredient;

    RecipeIngredients({
        this.ingredient,
    });

    factory RecipeIngredients.fromJson(Map<String, dynamic> json) => RecipeIngredients(
        ingredient: json["ingredient"] == null ? [] : List<String>.from(json["ingredient"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "ingredient": ingredient == null ? [] : List<dynamic>.from(ingredient!.map((x) => x)),
    };
}

class RecipeNutrition {
    final String? calories;
    final String? carbohydrate;
    final String? fat;
    final String? protein;

    RecipeNutrition({
        this.calories,
        this.carbohydrate,
        this.fat,
        this.protein,
    });

    factory RecipeNutrition.fromJson(Map<String, dynamic> json) => RecipeNutrition(
        calories: json["calories"],
        carbohydrate: json["carbohydrate"],
        fat: json["fat"],
        protein: json["protein"],
    );

    Map<String, dynamic> toJson() => {
        "calories": calories,
        "carbohydrate": carbohydrate,
        "fat": fat,
        "protein": protein,
    };
}

class RecipeTypes {
    final List<String>? recipeType;

    RecipeTypes({
        this.recipeType,
    });

    factory RecipeTypes.fromJson(Map<String, dynamic> json) => RecipeTypes(
        recipeType: json["recipe_type"] == null ? [] : List<String>.from(json["recipe_type"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "recipe_type": recipeType == null ? [] : List<dynamic>.from(recipeType!.map((x) => x)),
    };
}
