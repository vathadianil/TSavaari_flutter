import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetPageViewController extends GetxController {
  static BottomSheetPageViewController get instace => Get.find();

  ///Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  ///Update current Index when page scroll
  void updatePageIndicator(index) {
    currentPageIndex.value = index;
  }

  ///Update current Index and Jump to the next page
  void nextPage(BuildContext context) {
    int page = currentPageIndex.value + 1;
    pageController.jumpToPage(page);
  }

  ///Update current Index and Jump to the Previous page
  void previousPage(BuildContext context) {
    int page = currentPageIndex.value - 1;
    pageController.jumpToPage(page);
  }
}
