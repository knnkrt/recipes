import 'package:get/get.dart';
import 'package:recipes/app/utils/constants/sizer.dart';

class PhotoCacheSize {
  // These are for memory usage control while loading images
  static final recipePhotoBig = (kHeight180 * Get.pixelRatio).ceil();
  static final recipePhotoMedium = (kWidth90 * Get.pixelRatio).ceil();
}
