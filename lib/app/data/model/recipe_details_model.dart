import 'package:recipes/app/data/model/result_error_model.dart';

class RecipeDetailsResponseModel {
  final Map<String, dynamic>? data;
  final List<ResultErrorModel>? errors;

  RecipeDetailsResponseModel({
    this.data,
    this.errors,
  });

  factory RecipeDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return RecipeDetailsResponseModel(
      data: Map<String, dynamic>.from(json['recipe'] as Map),
    );
  }

  factory RecipeDetailsResponseModel.withError(Map<String, dynamic> json) {
    Iterable? errors = json['errors'];
    List<ResultErrorModel>? errorsResult;

    if (errors != null) {
      errorsResult = errors.map((i) => ResultErrorModel.fromJson(i)).toList();
    } else {
      errorsResult = null;
    }

    return RecipeDetailsResponseModel(
      errors: errorsResult,
    );
  }
}

class RecipeDetailsModel {
  String? uri;
  String? label;
  String? image;
  String? source;
  String? url;
  List<RecipeIngredientModel>? ingredients;
  List<String>? ingredientLines;
  List<String>? healthLabels;

  RecipeDetailsModel({
    this.uri,
    this.label,
    this.image,
    this.source,
    this.url,
    this.ingredients,
    this.ingredientLines,
    this.healthLabels,
  });

  factory RecipeDetailsModel.fromJson(Map<String, dynamic> json) {
    var ingredients = json['ingredients'] as List;
    var ingredientLines = json['ingredientLines'] as List;
    var healthLabels = json['healthLabels'] as List;

    List<RecipeIngredientModel> ingredientsList = ingredients.map((i) => RecipeIngredientModel.fromJson(i)).toList();
    List<String> ingredientLinesList = ingredientLines.map((i) => i as String).toList();
    List<String> healthLabelsList = healthLabels.map((i) => i as String).toList();

    return RecipeDetailsModel(
      uri: json['uri'] as String?,
      label: json['label'] as String?,
      image: json['image'] as String?,
      source: json['source'] as String?,
      url: json['url'] as String?,
      ingredients: ingredientsList,
      ingredientLines: ingredientLinesList,
      healthLabels: healthLabelsList,
    );
  }
}

class RecipeIngredientModel {
  String? text;
  num? quantity;
  String? measure;
  String? food;
  num? weight;
  String? foodCategory;
  String? foodId;
  String? image;

  RecipeIngredientModel({
    this.text,
    this.quantity,
    this.measure,
    this.food,
    this.weight,
    this.foodCategory,
    this.foodId,
    this.image,
  });

  factory RecipeIngredientModel.fromJson(Map<String, dynamic> json) {
    return RecipeIngredientModel(
      text: json['text'] as String?,
      quantity: json['quantity'] as num?,
      measure: json['measure'] as String?,
      food: json['food'] as String?,
      weight: json['weight'] as num?,
      foodCategory: json['foodCategory'] as String?,
      foodId: json['foodId'] as String?,
      image: json['image'] as String?,
    );
  }
}
