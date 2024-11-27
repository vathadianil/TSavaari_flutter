import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';
// import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';

class CarbonEmissionMessage extends StatelessWidget {
  const CarbonEmissionMessage({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // const CircleAvatar(
        //   backgroundImage: AssetImage(TImages.appLogo),
        //   backgroundColor: TColors.white,
        // ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        Expanded(
          child: Text(
            message,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: TColors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
