// To parse this JSON data, do
//
//     final recipeComments = recipeCommentsFromJson(jsonString);

import 'dart:convert';

List<RecipeComments> recipeCommentsFromJsonB(dynamic str) =>
    List<RecipeComments>.from(
        str.map((x) => RecipeComments.fromJson(x)));

List<RecipeComments> recipeCommentsFromJson(String str) =>
    List<RecipeComments>.from(
        json.decode(str).map((x) => RecipeComments.fromJson(x)));

String recipeCommentsToJson(List<RecipeComments> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecipeComments {
  final int? id;
  final Map<String, dynamic>? users;
  final String? recipeId;
  final dynamic recipe;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic publishedAt;
  final bool? active;

  RecipeComments({
    this.id,
    this.users,
    this.recipeId,
    this.recipe,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.active,
  });

  factory RecipeComments.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> users = {};
    try {
      users = json["users"];
    } catch (e) {
      print(e);
      print("catch json['users']");
      print(json["users"]);
    }
    return RecipeComments(
      id: json["id"],
      users: users,
      recipeId: json["recipeId"],
      recipe: json["recipe"],
      createdAt:
          json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      updatedAt:
          json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      publishedAt: json["publishedAt"],
      active: json["active"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "users": jsonEncode(users),
        "recipeId": recipeId,
        "recipe": recipe,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "publishedAt": publishedAt,
        "active": active,
      };
}
