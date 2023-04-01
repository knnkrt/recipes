import 'package:recipes/app/utils/constants/sizer.dart';
import 'package:flutter/material.dart';

class CustomScrollbar extends StatelessWidget {
  final Widget child;

  const CustomScrollbar({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      thumbColor: Colors.black.withOpacity(0.4),
      radius: Radius.circular(kWidth15),
      thickness: kWidth3,
      interactive: false,
      child: child,
    );
  }
}
