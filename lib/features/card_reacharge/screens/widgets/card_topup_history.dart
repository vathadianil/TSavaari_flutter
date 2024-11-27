import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/features/card_reacharge/controllers/metro_card_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class CardTopupHistory extends StatelessWidget {
  const CardTopupHistory({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final cardController = MetroCardController.instance;
    final isDark = THelperFunctions.isDarkMode(context);
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: TSizes.md,
            vertical: TSizes.xl,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(TSizes.md),
            color: isDark ? TColors.dark : TColors.light,
            border: Border.all(
              width: 1,
              color: isDark ? TColors.darkerGrey : TColors.grey,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: index == 0 ? TColors.dark : TColors.grey,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(
                  index == 0 ? Iconsax.repeat_circle : Iconsax.tick_circle,
                  color: index == 0 ? TColors.secondary : TColors.success,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Id:',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: TSizes.sm,
                  ),
                  SizedBox(
                    width: TDeviceUtils.getScreenWidth(context) * .4,
                    child: Row(
                      children: [
                        Text(
                          '1354XXXX3333',
                          style: Theme.of(context).textTheme.bodyLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(width: TSizes.sm),
                        InkWell(
                          onTap: () {
                            cardController.copyTextToClipboard('2324324324324');
                          },
                          child: const Icon(
                            Iconsax.copy,
                            size: TSizes.md,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text('+200/-', style: Theme.of(context).textTheme.titleLarge),
                  Text(
                    index == 0 ? 'Pending' : 'Success',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: TSizes.sm,
          right: TSizes.defaultSpace,
          child: Text(
            '24-Nov-2024 11:22:24 AM',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ],
    );
  }
}
