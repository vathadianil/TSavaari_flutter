import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/bottom_sheet_pageview_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class BottomSheetMainPage extends StatelessWidget {
  const BottomSheetMainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'We are here to help!',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: THelperFunctions.isDarkMode(context)
                  ? TColors.accent
                  : TColors.primary,
            ),
            borderRadius: BorderRadius.circular(
              TSizes.md,
            ),
          ),
          child: ListTile(
            onTap: () {
              BottomSheetPageViewController.instace
                  .changeDesitinationPage(context);
            },
            leading: Icon(
              Iconsax.location,
              color: THelperFunctions.isDarkMode(context)
                  ? TColors.accent
                  : TColors.primary,
            ),
            title: Text(
              'Change Destination',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: THelperFunctions.isDarkMode(context)
                      ? TColors.accent
                      : TColors.primary),
            ),
            subtitle: Text(
              'Want to change your destination station?. Press here.',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: TColors.error),
            borderRadius: BorderRadius.circular(TSizes.md),
          ),
          child: ListTile(
            onTap: () {
              BottomSheetPageViewController.instace.refundPage(context);
            },
            leading: const Icon(
              Iconsax.ticket,
              color: TColors.error,
            ),
            title: Text(
              'Cancel Ticket',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: TColors.error),
            ),
            subtitle: Text(
              'Want to Canel your Journey!. Press here for Refund.',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      ],
    );
  }
}
