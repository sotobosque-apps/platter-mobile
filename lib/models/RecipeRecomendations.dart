// To parse this JSON data, do
//
//     final recipeRecomendations = recipeRecomendationsFromJson(jsonString);

import 'dart:convert';

RecipeRecomendations recipeRecomendationsFromJson(String str) => RecipeRecomendations.fromJson(json.decode(str));

String recipeRecomendationsToJson(RecipeRecomendations data) => json.encode(data.toJson());

class RecipeRecomendations {
    EssentialKitchenItems essentialKitchenItems;
    ServingWare servingWare;

    RecipeRecomendations({
        required this.essentialKitchenItems,
        required this.servingWare,
    });

    factory RecipeRecomendations.fromJson(Map<String, dynamic> json) => RecipeRecomendations(
        essentialKitchenItems: EssentialKitchenItems.fromJson(json["essentialKitchenItems"]),
        servingWare: ServingWare.fromJson(json["servingWare"]),
    );

    Map<String, dynamic> toJson() => {
        "essentialKitchenItems": essentialKitchenItems.toJson(),
        "servingWare": servingWare.toJson(),
    };
}

class EssentialKitchenItems {
    List<String> data;
    List<List<String?>> result;

    EssentialKitchenItems({
        required this.data,
        required this.result,
    });

    factory EssentialKitchenItems.fromJson(Map<String, dynamic> json) => EssentialKitchenItems(
        data: List<String>.from(json["data"].map((x) => x)),
        result: List<List<String?>>.from(json["result"].map((x) => List<String?>.from(x.map((x) => x)))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x)),
        "result": List<dynamic>.from(result.map((x) => List<dynamic>.from(x.map((x) => x)))),
    };
}

class ServingWare {
    List<String> data;
    List<List<String>> result;

    ServingWare({
        required this.data,
        required this.result,
    });

    factory ServingWare.fromJson(Map<String, dynamic> json) => ServingWare(
        data: List<String>.from(json["data"].map((x) => x)),
        result: List<List<String>>.from(json["result"].map((x) => List<String>.from(x.map((x) => x)))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x)),
        "result": List<dynamic>.from(result.map((x) => List<dynamic>.from(x.map((x) => x)))),
    };
}
