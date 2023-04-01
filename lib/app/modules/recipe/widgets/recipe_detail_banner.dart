import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes/app/utils/constants/photo_cache_size.dart';
import 'package:recipes/app/utils/constants/sizer.dart';
import 'package:recipes/app/widgets/other/shimmer.dart';

class RecipeDetailBanner extends StatelessWidget {
  final String imageUrl;

  const RecipeDetailBanner({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kHeight220,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            memCacheWidth: PhotoCacheSize.recipePhotoBig,
            memCacheHeight: PhotoCacheSize.recipePhotoBig,
            fit: BoxFit.cover,
            placeholder: (context, _) => Shimmer(
              width: Get.width,
              height: kHeight220,
              radius: 0,
            ),
          ),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: kWidth10, sigmaY: kHeight10),
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  memCacheWidth: PhotoCacheSize.recipePhotoBig,
                  memCacheHeight: PhotoCacheSize.recipePhotoBig,
                  imageBuilder: (context, imageProvider) => Container(
                    width: kHeight180,
                    height: kHeight180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(kWidth10)),
                      image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
