// To parse this JSON data, do
//
//     final recipeReview = recipeReviewFromJson(jsonString);

import 'dart:convert';

RecipeReview recipeReviewFromJson(String str) =>
    RecipeReview.fromJson(json.decode(str));

String recipeReviewToJson(RecipeReview data) => json.encode(data.toJson());

class RecipeReview {
  final Recipe? recipe;

  RecipeReview({
    this.recipe,
  });

  factory RecipeReview.fromJson(Map<String, dynamic> json) => RecipeReview(
        recipe: json["recipe"] == null ? null : Recipe.fromJson(json["recipe"]),
      );

  Map<String, dynamic> toJson() => {
        "recipe": recipe?.toJson(),
      };

  Map<String, dynamic> toJsonB() => {
        "recipeName": recipe?.recipeName ?? '',
        "recipeDescription": recipe?.recipeDescription ?? '',
        "recipeImage": recipe?.recipeImages?.recipeImage?[0] ?? '',
        "recipeId": recipe?.recipeId ?? '',
      };
}

class Recipe {
  final String? cookingTimeMin;
  final Directions? directions;
  final String? gramsPerPortion;
  final Ingredients? ingredients;
  final String? numberOfServings;
  final String? preparationTimeMin;
  final String? rating;
  final RecipeCategories? recipeCategories;
  final String? recipeDescription;
  final String? recipeId;
  final RecipeImages? recipeImages;
  final String? recipeName;
  final RecipeTypes? recipeTypes;
  final String? recipeUrl;
  final ServingSizes? servingSizes;

  Recipe({
    this.cookingTimeMin,
    this.directions,
    this.gramsPerPortion,
    this.ingredients,
    this.numberOfServings,
    this.preparationTimeMin,
    this.rating,
    this.recipeCategories,
    this.recipeDescription,
    this.recipeId,
    this.recipeImages,
    this.recipeName,
    this.recipeTypes,
    this.recipeUrl,
    this.servingSizes,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        cookingTimeMin: json["cooking_time_min"],
        directions: json["directions"] == null
            ? null
            : Directions.fromJson(json["directions"]),
        gramsPerPortion: json["grams_per_portion"],
        ingredients: json["ingredients"] == null
            ? null
            : Ingredients.fromJson(json["ingredients"]),
        numberOfServings: json["number_of_servings"],
        preparationTimeMin: json["preparation_time_min"],
        rating: json["rating"],
        recipeCategories: json["recipe_categories"] == null
            ? null
            : RecipeCategories.fromJson(json["recipe_categories"]),
        recipeDescription: json["recipe_description"],
        recipeId: json["recipe_id"],
        recipeImages: json["recipe_images"] == null
            ? null
            : RecipeImages.fromJson(json["recipe_images"]),
        recipeName: json["recipe_name"],
        recipeTypes: json["recipe_types"] == null
            ? null
            : RecipeTypes.fromJson(json["recipe_types"]),
        recipeUrl: json["recipe_url"],
        servingSizes: json["serving_sizes"] == null
            ? null
            : ServingSizes.fromJson(json["serving_sizes"]),
      );

  Map<String, dynamic> toJson() => {
        "cooking_time_min": cookingTimeMin,
        "directions": directions?.toJson(),
        "grams_per_portion": gramsPerPortion,
        "ingredients": ingredients?.toJson(),
        "number_of_servings": numberOfServings,
        "preparation_time_min": preparationTimeMin,
        "rating": rating,
        "recipe_categories": recipeCategories?.toJson(),
        "recipe_description": recipeDescription,
        "recipe_id": recipeId,
        "recipe_images": recipeImages?.toJson(),
        "recipe_name": recipeName,
        "recipe_types": recipeTypes?.toJson(),
        "recipe_url": recipeUrl,
        "serving_sizes": servingSizes?.toJson(),
      };
}

class Directions {
  final List<Direction>? direction;

  Directions({
    this.direction,
  });

