import "package:json_annotation/json_annotation.dart";

part 'RecipeCatalog.g.dart';

@JsonSerializable()
class RecipesCatalog {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "active")
  bool? active;
  @JsonKey(name: "recipeId")
  String? recipeId;
  @JsonKey(name: "users")
  Users? users;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;
  @JsonKey(name: "publishedAt")
  dynamic publishedAt;
  @JsonKey(name: "recipe")
  Recipe? recipe;

  RecipesCatalog({
    this.id,
    this.active,
    this.recipeId,
    this.users,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.recipe,
  });

  factory RecipesCatalog.fromJson(Map<String, dynamic> json) =>
      _$RecipesCatalogFromJson(json);

  Map<String, dynamic> toJson() => _$RecipesCatalogToJson(this);
}

@JsonSerializable()
class Recipe {
  @JsonKey(name: "recipeName")
  String? recipeName;
  @JsonKey(name: "recipeDescription")
  String? recipeDescription;
  @JsonKey(name: "recipeImage")
  String? recipeImage;
  @JsonKey(name: "id")
  String? id;

  Recipe({
    this.recipeName,
    this.recipeDescription,
    this.recipeImage,
    this.id,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}

@JsonSerializable()
class Users {
  @JsonKey(name: "9")
  bool? the9;

  Users({
    this.the9,
  });

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  Map<String, dynamic> toJson() => _$UsersToJson(this);
}
