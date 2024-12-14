import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';

class CustomElevatedBtn extends StatelessWidget {
  const CustomElevatedBtn({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor = TColors.primary,
  });
  final Function()? onPressed;
  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(
            horizontal: TSizes.defaultSpace,
            vertical: TSizes.defaultSpace / 2,
          ),
          side: const BorderSide(color: TColors.accent),
        ),
        child: child);
  }
}