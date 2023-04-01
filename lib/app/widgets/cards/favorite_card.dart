import 'package:recipes/app/utils/constants/photo_cache_size.dart';
import 'package:recipes/app/utils/constants/sizer.dart';
import 'package:recipes/app/widgets/other/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FavoriteCard extends StatelessWidget {
  final String label;
  final String image;
  final GestureTapCallback onTap;

  const FavoriteCard({
    Key? key,
    required this.label,
    required this.image,
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
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
