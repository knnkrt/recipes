import 'dart:developer';

import 'package:recipes/app/data/model/recipe_details_model.dart';
import 'package:recipes/app/data/model/recipe_results_model.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:recipes/app/utils/constants/meal_types.dart';

// Recipes Endpoint
const recipesUrl = '/recipes/v2/';

class ApiClient {
  final _dio = Dio(
    BaseOptions(
      baseUrl: "https://api.edamam.com/api",
      queryParameters: {
        "type": "public",
        "app_id": "45d5edb7",
        "app_key": "57bd6eccaa717a845b4b0312556ca012",
      },
      validateStatus: (status) => status! < 600,
    ),
  );

  // Retry Interceptor against internet connection problems
  ApiClient() {
    _dio.interceptors.add(
      RetryInterceptor(
        dio: _dio,
        logPrint: (message) => log(message, name: "DioRetry"),
        retries: 7,
        retryDelays: const [
          Duration(seconds: 1),
          Duration(seconds: 2),
          Duration(seconds: 3),
          Duration(seconds: 4),
          Duration(seconds: 5),
          Duration(seconds: 7),
          Duration(seconds: 10),
        ],
      ),
    );
  }

  // ! SEARCH
  Future<RecipesResponseModel?> search(String query, String? healthLabel, String? nextPageParameter) async {
    Map<String, dynamic> queryParameters = {
      'q': query,
    };

    // if health parameter is null or empty, API sends 400 code, so we should add parameter like this.
    if (healthLabel != null) {
      queryParameters['health'] = healthLabel;
    }

    // next page parameter
    if (nextPageParameter != null) {
      queryParameters['_cont'] = nextPageParameter;
    }

    final response = await _dio.get(
      recipesUrl,
      queryParameters: queryParameters,
    );

    if (response.statusCode == 200) {
      return RecipesResponseModel.fromJson(response.data);
    } else if (response.statusCode == 400 || response.statusCode == 403 || response.statusCode == 404) {
      return RecipesResponseModel.withError(response.data);
    } else {
      return null;
    }
  }

  // ! RECIPE DETAILS
  Future<RecipeDetailsResponseModel?> recipeDetails(String recipeID) async {
    final response = await _dio.get("$recipesUrl$recipeID");

    if (response.statusCode == 200) {
      return RecipeDetailsResponseModel.fromJson(response.data);
    } else if (response.statusCode == 400 || response.statusCode == 403 || response.statusCode == 404) {
      return RecipeDetailsResponseModel.withError(response.data);
    } else {
      return null;
    }
  }

  // ! RANDOM RECIPES
  Future<RecipesResponseModel?> getRandomRecipes() async {
    final response = await _dio.get(
      recipesUrl,
      queryParameters: {
        "random": true,
        "mealType": (mealTypes.toList()..shuffle()).first, // random mealTypes, so we can get a random results
      },
    );

    if (response.statusCode == 200) {
      return RecipesResponseModel.fromJson(response.data);
    } else if (response.statusCode == 400 || response.statusCode == 403 || response.statusCode == 404) {
      return RecipesResponseModel.withError(response.data);
    } else {
      return null;
    }
  }
}
