import 'package:recipes/app/data/model/recipe_details_model.dart';
import 'package:recipes/app/data/services/db_service.dart';
import 'package:recipes/app/modules/favorites/favorites_controller.dart';
import 'package:recipes/app/utils/helpers/toast.dart';
import 'package:get/get.dart';
import 'package:recipes/app/data/provider/api_v1.dart';

class RecipeController extends GetxController {
  ApiClient apiClient = ApiClient();

  String? recipeID = Get.parameters["recipe_id"];

  var recipeDetails = RecipeDetailsModel().obs;

  var pageLoading = true.obs;
  var recipeLiked = false.obs;

  @override
  void onInit() async {
    var result = await DbService.getLike(recipeID!);

    // Recipe Liked before
    if (result != null) {
      recipeLiked(true);
    }

    // Get Recipe Details
    getRecipeDetails();

    super.onInit();
  }

  Future<void> getRecipeDetails() async {
    var result = await apiClient.recipeDetails(recipeID!);

    if (result != null) {
      if (result.data != null) {
        // GET RECIPE DETAILS
        recipeDetails.value = RecipeDetailsModel.fromJson(result.data!);
      } else {
        // ! errors
        kToast(message: result.errors!.first.message!);
      }
    } else {
      // ! API IS DOWN
      Get.back(); // go back, close page
      kToast(message: 'Oops. We hit the API limit or some other problems occured.');
    }

    pageLoading(false);
  }

  // Like Recipe
  void likeRecipe(String label, String image) async {
    bool result = await DbService.saveLike(recipeID!, label, image);

    if (result) {
      recipeLiked(true);

      // refresh favorites page
      Get.find<FavoritesController>().pagingController.refresh();
    } else {
      kToast(message: "Something went wrong.");
    }
  }

  // Remove Like
  void unlikeRecipe() async {
    bool result = await DbService.removeLike(recipeID!);

    if (result) {
      recipeLiked(false);

      // refresh favorites page
      Get.find<FavoritesController>().pagingController.refresh();
    } else {
      kToast(message: "Something went wrong.");
    }
  }
}
