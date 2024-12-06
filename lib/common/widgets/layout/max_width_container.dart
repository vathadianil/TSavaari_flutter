import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/sizes.dart';

class MaxWidthContaiiner extends StatelessWidget {
  const MaxWidthContaiiner({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: TSizes.tabletSize),
      child: child,
    );
  }
}
