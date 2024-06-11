// To parse this JSON data, do
//
//     final recipe = recipeFromJson(jsonString);

import 'dart:convert';

Recipe recipeFromJson(String str) => Recipe.fromJson(json.decode(str));

String recipeToJson(Recipe data) => json.encode(data.toJson());

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
