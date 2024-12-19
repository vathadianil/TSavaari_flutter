import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/features/card_reacharge/models/card_trx_details_model.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class CardTopupHistory extends StatelessWidget {
  const CardTopupHistory({
    super.key,
    required this.cardPaymentTrxData,
  });

  final CardTrxListModel cardPaymentTrxData;

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
                  color: cardPaymentTrxData.transactionStatus == '34'
                      ? TColors.grey
                      : TColors.dark,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(
                  cardPaymentTrxData.transactionStatus == '34'
                      ? Iconsax.tick_circle
                      : Iconsax.repeat_circle,
                  color: cardPaymentTrxData.transactionStatus == '34'
                      ? TColors.success
                      : TColors.secondary,
                ),
              ),
              const SizedBox(
                height: TSizes.sm,
              ),
              //-- Amount
              Text('+${cardPaymentTrxData.addedValue}/-',
                  style: Theme.of(context).textTheme.titleLarge),
              Text(
                cardPaymentTrxData.transactionStatus == '34'
                    ? 'Success'
                    : 'Pending',
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
                  cardPaymentTrxData.merchantTransactionID ?? '',
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
                      THelperFunctions.getFormattedDateTimeString1(
                        cardPaymentTrxData.transactionDateTime!,
                      ),
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
