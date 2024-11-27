import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/bottom_navigation/controller/navigation_controller.dart';
import 'package:tsavaari/bottom_navigation/widgets/floating_button.dart';
import 'package:tsavaari/bottom_navigation/widgets/navigation_container.dart';

class BottomNavigationMenu extends StatelessWidget {
  const BottomNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            controller.screens[controller.selectedIndex.value],
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: NavigationContainer(
                currentIndex: controller.selectedIndex.value,
                onPressed: (index) {
                  controller.onDestinationSelectionChange(index);
                },
              ),
            ),
            const FloatingButton(),
          ],
        ),
      ),
    );
  }
}
