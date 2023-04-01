import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes/app/utils/constants/sizer.dart';

class EmptyIconContent extends StatelessWidget {
  final IconData icon;
  final String text;

  const EmptyIconContent({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Get.height / 3.5,
          height: Get.height / 3.5,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(Get.width),
          ),
          child: Icon(
            icon,
            size: Get.height / 8,
          ),
        ),
        SizedBox(height: kHeight30),
        Text(
          text,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
