import 'package:get/get.dart';
import 'package:recipes/app/data/provider/api_v1.dart';
import 'package:recipes/app/routes/app_routes.dart';
import 'package:recipes/app/utils/extensions/parser_extension.dart';
import 'package:recipes/app/utils/helpers/toast.dart';

class HomeController extends GetxController {
  ApiClient apiClient = ApiClient();

  var findingRandomRecipe = false.obs;

  // For animated texts
  List<String> homeTexts = [
    "Find beautiful recipes!",
    "Be an excellent cook!",
    "Cook the healthiest meals.",
  ];

  Future<void> getRandomRecipe() async {
    findingRandomRecipe(true);

    var result = await apiClient.getRandomRecipes();

    if (result != null) {
      if (result.hits != null) {
        // get the recipeId of first result
        String recipeId = result.hits!.first.uri.uriToID();

        // go to recipe details
        Get.toNamed(AppRoutes.recipe + recipeId);
      } else {
        // ! errors
        kToast(message: result.errors!.first.message!);
      }
    } else {
      // ! API IS DOWN
      kToast(message: 'Oops. We hit the API limit or some other problems occured.');
    }

    findingRandomRecipe(false);
  }
}