  factory Directions.fromJson(Map<String, dynamic> json) => Directions(
        direction: json["direction"] == null
            ? []
            : List<Direction>.from(
                json["direction"]!.map((x) => Direction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "direction": direction == null
            ? []
            : List<dynamic>.from(direction!.map((x) => x.toJson())),
      };
}

class Direction {
  final String? directionDescription;
  final String? directionNumber;

  Direction({
    this.directionDescription,
    this.directionNumber,
  });

  factory Direction.fromJson(Map<String, dynamic> json) => Direction(
        directionDescription: json["direction_description"],
        directionNumber: json["direction_number"],
      );

  Map<String, dynamic> toJson() => {
        "direction_description": directionDescription,
        "direction_number": directionNumber,
      };
}

class Ingredients {
  final List<Ingredient>? ingredient;

  Ingredients({
    this.ingredient,
  });

  factory Ingredients.fromJson(Map<String, dynamic> json) => Ingredients(
        ingredient: json["ingredient"] == null
            ? []
            : List<Ingredient>.from(
                json["ingredient"]!.map((x) => Ingredient.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ingredient": ingredient == null
            ? []
            : List<dynamic>.from(ingredient!.map((x) => x.toJson())),
      };
}

class Ingredient {
  final String? foodId;
  final String? foodName;
  final String? ingredientDescription;
  final String? ingredientUrl;
  final String? measurementDescription;
  final String? numberOfUnits;
  final String? servingId;

  Ingredient({
    this.foodId,
    this.foodName,
    this.ingredientDescription,
    this.ingredientUrl,
    this.measurementDescription,
    this.numberOfUnits,
    this.servingId,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        foodId: json["food_id"],
        foodName: json["food_name"],
        ingredientDescription: json["ingredient_description"],
        ingredientUrl: json["ingredient_url"],
        measurementDescription: json["measurement_description"],
        numberOfUnits: json["number_of_units"],
        servingId: json["serving_id"],
      );

  Map<String, dynamic> toJson() => {
        "food_id": foodId,
        "food_name": foodName,
        "ingredient_description": ingredientDescription,
        "ingredient_url": ingredientUrl,
        "measurement_description": measurementDescription,
        "number_of_units": numberOfUnits,
        "serving_id": servingId,
      };
}

class RecipeCategories {
  final List<RecipeCategory>? recipeCategory;

  RecipeCategories({
    this.recipeCategory,
  });

  factory RecipeCategories.fromJson(Map<String, dynamic> json) =>
      RecipeCategories(
        recipeCategory: json["recipe_category"] == null
            ? []
            : List<RecipeCategory>.from(json["recipe_category"]!
                .map((x) => RecipeCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "recipe_category": recipeCategory == null
            ? []
            : List<dynamic>.from(recipeCategory!.map((x) => x.toJson())),
      };
}

class RecipeCategory {
  final String? recipeCategoryName;
  final String? recipeCategoryUrl;

  RecipeCategory({
    this.recipeCategoryName,
    this.recipeCategoryUrl,
  });

  factory RecipeCategory.fromJson(Map<String, dynamic> json) => RecipeCategory(
        recipeCategoryName: json["recipe_category_name"],
        recipeCategoryUrl: json["recipe_category_url"],
      );

  Map<String, dynamic> toJson() => {
        "recipe_category_name": recipeCategoryName,
        "recipe_category_url": recipeCategoryUrl,
      };
}

class RecipeImages {
  final List<String>? recipeImage;

  RecipeImages({
    this.recipeImage,
  });

  factory RecipeImages.fromJson(Map<String, dynamic> json) => RecipeImages(
        recipeImage: json["recipe_image"] == null
            ? []
            : List<String>.from(json["recipe_image"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "recipe_image": recipeImage == null
            ? []
            : List<dynamic>.from(recipeImage!.map((x) => x)),
      };
}

class RecipeTypes {
  final List<String>? recipeType;

  RecipeTypes({
    this.recipeType,
  });

  factory RecipeTypes.fromJson(Map<String, dynamic> json) => RecipeTypes(
        recipeType: json["recipe_type"] == null
            ? []
            : List<String>.from(json["recipe_type"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "recipe_type": recipeType == null
            ? []
            : List<dynamic>.from(recipeType!.map((x) => x)),
      };
}

class ServingSizes {
  final Serving? serving;

  ServingSizes({
    this.serving,
  });

  factory ServingSizes.fromJson(Map<String, dynamic> json) => ServingSizes(
        serving:
            json["serving"] == null ? null : Serving.fromJson(json["serving"]),
      );

  Map<String, dynamic> toJson() => {
        "serving": serving?.toJson(),
      };
}

class Serving {
  final String? calcium;
  final String? calories;
  final String? carbohydrate;
  final String? cholesterol;
  final String? fat;
  final String? fiber;
  final String? iron;
  final String? monounsaturatedFat;
  final String? polyunsaturatedFat;
  final String? potassium;
  final String? protein;
  final String? saturatedFat;
  final String? servingSize;
  final String? sodium;
  final String? sugar;
  final String? transFat;
  final String? vitaminA;
  final String? vitaminC;

  Serving({
    this.calcium,
    this.calories,
    this.carbohydrate,
    this.cholesterol,
    this.fat,
    this.fiber,
    this.iron,
    this.monounsaturatedFat,
    this.polyunsaturatedFat,
    this.potassium,
    this.protein,
    this.saturatedFat,
    this.servingSize,
    this.sodium,
    this.sugar,
    this.transFat,
    this.vitaminA,
    this.vitaminC,
  });

  factory Serving.fromJson(Map<String, dynamic> json) => Serving(
        calcium: json["calcium"],
        calories: json["calories"],
        carbohydrate: json["carbohydrate"],
        cholesterol: json["cholesterol"],
        fat: json["fat"],
        fiber: json["fiber"],
        iron: json["iron"],
        monounsaturatedFat: json["monounsaturated_fat"],
        polyunsaturatedFat: json["polyunsaturated_fat"],
        potassium: json["potassium"],
        protein: json["protein"],
        saturatedFat: json["saturated_fat"],
        servingSize: json["serving_size"],
        sodium: json["sodium"],
        sugar: json["sugar"],
        transFat: json["trans_fat"],
        vitaminA: json["vitamin_a"],
        vitaminC: json["vitamin_c"],
      );

  Map<String, dynamic> toJson() => {
        "calcium": calcium,
        "calories": calories,
        "carbohydrate": carbohydrate,
        "cholesterol": cholesterol,
        "fat": fat,
        "fiber": fiber,
        "iron": iron,
        "monounsaturated_fat": monounsaturatedFat,
        "polyunsaturated_fat": polyunsaturatedFat,
        "potassium": potassium,
        "protein": protein,
        "saturated_fat": saturatedFat,
        "serving_size": servingSize,
        "sodium": sodium,
        "sugar": sugar,
        "trans_fat": transFat,
        "vitamin_a": vitaminA,
        "vitamin_c": vitaminC,
      };
}
