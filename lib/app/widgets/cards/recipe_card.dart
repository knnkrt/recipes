import 'package:recipes/app/utils/constants/photo_cache_size.dart';
import 'package:recipes/app/utils/constants/sizer.dart';
import 'package:recipes/app/widgets/other/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final String label;
  final String image;
  final String source;
  final GestureTapCallback onTap;

  const RecipeCard({
    Key? key,
    required this.label,
    required this.image,
    required this.source,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kWidth16, vertical: kHeight8),
        child: InkWell(
          onTap: onTap,
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: image,
                memCacheWidth: PhotoCacheSize.recipePhotoMedium,
                memCacheHeight: PhotoCacheSize.recipePhotoMedium,
                imageBuilder: (context, imageProvider) => Container(
                  height: kWidth90,
                  width: kWidth90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(kWidth10)),
                    image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, __) => Shimmer(
                  height: kWidth90,
                  width: kWidth90,
                  radius: kWidth10,
                ),
              ),
              SizedBox(width: kWidth12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 2,
                    ),
                    SizedBox(height: kHeight5),
                    Chip(
                      label: Text(
                        source,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      labelPadding: EdgeInsets.symmetric(vertical: kHeight1, horizontal: kWidth3),
                    ),
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
