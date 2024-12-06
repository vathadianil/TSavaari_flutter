import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/bottom_navigation/controller/navigation_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
    required this.onTap,
  });
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    final controller = NavigationController.instance;
    final isDark = THelperFunctions.isDarkMode(context);
    return Obx(
      () => Positioned(
        top: controller.top.value,
        right: controller.right.value,
        child: GestureDetector(
          onPanUpdate: (details) {
            controller.right.value =
                max(0, controller.right.value - details.delta.dx);

            controller.top.value =
                max(0, controller.top.value + details.delta.dy);
          },
          onTap: onTap,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                color: isDark ? TColors.dark : TColors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: const [
                  BoxShadow(color: TColors.darkGrey, blurRadius: TSizes.lg)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Iconsax.ticket),
                Text(
                  'New',
                  style: Theme.of(context).textTheme.labelSmall,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
