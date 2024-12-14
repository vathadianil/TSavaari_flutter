import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class CardBackView extends StatelessWidget {
  const CardBackView({
    super.key,
    required this.cardHeight,
    required this.cardNumber,
  });

  final double cardHeight;
  final String cardNumber;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: screenWidth * .025,
      ),
      height: cardHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.md),
        color: isDark ? TColors.dark : TColors.light,
        boxShadow: [
          BoxShadow(
            blurRadius: TSizes.md,
            color: THelperFunctions.isDarkMode(context)
                ? TColors.accent
                : TColors.darkGrey,
          )
        ],
      ),
      child: Stack(
        children: [
          //--Logo
          const Positioned(
              top: TSizes.defaultSpace,
              left: TSizes.defaultSpace,
              child: CircleAvatar(
                backgroundColor: TColors.white,
                backgroundImage: AssetImage(TImages.appLogo),
              )),

          //-- Reachage Heading
          Positioned(
            // top: cardHeight * .15,
            top: cardHeight * .4,
            // left: TSizes.defaultSpace / 2,
            left: TSizes.defaultSpace,
            child: SizedBox(
              width: 180,
              child: Text(
                'Last Rechage Info',
                style: Theme.of(context).textTheme.titleMedium!,
                // .copyWith(color: TColors.primary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          //--Last Recharge amount
          Positioned(
            // top: (cardHeight * .28),
            top: (cardHeight * .54),
            left: TSizes.defaultSpace,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Amount :',
                  style: Theme.of(context).textTheme.labelSmall!,
                  // .copyWith(color: TColors.primary),
                ),
                const SizedBox(
                  width: TSizes.xs,
                ),
                Text(
                  '\u{20B9} 200/-',
                  style: Theme.of(context).textTheme.bodyLarge!,
                  // .copyWith(color: TColors.primary),
                ),
                const SizedBox(
                  width: TSizes.xs,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: TSizes.sm,
                    vertical: TSizes.sm / 2,
                  ),
                  decoration: BoxDecoration(
                    color: TColors.success,
                    borderRadius: BorderRadius.circular(TSizes.lg),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Iconsax.tick_circle,
                        size: TSizes.md,
                        color: TColors.white,
                      ),
                      const SizedBox(
                        width: TSizes.xs,
                      ),
                      Text(
                        'Success',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: TColors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //--Last Recharge amount Date
          Positioned(
            // top: (cardHeight * .38),
            top: (cardHeight * .67),
            left: TSizes.defaultSpace,
            child: Row(
              children: [
                Text(
                  'Date :',
                  style: Theme.of(context).textTheme.labelSmall!,
                  // .copyWith(color: TColors.primary),
                ),
                const SizedBox(
                  width: TSizes.xs,
                ),
                Text(
                  '3rd Mar 2024 10:30 AM',
                  style: Theme.of(context).textTheme.bodyLarge!,
                  // .copyWith(color: TColors.primary),
                ),
              ],
            ),
          ),
          //--Card Number
          Positioned(
            bottom: TSizes.sm / 2,
            right: TSizes.defaultSpace,
            child: Text(
              cardNumber,
              style: Theme.of(context).textTheme.bodyLarge!,
              // .copyWith(color: TColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
