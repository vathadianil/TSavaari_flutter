import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
// import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
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
            // image: const DecorationImage(
            //   image: AssetImage(TImages.metroCardFrontside),
            //   fit: BoxFit.cover,
            // ),
            borderRadius: BorderRadius.circular(TSizes.md),
            color: isDark ? TColors.dark : TColors.light,
            boxShadow: [
              BoxShadow(
                blurRadius: TSizes.md,
                color: isDark ? TColors.accent : TColors.darkGrey,
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
              //--Edit and Delete Icons
              Positioned(
                // bottom: TSizes.sm,
                // right: TSizes.sm,
                top: TSizes.defaultSpace,
                right: TSizes.defaultSpace,
                child: Row(
                  children: [
                    FloatingActionButton(
                      heroTag: "edit-btn",
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
                      heroTag: "remove-btn",
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
                // top: cardHeight * .35,
                top: cardHeight * .5,
                left: TSizes.defaultSpace,
                child: Text(
                  cardNumber,
                  // style: Theme.of(context)
                  //     .textTheme
                  //     .headlineMedium!
                  //     .copyWith(color: TColors.primary),
                  style: Theme.of(context).textTheme.headlineSmall!,
                ),
              ),

              //--  Recharge button
              Positioned(
                top: cardHeight * .4,
                // right: TDeviceUtils.getScreenWidth(context) * .15,
                right: TSizes.defaultSpace,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.success,
                    side: const BorderSide(color: TColors.white),
                    padding: const EdgeInsets.symmetric(
                      vertical: TSizes.xs,
                      horizontal: TSizes.md,
                    ),
                    shadowColor: TColors.black,
                    elevation: TSizes.md,
                  ),
                  onPressed: () {},
                  child: Row(
                    children: [
                      const Icon(
                        Iconsax.money_add,
                        size: TSizes.iconSm,
                        color: TColors.white,
                      ),
                      const SizedBox(
                        width: TSizes.sm / 2,
                      ),
                      Text(
                        'Top up',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: TColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ),

              //--Card Holder Name, Card Balance & Card Validity
              Positioned(
                top: cardHeight * .7,
                left: TSizes.defaultSpace,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //-- Card Holder Name
                    SizedBox(
                      width: TDeviceUtils.getScreenWidth(context) * .3,
                      child: Text(
                        cardHolderName,
                        style: Theme.of(context).textTheme.headlineSmall!,
                        // .copyWith(color: TColors.primary),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: TDeviceUtils.getScreenWidth(context) * .6,
                      child: Row(
                        children: [
                          //-- Balance
                          Column(
                            children: [
                              Text(
                                '\u{20B9} $cardBalance/-',
                                style: Theme.of(context).textTheme.bodyLarge!,
                                // .copyWith(color: TColors.secondary),
                              ),
                              Text(
                                'Balance',
                                style: Theme.of(context).textTheme.bodyLarge!,
                                // .copyWith(
                                //   color: TColors.secondary,
                                // ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: TSizes.sm,
                          ),
                          //-- Horizontal divider
                          Container(
                            height: 50,
                            decoration: const BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                    color: TColors.darkGrey, width: 2),
                              ),
                            ),
                          ),

                          const SizedBox(
                            width: TSizes.sm,
                          ),
                          //-- Validity
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '08/11/24',
                                style: Theme.of(context).textTheme.bodyLarge!,
                                //     .copyWith(
                                //   color: TColors.secondary,
                                //   shadows: [
                                //     const BoxShadow(
                                //       color: TColors.black,
                                //       blurRadius: TSizes.md,
                                //     ),
                                //   ],
                                // ),
                              ),
                              Text(
                                'Validity',
                                style: Theme.of(context).textTheme.bodyLarge!,
                                //     .copyWith(
                                //   color: TColors.secondary,
                                //   shadows: [
                                //     const BoxShadow(
                                //       color: TColors.black,
                                //       blurRadius: TSizes.md,
                                //     )
                                //   ],
                                // ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
