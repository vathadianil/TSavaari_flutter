import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screen_brightness/screen_brightness.dart';

class DisplayQrController extends GetxController {
  static DisplayQrController get instance => Get.find();

  //variables
  final pageController = PageController();
  final isLoading = false.obs;
  final carouselCurrentIndex = 0.obs;
  final disbleScroll = false.obs;

  @override
  void onInit() {
    super.onInit();
    // changeBrightness();
  }

  @override
  void onClose() {
    super.onClose();
    resetScreenBrightness();
  }

  //Update page navigation dots
  void updatePageIndicator(index, itemsLength) {
    carouselCurrentIndex.value = index;
  }

  void changeBrightness() async {
    final brightness = await ScreenBrightness.instance.application;
    if (brightness < 1) {
      await ScreenBrightness.instance.setApplicationScreenBrightness(1);
    }
  }

  void resetScreenBrightness() async {
    await ScreenBrightness.instance.resetApplicationScreenBrightness();
  }
}
