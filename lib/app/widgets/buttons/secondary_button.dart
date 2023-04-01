import 'package:recipes/app/utils/constants/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final GestureTapCallback? onPressed;
  final double? width;

  const SecondaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: kWidth15, vertical: kHeight10),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.tertiaryContainer),
          side: MaterialStateProperty.all(BorderSide.none),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Get.width)))),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
