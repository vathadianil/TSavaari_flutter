import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
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
            color: isDark ? TColors.accent : TColors.darkGrey,
          )
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            //--Logo
            Positioned(
                top: constraints.maxWidth * .1,
                left: constraints.maxWidth * .1,
                child: CircleAvatar(
                  radius: constraints.maxWidth * .09,
                  backgroundColor: TColors.white,
                  backgroundImage: const AssetImage(TImages.appLogo),
                )),

            //--Edit and Delete Icons
            Positioned(
              top: constraints.maxWidth * .02,
              right: constraints.maxWidth * .05,
              child: Row(
                children: [
                  FloatingActionButton(
                    heroTag: "edit-btn$cardNumber",
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
                    heroTag: "remove-btn$cardNumber",
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
              top: constraints.maxHeight * .55,
              left: constraints.maxWidth * .05,
              child: Text(
                cardNumber,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),

            //--  Recharge button
            Positioned(
              top: constraints.maxHeight * .3,
              right: constraints.maxWidth * .05,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: TColors.success,
                  side: const BorderSide(color: TColors.white),
                  padding: const EdgeInsets.symmetric(
                    vertical: TSizes.xs,
                    horizontal: TSizes.md,
                  ),
                  elevation: TSizes.sm,
                ),
                onPressed: () {},
                child: Text(
                  'Top up',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: TColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),

            //--Card Holder Name, Card Balance & Card Validity
            Positioned(
              top: constraints.maxHeight * .7,
              left: constraints.maxWidth * .05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //-- Card Holder Name
                  SizedBox(
                    width: constraints.maxWidth * .28,
                    child: Text(
                      cardHolderName.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                      // maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * .7,
                    child: Row(
                      children: [
                        //-- Balance
                        Column(
                          children: [
                            Text(
                              '\u{20B9} $cardBalance/-',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              'Balance',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: constraints.maxWidth * .01,
                        ),
                        //-- Horizontal divider
                        Container(
                          height: 50,
                          decoration: const BoxDecoration(
                            border: Border(
                              left:
                                  BorderSide(color: TColors.darkGrey, width: 2),
                            ),
                          ),
                        ),

                        SizedBox(
                          width: constraints.maxWidth * .01,
                        ),
                        //-- Validity
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '08/11/24',
                              style: Theme.of(context).textTheme.bodyLarge!,
                            ),
                            Text(
                              'Validity',
                              style: Theme.of(context).textTheme.labelSmall,
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
    );
  }
}
