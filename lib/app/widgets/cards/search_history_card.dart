import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipes/app/utils/constants/sizer.dart';
import 'package:flutter/material.dart';

class SearchHistoryCard extends StatelessWidget {
  final String query;
  final GestureTapCallback onTap;
  final GestureTapCallback onTapX;

  const SearchHistoryCard({
    Key? key,
    required this.query,
    required this.onTap,
    required this.onTapX,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kWidth16, vertical: kHeight6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SizedBox(
              width: double.maxFinite,
              child: InkWell(
                onTap: onTap,
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: kFontSize14,
                    ),
                    SizedBox(width: kWidth20),
                    Text(
                      query,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: onTapX,
            child: Padding(
              padding: EdgeInsets.all(kWidth6),
              child: Icon(
                FontAwesomeIcons.x,
                size: kFontSize11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
