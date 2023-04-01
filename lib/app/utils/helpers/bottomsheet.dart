import 'package:recipes/app/utils/constants/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

kBottomSheet({
  required BuildContext context,
  required List<Widget> children,
}) {
  Get.bottomSheet(
    Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kWidth15),
          topRight: Radius.circular(kWidth15),
        ),
      ),
      child: SafeArea(
        child: Wrap(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: kHeight12, bottom: kHeight5),
                height: kHeight4,
                width: Get.width * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Get.width),
                  color: Theme.of(context).dividerColor,
                ),
                child: const SizedBox.shrink(),
              ),
            ),
            Wrap(children: children),
            Container(height: kHeight4),
          ],
        ),
      ),
    ),
    enterBottomSheetDuration: const Duration(milliseconds: 250),
    exitBottomSheetDuration: const Duration(milliseconds: 250),
    isScrollControlled: true,
    elevation: 0,
  );
}
