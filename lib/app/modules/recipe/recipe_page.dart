import 'package:recipes/app/modules/recipe/recipe_controller.dart';
import 'package:recipes/app/modules/recipe/widgets/recipe_detail_banner.dart';
import 'package:recipes/app/widgets/other/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:recipes/app/utils/constants/sizer.dart';
import 'package:recipes/app/widgets/page/loading_page.dart';
import 'package:share_plus/share_plus.dart';

class RecipePage extends StatelessWidget {
  final controller = Get.put(RecipeController(), tag: Get.currentRoute);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        actions: [
          // Share Button
          Obx(
            () => controller.recipeDetails.value.url != null
                ? IconButton(
                    onPressed: () => Share.share(
                      controller.recipeDetails.value.url!,
                      sharePositionOrigin: Rect.fromLTWH(0, 0, Get.width, Get.height / 2), // for ipads
                    ),
                    icon: Icon(
                      FontAwesomeIcons.share,
                      size: kHeight20,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          // Like / Unlike Button
          Obx(
            () => controller.pageLoading.isFalse
                ? IconButton(
                    onPressed: () => controller.recipeLiked.isFalse ? controller.likeRecipe(controller.recipeDetails.value.label!, controller.recipeDetails.value.image!) : controller.unlikeRecipe(),
                    icon: controller.recipeLiked.isTrue
                        ? Icon(
                            FontAwesomeIcons.solidHeart,
                            size: kHeight20,
                            color: Colors.red,
                          )
                        : Icon(
                            FontAwesomeIcons.heart,
                            size: kHeight20,
                          ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      body: Obx(
        () => controller.pageLoading.isTrue
            ? LoadingPage()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // banner
                    RecipeDetailBanner(imageUrl: controller.recipeDetails.value.image!),
                    SizedBox(height: kHeight15),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // recipe name
                          Center(
                            child: Text(
                              controller.recipeDetails.value.label!,
                              style: Theme.of(context).textTheme.titleLarge,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: kHeight10),
                          // recipe ingredients
                          Text(
                            "Ingredients",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(height: kHeight8),
                          ...List.generate(
                            controller.recipeDetails.value.ingredients!.length,
                            (index) => Text(controller.recipeDetails.value.ingredients![index].food!),
                          ),
                          SizedBox(height: kHeight15),
                          // recipe instructions (ingredient lines)
                          Text(
                            "Instructions",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(height: kHeight8),
                          ...List.generate(
                            controller.recipeDetails.value.ingredientLines!.length,
                            (index) => Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${index + 1}. ",
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: controller.recipeDetails.value.ingredientLines![index],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: kHeight15),
                          // health labels
                          Text(
                            "Health",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(height: kHeight8),
                          Wrap(
                            children: List.generate(
                              controller.recipeDetails.value.healthLabels!.length,
                              (i) => Padding(
                                padding: EdgeInsets.only(right: kWidth5, bottom: kHeight5),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.surface,
                                    borderRadius: BorderRadius.circular(kWidth20),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: kWidth12, vertical: kHeight5),
                                    child: Text(
                                      controller.recipeDetails.value.healthLabels![i],
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: kHeight25),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
