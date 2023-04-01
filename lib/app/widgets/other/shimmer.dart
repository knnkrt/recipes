import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Shimmer extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  final Color? color;

  const Shimmer({
    Key? key,
    required this.height,
    required this.width,
    required this.radius,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color ?? (Get.isDarkMode ? const Color(0xff1c1c1c) : Colors.grey.shade300),
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
    );
  }
}
