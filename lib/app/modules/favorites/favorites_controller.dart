import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:recipes/app/data/model/favorite_model.dart';
import 'package:recipes/app/data/provider/api_v1.dart';
import 'package:recipes/app/data/services/db_service.dart';

class FavoritesController extends GetxController {
  ApiClient apiClient = ApiClient();

  final PagingController<int, FavoriteModel> pagingController = PagingController(firstPageKey: 1);

  // Pagination
  int limit = 10;
  var page = 0.obs;

  @override
  void onInit() {
    pagingController.addPageRequestListener((page) {
      getLikes();
    });

    super.onInit();
  }

  void getLikes() async {
    final result = await DbService.getLikes(limit, page.value * limit);

    if (result.length < limit) {
      // last page
      page.value = 0;
      pagingController.appendLastPage(result);
    } else {
      // next page
      page.value += 1;
      pagingController.appendPage(result, page.value);
    }
  }
}
