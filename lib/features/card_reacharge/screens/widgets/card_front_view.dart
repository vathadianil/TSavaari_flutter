import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class CardFrontView extends StatelessWidget {
  const CardFrontView({
    super.key,
    required this.cardHeight,
    required this.cardHolderName,
    required this.cardBalance,
    required this.cardNumber,
  });

  final double cardHeight;
  final String cardHolderName;
  final String cardBalance;
  final String cardNumber;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: cardHeight,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage(TImages.metroCardFrontside),
            ),
            borderRadius: BorderRadius.circular(TSizes.md),
            // color: isDark ? TColors.dark : TColors.light,
            boxShadow: [
              BoxShadow(
                blurRadius: TSizes.md,
                color: isDark ? TColors.accent : TColors.darkGrey,
              )
            ],
          ),
          child: Stack(
            children: [
              //-- Logo
              // const Positioned(
              //   left: TSizes.defaultSpace,
              //   top: TSizes.defaultSpace,
              //   child: CircleAvatar(
              //     backgroundColor: TColors.light,
              //     backgroundImage: AssetImage(TImages.appLogo),
              //   ),
              // ),

              //--Edit and Delete Icons
              Positioned(
                bottom: TSizes.sm,
                right: TSizes.sm,
                child: Row(
                  children: [
                    FloatingActionButton(
                      onPressed: () {},
                      mini: true,
                      shape: const CircleBorder(),
                      backgroundColor: TColors.white,
                      child: const Icon(
                        Iconsax.edit,
                        color: TColors.info,
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {},
                      mini: true,
                      shape: const CircleBorder(),
                      backgroundColor: TColors.white,
                      child: const Icon(
                        Iconsax.card_remove,
                        color: TColors.error,
                      ),
                    ),
                  ],
                ),
              ),

              //--Card Number
              Positioned(
                top: cardHeight / 1.8,
                left: TSizes.defaultSpace,
                child: Text(
                  cardNumber,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: TColors.light),
                ),
              ),

              //--  Card Balance & Recharge button
              Positioned(
                  top: (cardHeight / 2) -
                      (TSizes.spaceBtwSections + TSizes.spaceBtwItems),
                  right: TSizes.defaultSpace,
                  child: Row(
                    children: [
                      Text(
                        '\u{20B9} $cardBalance/-',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: TColors.light),
                      ),
                      const SizedBox(
                        width: TSizes.sm,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.success,
                          side: const BorderSide(color: TColors.white),
                          padding: const EdgeInsets.symmetric(
                            vertical: TSizes.xs,
                            horizontal: TSizes.sm,
                          ),
                          shadowColor: TColors.black,
                          elevation: TSizes.md,
                        ),
                        onPressed: () {},
                        child: Text(
                          'Top up',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: TColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ],
                  )),

              //--Card Validity
              Positioned(
                top: (cardHeight / 2) + (TSizes.defaultSpace * 1.8),
                left: TSizes.defaultSpace,
                child: Row(
                  children: [
                    Text(
                      'Validity :',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: TColors.light),
                    ),
                    const SizedBox(
                      width: TSizes.defaultSpace / 2,
                    ),
                    Text(
                      '24th Nov 2024',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: TColors.light),
                    ),
                  ],
                ),
              ),

              //-- Card Holder Name,
              Positioned(
                bottom: TSizes.defaultSpace,
                left: TSizes.defaultSpace,
                child: SizedBox(
                  width: 180,
                  child: Text(
                    cardHolderName,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: TColors.light),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
