import 'package:recipes/app/data/model/recipe_results_model.dart';
import 'package:recipes/app/data/model/search_history_model.dart';
import 'package:recipes/app/data/services/db_service.dart';
import 'package:recipes/app/utils/helpers/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:recipes/app/data/provider/api_v1.dart';

class SearchController extends GetxController {
  ApiClient apiClient = ApiClient();

  var focusNode = FocusNode();
  var textFieldController = TextEditingController();

  var searchQuery = "".obs;
  var selectedFilter = Rxn<String>(); // health filter index
  var nextPageParameter = Rxn<String>(); // _cont parameter

  final PagingController<int, RecipeResultModel> pagingController = PagingController(firstPageKey: 1);
  var searchHistoryList = List<SearchHistoryModel>.empty(growable: true).obs;

  Worker? searchDebounce;

  @override
  void onInit() {
    // wait 750ms after typing
    searchDebounce = debounce(searchQuery, (_) {
      pagingController.refresh();
    }, time: const Duration(milliseconds: 750));

    pagingController.addPageRequestListener((page) {
      search(page: page);
    });

    super.onInit();
  }

  Future<void> search({int page = 1}) async {
    // query is not empty
    if (searchQuery.value != "") {
      // Save query to history
      DbService.saveSearch(searchQuery.value);

      var result = await apiClient.search(searchQuery.value, selectedFilter.value, nextPageParameter.value);
      nextPageParameter.value = null; // reset next page parameter after result

      if (result != null) {
        if (result.hits != null) {
          // result length is equal "to", so it should be last page
          if (result.to! == result.count!) {
            pagingController.appendLastPage(result.hits!);
          } else {
            // next page
            Uri uri = Uri.parse(result.nextPageLink!);
            // _cont parameter is required for the next page (Edamam API documentation)
            nextPageParameter.value = uri.queryParameters['_cont']!;

            page++;
            pagingController.appendPage(result.hits!, page);
          }
        } else {
          // ! errors
          kToast(message: result.errors!.first.message!);
        }
      } else {
        // ! API IS DOWN
        kToast(message: 'Oops. We hit the API limit or some other problems occured.');
      }
    } else {
      // ! query is empty
      pagingController.error = "";

      getSearchHistory();
    }
  }

  Future<void> getSearchHistory() async {
    var result = await DbService.getSearchHistory();

    searchHistoryList.value = result;
  }

  Future<void> removeSearch(int id) async {
    await DbService.removeSearch(id);

    // Refresh search history
    getSearchHistory();
  }

  @override
  void onClose() {
    searchDebounce?.dispose();
    pagingController.dispose();
    super.onClose();
  }
}
