import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class TermsandConditionsPopup extends StatelessWidget {
  const TermsandConditionsPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      decoration: BoxDecoration(
        color:
            THelperFunctions.isDarkMode(context) ? TColors.dark : TColors.white,
        borderRadius: BorderRadius.circular(TSizes.md),
      ),
      child: SizedBox(
        height: 500,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Iconsax.book),
                    const SizedBox(
                      width: TSizes.sm,
                    ),
                    Text(
                      'Terms & Conditions',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                const Text(
                    '1) A Passenger can purchase maximum of 6 QR tickets at a time for group booking - seperate qr ticket will be generated for each memeber')
              ],
            ),
            Positioned(
              top: -10,
              right: -10,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Iconsax.close_circle),
                color: TColors.darkGrey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
