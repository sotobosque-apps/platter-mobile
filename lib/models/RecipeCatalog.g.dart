// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RecipeCatalog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipesCatalog _$RecipesCatalogFromJson(Map<String, dynamic> json) =>
    RecipesCatalog(
      id: (json['id'] as num?)?.toInt(),
      active: json['active'] as bool?,
      recipeId: json['recipeId'] as String?,
      users: json['users'] == null
          ? null
          : Users.fromJson(json['users'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      publishedAt: json['publishedAt'],
      recipe: json['recipe'] == null
          ? null
          : Recipe.fromJson(json['recipe'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecipesCatalogToJson(RecipesCatalog instance) =>
    <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
      'recipeId': instance.recipeId,
      'users': instance.users,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'publishedAt': instance.publishedAt,
      'recipe': instance.recipe,
    };

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
      recipeName: json['recipeName'] as String?,
      recipeDescription: json['recipeDescription'] as String?,
      recipeImage: json['recipeImage'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'recipeName': instance.recipeName,
      'recipeDescription': instance.recipeDescription,
      'recipeImage': instance.recipeImage,
      'id': instance.id,
    };

Users _$UsersFromJson(Map<String, dynamic> json) => Users(
      the9: json['9'] as bool?,
    );

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
      '9': instance.the9,
    };
