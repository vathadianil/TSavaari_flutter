import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class SocialMediaPopup extends StatelessWidget {
  const SocialMediaPopup({super.key});

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
        height: 300,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Thanks',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),
                Text(
                  'for traveling with us',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                Text(
                  'For more information follow us on',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections / 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      width: TSizes.iconLg,
                      TImages.linkedin,
                    ),
                    Image.asset(
                      width: TSizes.iconLg,
                      TImages.facebook,
                    ),
                    Image.asset(
                      width: TSizes.iconLg,
                      TImages.instagram,
                    ),
                    Image.asset(
                      width: TSizes.iconLg,
                      TImages.twitter,
                    ),
                    Image.asset(
                      width: TSizes.iconLg,
                      TImages.youtube,
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
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
