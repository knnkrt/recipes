import 'package:recipes/app/modules/front/front_controller.dart';
import 'package:recipes/app/utils/constants/sizer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class FrontPage extends StatelessWidget {
  final controller = Get.put(FrontController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Obx(
        () => Scaffold(
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: kHeight1,
                  blurRadius: kHeight3,
                  offset: Offset(0, kHeight3),
                ),
              ],
            ),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Theme.of(context).bottomAppBarTheme.color,
              selectedFontSize: kFontSize11,
              unselectedFontSize: kFontSize11,
              unselectedItemColor: Theme.of(context).disabledColor,
              selectedItemColor: Theme.of(context).primaryColor,
              selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
              currentIndex: controller.selectedItemIndex.value,
              type: BottomNavigationBarType.fixed,
              iconSize: kFontSize20,
              onTap: (index) {
                controller.addIndex(index);
                controller.selectedItemIndex.value = index;
              },
              items: [
                // Home Tab
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.symmetric(vertical: kHeight4),
                    child: const Icon(FontAwesomeIcons.house),
                  ),
                  label: "Home",
                ),
                // Favorites Tab
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.symmetric(vertical: kHeight4),
                    child: const Icon(FontAwesomeIcons.heart),
                  ),
                  label: "Favorites",
                ),
              ],
            ),
          ),
          body: IndexedStack(
            index: controller.selectedItemIndex.value,
            children: controller.pages,
          ),
        ),
      ),
      onWillPop: () => controller.onWillPop(),
    );
  }
}
