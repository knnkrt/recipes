import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:recipes/app/data/model/favorite_model.dart';
import 'package:recipes/app/data/services/db_service.dart';
import 'package:recipes/app/modules/favorites/favorites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes/app/routes/app_routes.dart';
import 'package:recipes/app/utils/constants/sizer.dart';
import 'package:recipes/app/utils/helpers/toast.dart';
import 'package:recipes/app/widgets/cards/favorite_card.dart';
import 'package:recipes/app/widgets/other/custom_scrollbar.dart';
import 'package:recipes/app/widgets/other/empty_icon_content.dart';
import 'package:recipes/app/widgets/page/loading_page.dart';

class FavoritesPage extends StatelessWidget {
  final controller = Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      body: CustomScrollbar(
        child: PagedListView<int, FavoriteModel>(
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate<FavoriteModel>(
            itemBuilder: (context, item, index) {
              // Get "Favorites" results
              return Column(
                children: [
                  if (index == 0) SizedBox(height: kHeight10),
                  Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                          child: const Icon(
                            FontAwesomeIcons.trash,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      bool result = await DbService.removeLike(item.recipeId!);

                      if (result) {
                        // Remove from list
                        controller.pagingController.itemList!.removeWhere((element) => element.id == item.id);

                        // Refresh list if itemList length 0
                        if (controller.pagingController.itemList?.length == 0) {
                          controller.pagingController.refresh();
                        }

                        return true;
                      } else {
                        kToast(message: "Something went wrong.");
                        return false;
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: kWidth5),
                      child: FavoriteCard(
                        label: item.label!,
                        image: item.image!,
                        onTap: () => Get.toNamed(AppRoutes.recipe + item.recipeId!),
                      ),
                    ),
                  ),
                ],
              );
            },
            firstPageErrorIndicatorBuilder: (context) => const SizedBox.shrink(),
            firstPageProgressIndicatorBuilder: (context) => LoadingPage(),
            newPageProgressIndicatorBuilder: (context) => LoadingPage(),
            newPageErrorIndicatorBuilder: (context) => const SizedBox.shrink(),
            noItemsFoundIndicatorBuilder: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                EmptyIconContent(
                  icon: FontAwesomeIcons.heart,
                  text: "No Favorite Recipe",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
