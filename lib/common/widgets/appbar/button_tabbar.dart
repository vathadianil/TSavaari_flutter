import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/controllers/button_tabbar_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class ButtonTabbar extends StatelessWidget {
  const ButtonTabbar({
    super.key,
    required this.buttonTexts,
    required this.onTap,
  });

  final List<String> buttonTexts;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final controller = ButtonTabbarController.instance;
    final isDark = THelperFunctions.isDarkMode(context);
    return SizedBox(
      height: TSizes.xl,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: TColors.darkGrey,
          ),
          borderRadius: BorderRadius.circular(TSizes.md),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                onTap(index);
              },
              child: Obx(
                () => Container(
                  margin: const EdgeInsets.all(2),
                  padding: const EdgeInsets.symmetric(
                    horizontal: TSizes.md,
                    vertical: TSizes.sm / 2,
                  ),
                  decoration: BoxDecoration(
                    color: index == controller.tabIndex.value
                        ? isDark
                            ? TColors.light
                            : TColors.black
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(TSizes.md),
                  ),
                  child: Text(
                    buttonTexts[index],
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: index == controller.tabIndex.value
                              ? isDark
                                  ? TColors.black
                                  : TColors.white
                              : isDark
                                  ? TColors.white
                                  : TColors.black,
                        ),
                  ),
                ),
              ),
            );
          },
          itemCount: buttonTexts.length,
        ),
      ),
    );
  }
}
