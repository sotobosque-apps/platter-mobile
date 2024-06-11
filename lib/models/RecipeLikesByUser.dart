// To parse this JSON data, do
//
//     final recipeLikesByUser = recipeLikesByUserFromJson(jsonString);

import 'dart:convert';

List<RecipeLikesByUser> recipeLikesByUserFromDynamic(List<dynamic> str) =>
    List<RecipeLikesByUser>.from(str.map((x) => RecipeLikesByUser.fromJson(x)));
List<RecipeLikesByUser> recipeLikesByUserFromJson(String str) =>
    List<RecipeLikesByUser>.from(
        json.decode(str).map((x) => RecipeLikesByUser.fromJson(x)));

String recipeLikesByUserToJson(List<RecipeLikesByUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecipeLikesByUser {
  final int? id;
  final bool? active;
  final String? recipeId;
  final Map<String, dynamic>? users;

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic publishedAt;
  final Recipe? recipe;

  RecipeLikesByUser({
    this.id,
    this.active,
    this.recipeId,
    this.users,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.recipe,
  });

  factory RecipeLikesByUser.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> users = {};
    try {
      users = json["users"];
    } catch (e) {
      print(e);
      print("catch json['users']");
      print(json["users"]);
    }

    return RecipeLikesByUser(
      id: json["id"],
      active: json["active"],
      recipeId: json["recipeId"],
      users: users,
      createdAt:
          json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      updatedAt:
          json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      publishedAt: json["publishedAt"],
      recipe: json["recipe"] == null ? null : Recipe.fromJson(json["recipe"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "active": active,
        "recipeId": recipeId,
        "users": jsonEncode(users),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "publishedAt": publishedAt,
        "recipe": recipe?.toJson(),
      };
}

class Recipe {
  final String? recipeName;
  final String? recipeDescription;
  final String? recipeImage;
  final String? recipeId;

  Recipe({
    this.recipeName,
    this.recipeDescription,
    this.recipeImage,
    this.recipeId,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        recipeName: json["recipeName"],
        recipeDescription: json["recipeDescription"],
        recipeImage: json["recipeImage"],
        recipeId: json["recipeId"],
      );

  Map<String, dynamic> toJson() => {
        "recipeName": recipeName,
        "recipeDescription": recipeDescription,
        "recipeImage": recipeImage,
        "recipeId": recipeId,
      };
}
