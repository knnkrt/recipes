import 'package:recipes/app/modules/favorites/favorites_page.dart';
import 'package:recipes/app/modules/front/front_page.dart';
import 'package:recipes/app/modules/recipe/recipe_page.dart';
import 'package:recipes/app/modules/search/search_page.dart';
import 'package:recipes/app/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage> pages = [
    // Front page (bottombar)
    GetPage(
      name: AppRoutes.front,
      page: () => FrontPage(),
    ),
    // Home page
    GetPage(
      name: AppRoutes.home,
      page: () => FrontPage(),
    ),
    // Search page
    GetPage(
      name: AppRoutes.search,
      page: () => SearchPage(),
    ),
    // Favorites page
    GetPage(
      name: AppRoutes.favorites,
      page: () => FavoritesPage(),
    ),
    // Recipe Details page
    GetPage(
      name: AppRoutes.recipe + ':recipe_id',
      page: () => RecipePage(),
    ),
  ];
}
