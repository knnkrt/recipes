import 'package:recipes/app/utils/constants/sizer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomBackButton extends StatelessWidget {
  final Widget? icon;
  final GestureTapCallback? onPressed;

  const CustomBackButton({
    Key? key,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon ?? const FaIcon(FontAwesomeIcons.chevronLeft),
      iconSize: kFontSize20,
      onPressed: onPressed ?? () => Get.back(),
      padding: EdgeInsets.symmetric(horizontal: kWidth8, vertical: kHeight8),
    );
  }
}
