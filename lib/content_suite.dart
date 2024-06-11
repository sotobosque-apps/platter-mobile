import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:platter/change_notifiers/AppStatusNotifier.dart';
import 'package:platter/mobile_constants.dart';
import 'package:provider/provider.dart';

Map<String, List> CONTENT_CATEGORIES = {
  "Appetizer": ["Shrimp", "Cheese", "Crackers", "Vegetables", "Dips"],
  "Soup": ["Chicken Broth", "Vegetables", "Noodles", "Beans", "Lentils"],
  "Main Dish": ["Chicken", "Beef", "Fish", "Pasta", "Rice", "Potatoes"],
  "Side Dish": ["Vegetables", "Rice", "Potatoes", "Quinoa"],
  "Bakery Products": ["Flour", "Sugar", "Eggs", "Butter", "Baking Powder"],
  "Salad & Dressings": [
    "Lettuce",
    "Tomatoes",
    "Cucumbers",
    "Olive Oil",
    "Vinegar",
    "Herbs"
  ],
  "Sauces & Dressings": [
    "Tomatoes",
    "Garlic",
    "Onion",
    "Mustard",
    "Mayonnaise"
  ],
  "Dessert": ["Chocolate", "Flour", "Sugar", "Eggs", "Butter"],
  "Snacks": ["Nuts", "Seeds", "Dried Fruit", "Granola", "Cheese"],
  "Drinks & Beverages": ["Water", "Fruit Juice", "Milk", "Tea", "Coffee"],
  "Other": ["Various"],
  "Breakfast": ["Eggs", "Bacon", "Oats", "Bread", "Fruit"],
  "Lunch": ["Sandwich Meats", "Cheese", "Lettuce", "Bread", "Soup"]
};

dynamic CONTENT_SUITE(BuildContext context, String routeName) {
  AppStatusNotifier notifier =
      Provider.of<AppStatusNotifier>(context, listen: false);

  final Map<String, dynamic> SUITE = {
    "home": {
      "Morning Delights": {
        "URL": (String? pageNumber) => notifier.fatsecretConsumer(
                'recipes.search.v3', {
              'search_expression': 'Pancakes Toast Smoothie',
              "page_number": pageNumber ?? "0"
            }),
        "name": "Morning Delights",
        "description":
            "Start your day with a delicious and energizing breakfast."
      },
      "Morning Beverages": {
        "URL": (String? pageNumber) => notifier.fatsecretConsumer(
                'recipes.search.v3', {
              'search_expression': 'oranges coffee Tea',
              "page_number": pageNumber ?? "0"
            }),
        "name": "Morning Beverages",
        "description": "Pair your breakfast with a refreshing drink."
      },
     
    },
    "suited_trendy_content_smoothie": {
      "Morning stuff": {
        "URL": (String? pageNumber) => notifier.fatsecretConsumer(
            'recipes.search.v3',
            {"recipe_types": "Beverage", "page_number": pageNumber ?? "0"}),
        "name": "Morning stuff",
        "description": "this is a great way to start a day"
      },
      "Baked stuff": {
        "URL": (String? pageNumber) => notifier.fatsecretConsumer(
            'recipes.search.v3',
            {"recipe_types": "Baked", "page_number": pageNumber ?? "0"}),
        "name": "Baked stuff",
        "description": "this is a great way to start a day"
      },
      "Main dishes": {
        "name": "Main dishes",
        "description": "this is another way to start a day",
        "URL": (String? pageNumber) => notifier.fatsecretConsumer(
            'recipes.search.v3',
            {"recipe_types": "Main Dish", "page_number": pageNumber ?? "0"})
      },
    },
    "suited_trendy_content_appetizer": {
      "Morning stuff": {
        "URL": (String? pageNumber) => notifier.fatsecretConsumer(
            'recipes.search.v3',
            {"recipe_types": "Beverage", "page_number": pageNumber ?? "0"}),
        "name": "Morning stuff",
        "description": "this is a great way to start a day"
      },
      "Baked stuff": {
        "URL": (String? pageNumber) => notifier.fatsecretConsumer(
            'recipes.search.v3',
            {"recipe_types": "Baked", "page_number": pageNumber ?? "0"}),
        "name": "Baked stuff",
        "description": "this is a great way to start a day"
      },
      "Main dishes": {
        "name": "Main dishes",
        "description": "this is another way to start a day",
        "URL": (String? pageNumber) => notifier.fatsecretConsumer(
            'recipes.search.v3',
            {"recipe_types": "Main Dish", "page_number": pageNumber ?? "0"})
      },
    },
    "suited_trendy_content_healthy": {
      "Morning stuff": {
        "URL": (String? pageNumber) => notifier.fatsecretConsumer(
            'recipes.search.v3', {"recipe_types": "Beverage"}),
        "name": "Morning stuff",
        "description": "this is a great way to start a day"
      },
      "Baked stuff": {
        "URL": (String? pageNumber) => notifier
            .fatsecretConsumer('recipes.search.v3', {"recipe_types": "Baked"}),
        "name": "Baked stuff",
        "description": "this is a great way to start a day"
      },
      "Main dishes": {
        "name": "Main dishes",
        "description": "this is another way to start a day",
        "URL": (String? pageNumber) => notifier.fatsecretConsumer(
            'recipes.search.v3', {"recipe_types": "Main Dish"})
      },
    },
    "suited_trendy_content_salads": {
      "Morning stuff": {
        "URL": (String? pageNumber) => notifier.fatsecretConsumer(
            'recipes.search.v3',
            {"recipe_types": "Beverage", "page_number": pageNumber ?? "0"}),
        "name": "Morning stuff",
        "description": "this is a great way to start a day"
      },
      "Baked stuff": {
        "URL": (String? pageNumber) => notifier.fatsecretConsumer(
            'recipes.search.v3',
            {"recipe_types": "Baked", "page_number": pageNumber ?? "0"}),
        "name": "Baked stuff",
        "description": "this is a great way to start a day"
      },
      "Main dishes": {
        "name": "Main dishes",
        "description": "this is another way to start a day",
        "URL": (String? pageNumber) => notifier.fatsecretConsumer(
            'recipes.search.v3',
            {"recipe_types": "Main Dish", "page_number": pageNumber ?? "0"})
      },
    },
  };

  CONTENT_CATEGORIES.entries.forEach((categoryElement) {
    // print(categoryElement.value.join(" "));
    // print(jsonEncode({
    //   "name": categoryElement.key,
    //   "description": "",
    //   "URL": (String? pageNumber) => notifier.fatsecretConsumer(
    //       'recipes.search.v3', {"search_expression": categoryElement.value.join(" ")})
    // }));
    if (routeName.contains(categoryElement.key.toLowerCase())) {
      SUITE["suited_untrendy_content_${categoryElement.key.toLowerCase()}"] ??=
          {};

      categoryElement.value.forEach((element) {
        SUITE["suited_untrendy_content_${categoryElement.key.toLowerCase()}"]
            [element] = {
          "name": element,
          "description": "",
          "URL": (String? pageNumber) => notifier.fatsecretConsumer(
              'recipes.search.v3',
              {"search_expression": element, "page_number": pageNumber ?? "0"})
        };
      });
    }
  });

  // SUITE.keys.forEach((element) => print(element),);
  Map r = SUITE[routeName];
  r?.map((key, value) {
    value["_URL"] = value["URL"];
    value["URL"] = value["URL"]?.call("0");

    return MapEntry(key, value);
  });
  return r;
}
