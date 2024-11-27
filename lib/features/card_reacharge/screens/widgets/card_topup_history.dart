import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
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
    final isDark = THelperFunctions.isDarkMode(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: TSizes.sm,
        vertical: TSizes.md,
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
        children: [
          Column(
            children: [
              //-- Indication Icon
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
              const SizedBox(
                height: TSizes.sm,
              ),
              //-- Amount
              Text('+200/-', style: Theme.of(context).textTheme.titleLarge),
              Text(
                index == 0 ? 'Pending' : 'Success',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
          const SizedBox(
            width: TSizes.md,
          ),
          //-- Order Id and Date
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
                width: TDeviceUtils.getScreenWidth(context) * .6,
                child: Text(
                  '123324354353556565464654645',
                  style: Theme.of(context).textTheme.bodyLarge,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 2,
                ),
              ),
              const SizedBox(
                height: TSizes.sm,
              ),
              Row(
                children: [
                  Text(
                    'Date : ',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(
                    width: 170,
                    child: Text(
                      '24-11-2024 11:22:24 AM',
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
