import 'package:recipes/app/data/model/result_error_model.dart';

class RecipesResponseModel {
  final int? from;
  final int? to;
  final int? count;
  final String? nextPageLink;
  final List<RecipeResultModel>? hits;
  final List<ResultErrorModel>? errors;

  RecipesResponseModel({
    this.from,
    this.to,
    this.count,
    this.nextPageLink,
    this.hits,
    this.errors,
  });

  factory RecipesResponseModel.fromJson(Map<String, dynamic> json) {
    Iterable? hits = json['hits'];
    List<RecipeResultModel>? hitsResult;

    if (hits != null) {
      hitsResult = hits.map((i) => RecipeResultModel.fromJson(i["recipe"])).toList();
    } else {
      hitsResult = null;
    }

    return RecipesResponseModel(
      from: json['from'] as int?,
      to: json['to'] as int?,
      count: json['count'] as int?,
      nextPageLink: json['_links']?['next']?['href'] as String?,
      hits: hitsResult,
    );
  }

  factory RecipesResponseModel.withError(List errors) {
    List<ResultErrorModel>? errorsResult;

    errorsResult = errors.map((i) => ResultErrorModel.fromJson(i)).toList();

    return RecipesResponseModel(
      errors: errorsResult,
    );
  }
}

class RecipeResultModel {
  String uri;
  String label;
  String image;
  String source;

  RecipeResultModel({
    required this.uri,
    required this.label,
    required this.image,
    required this.source,
  });

  factory RecipeResultModel.fromJson(Map<String, dynamic> json) {
    return RecipeResultModel(
      uri: json['uri'],
      label: json['label'],
      image: json['image'],
      source: json['source'],
    );
  }
}
