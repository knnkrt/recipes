import 'package:recipes/app/data/model/recipe_results_model.dart';
import 'package:recipes/app/routes/app_routes.dart';
import 'package:recipes/app/utils/constants/health_labels.dart';
import 'package:recipes/app/utils/extensions/parser_extension.dart';
import 'package:recipes/app/utils/helpers/bottomsheet.dart';
import 'package:recipes/app/widgets/buttons/primary_button.dart';
import 'package:recipes/app/widgets/cards/recipe_card.dart';
import 'package:recipes/app/widgets/cards/search_history_card.dart';
import 'package:recipes/app/widgets/other/custom_back_button.dart';
import 'package:recipes/app/widgets/other/custom_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:recipes/app/modules/search/search_controller.dart';
import 'package:recipes/app/utils/constants/sizer.dart';
import 'package:recipes/app/widgets/page/loading_page.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final controller = Get.put(SearchPageController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.focusNode.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: const CustomBackButton(),
          title: SizedBox(
            height: kHeight40,
            // Search form
            child: TextFormField(
              autofocus: true,
              focusNode: controller.focusNode,
              controller: controller.textFieldController,
              onChanged: (value) => controller.searchQuery.value = value.trim(),
              style: TextStyle(
                fontSize: kFontSize14,
                color: Colors.black,
              ),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(
                  fontSize: kFontSize14,
                  color: Colors.black,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: kWidth8),
                  child: Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: kFontSize15,
                  ),
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    controller.textFieldController.clear(); // clear form
                    controller.searchQuery.value = ""; // clear query
                  },
                  child: Padding(
                    padding: EdgeInsets.all(kWidth5),
                    child: Icon(
                      Icons.close,
                      size: kFontSize18,
                    ),
                  ),
                ),
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(kWidth8))),
              ),
            ),
          ),
          actions: [
            // Filter
            IconButton(
              onPressed: () => kBottomSheet(
                context: context,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: kHeight5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Filter",
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ),
                            // Clear filters button
                            InkWell(
                              onTap: () {
                                Get.back(); // close bottomsheet
                                controller.selectedFilter.value = null; // reset
                                controller.pagingController.refresh();
                              },
                              child: Chip(
                                label: Row(
                                  children: [
                                    Text(
                                      "Clear",
                                      style: TextStyle(
                                        fontSize: kFontSize12,
                                      ),
                                    ),
                                    SizedBox(width: kWidth8),
                                    Icon(
                                      FontAwesomeIcons.x,
                                      size: kFontSize12,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: kHeight10),
                        Text(
                          "Health",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(height: kHeight10),
                        // Health labels
                        Obx(
                          () => Wrap(
                            children: List.generate(
                              healthLabels.length,
                              (i) => Padding(
                                padding: EdgeInsets.only(right: kWidth5, bottom: kHeight5),
                                child: GestureDetector(
                                  onTap: () {
                                    if (healthLabels[i] == controller.selectedFilter.value) {
                                      controller.selectedFilter.value = null; // reset if tapped again
                                    } else {
                                      controller.selectedFilter.value = healthLabels[i]; // set filter
                                    }
                                  },
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: healthLabels[i] == controller.selectedFilter.value ? Theme.of(context).colorScheme.primaryContainer : const Color(0xFFf7f7f7),
                                      borderRadius: BorderRadius.circular(kWidth20),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: kWidth12, vertical: kHeight5),
                                      child: Text(
                                        healthLabels[i],
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: kHeight10),
                        // Apply button
                        PrimaryButton(
                          text: "Apply",
                          onPressed: () {
                            Get.back(); // close bottomsheet
                            controller.pagingController.refresh();
                          },
                        ),
                        SizedBox(height: kHeight10),
                      ],
                    ),
                  ),
                ],
              ),
              icon: Icon(
                FontAwesomeIcons.filter,
                size: kFontSize22,
              ),
            )
          ],
        ),
        body: GestureDetector(
          onPanDown: (_) => controller.focusNode.unfocus(),
          child: CustomScrollbar(
            child: PagedListView<int, RecipeResultModel>(
              pagingController: controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate<RecipeResultModel>(
                itemBuilder: (context, item, index) {
                  // List results
                  return Column(
                    children: [
                      if (index == 0) SizedBox(height: kHeight10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: kWidth5),
                        child: RecipeCard(
                          label: item.label,
                          image: item.image,
                          source: item.source,
                          onTap: () => Get.toNamed(AppRoutes.recipe + item.uri.uriToID()),
                        ),
                      ),
                      if (index + 1 == controller.pagingController.itemList?.length) SizedBox(height: kHeight15),
                    ],
                  );
                },
                // Query is empty, show search history
                firstPageErrorIndicatorBuilder: (context) => Obx(
                  () => Column(
                    children: List.generate(
                      controller.searchHistoryList.length,
                      (index) => SearchHistoryCard(
                        query: controller.searchHistoryList[index].query!,
                        onTap: () {
                          // Set search query and search it.
                          controller.textFieldController.text = controller.searchHistoryList[index].query!;
                          controller.searchQuery.value = controller.searchHistoryList[index].query!;
                          controller.search();
                        },
                        onTapX: () => controller.removeSearch(controller.searchHistoryList[index].id!),
                      ),
                    ),
                  ),
                ),
                firstPageProgressIndicatorBuilder: (context) => const LoadingPage(),
                newPageProgressIndicatorBuilder: (context) => const LoadingPage(),
                newPageErrorIndicatorBuilder: (context) => const SizedBox.shrink(),
                noItemsFoundIndicatorBuilder: (context) => const Center(
                  child: Text("No results."),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
