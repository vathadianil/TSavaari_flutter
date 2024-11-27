import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
          padding: const EdgeInsets.symmetric(
              horizontal: TSizes.sm, vertical: TSizes.sm / 2),
          decoration: (currentIndex == index)
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(TSizes.borderRadiusXL),
                  border: Border.all(color: TColors.white, width: 1),
                  // boxShadow: const [
                  //   BoxShadow(color: TColors.grey, blurRadius: TSizes.sm)
                  // ],
                  // color: TColors.white,
                )
              : null,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(icon, color: TColors.white
                  // (currentIndex == index) ? TColors.primary : TColors.white,
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
                    width: 45,
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelSmall!.apply(
                            // color: (currentIndex == index)
                            //     ? TColors.primary
                            //     : TColors.white,
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
