import 'dart:async';

import 'package:recipes/app/modules/favorites/favorites_page.dart';
import 'package:recipes/app/modules/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FrontController extends GetxController {
  var selectedItemIndex = 0.obs;

  List<int> indexes = [
    0
  ].obs;

  // navigate through the menus in order of menu history
  Future<bool> onWillPop() async {
    if (selectedItemIndex.value == 0) {
      return Future.value(true);
    } else {
      indexes.removeLast();
      selectedItemIndex.value = indexes.last;
      return Future.value(false);
    }
  }

  void addIndex(int index) {
    if (index == 0) indexes.clear();
    if (indexes.contains(index)) {
      indexes.remove(index);
    }
    indexes.add(index);
  }

  final List<Widget> pages = [
    HomePage(),
    FavoritesPage(),
  ];
}
