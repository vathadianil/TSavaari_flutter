import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/common/controllers/checkbox_controller.dart';
import 'package:tsavaari/features/card_reacharge/controllers/amounts_scroll_controller.dart';
import 'package:tsavaari/features/card_reacharge/controllers/metro_card_controller.dart';
import 'package:tsavaari/features/card_reacharge/models/nebula_card_validation_model.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/proceed_to_pay_btn.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/bottom_sheet_pageview_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class ConfirmTopup extends StatelessWidget {
  const ConfirmTopup({
    super.key,
    required this.cardDetails,
  });
  final NebulaCardValidationModel cardDetails;
  @override
  Widget build(BuildContext context) {
    Get.put(CheckBoxController());
    final cardController = MetroCardController.instance;
    return ListView(
      shrinkWrap: true,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  BottomSheetPageViewController.instace.firstPage(context);
                  Get.delete<CheckBoxController>();
                  Get.delete<AmountsScrollController>();
                },
                icon: const Icon(Iconsax.arrow_left)),
            const SizedBox(
              width: TSizes.md,
            ),
            Text('Topup Details',
                textScaler: TextScaleUtil.getScaledText(context),
                style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Card Current Balance',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              '${TTexts.rupeeSymbol}${cardDetails.currentBalance}/-',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        const Divider(),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Top Up Amount',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              '${TTexts.rupeeSymbol}${cardController.selectedTopupAmount}/-',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        const Divider(),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              THelperFunctions.getFormattedDateTime1(DateTime.now()),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        const Divider(),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        ListTile(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(TSizes.borderRadiusLg)),
          tileColor: TColors.info.withOpacity(.1),
          leading: const Icon(
            Iconsax.info_circle,
            color: TColors.primary,
          ),
          subtitle: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text:
                      'For the recharge amount to be reflected in your smart card, Please tap your smart card at',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: TColors.primary),
                ),
                TextSpan(
                  text: ' Entry Gates ',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.bold, color: TColors.primary),
                ),
                TextSpan(
                  text: 'or use prepaid option at',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: TColors.primary),
                ),
                TextSpan(
                  text: ' AVM/TVM ',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.bold, color: TColors.primary),
                ),
                TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: TColors.primary),
                    text:
                        'machines after 20 minutes of successful online recharge. In case smart card is not tapped with in 15 days of successful onlien recharge, the recharge amount will be automatically refunded to the respective account after 15 wroking days of the succesful online recharge'),
              ],
            ),
          ),
        ),
        ProceedToPayBtn(btnText: 'Proceed to Pay', onPressed: () {}),
      ],
    );
  }
}
