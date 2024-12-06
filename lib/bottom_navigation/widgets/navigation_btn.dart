import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class NavigationBtn extends StatelessWidget {
  const NavigationBtn(
      {super.key,
      required this.icon,
      required this.text,
      required this.index,
      required this.currentIndex,
      required this.onPressed});
  final IconData icon;
  final String text;
  final int index;
  final int currentIndex;
  final Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: TextButton(
        onPressed: () {
          onPressed(index);
        },
        child: Container(
          padding: EdgeInsets.all(TDeviceUtils.getScreenWidth(context) * .02),
          decoration: (currentIndex == index)
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(TSizes.borderRadiusXL),
                  border: Border.all(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    width: TDeviceUtils.getScreenWidth(context) * .003,
                  ),
                )
              : null,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                icon,
                color: TColors.white,
                size: TDeviceUtils.getScreenWidth(context) * .05,
              ),
              if (currentIndex == index)
                const SizedBox(
                  width: TSizes.sm,
                ),
              if (currentIndex == index)
                Animate(
                  effects: const [
                    FadeEffect(),
                    SlideEffect(
                        delay: Duration(microseconds: 200),
                        begin: Offset(-.4, 0))
                  ],
                  child: SizedBox(
                    width: TDeviceUtils.getScreenWidth(context) * .15,
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      textScaler: TextScaler.linear(ScaleSize.textScaleFactor(
                          context,
                          maxTextScaleFactor: 4)),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelSmall!.apply(
                            color: TColors.white,
                          ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
