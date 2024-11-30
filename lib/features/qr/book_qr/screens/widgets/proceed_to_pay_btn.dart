import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/book_qr_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class ProceedToPayBtn extends StatelessWidget {
  const ProceedToPayBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bookQrController = BookQrController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(
              () => Checkbox(
                value: bookQrController.termsAndConditions.value,
                onChanged: (value) => bookQrController.termsAndConditions
                    .value = !bookQrController.termsAndConditions.value,
              ),
            ),
            Row(
              children: [
                Text(
                  'I Agree to these',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(left: TSizes.sm),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: dark ? TColors.accent : TColors.primary,
                            width: 1),
                      ),
                    ),
                    child: SizedBox(
                      width: TDeviceUtils.getScreenWidth(context) * .32,
                      child: Text(
                        maxLines: 1,
                        'Terms & Conditions',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                              color: dark ? TColors.accent : TColors.primary,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        Obx(
          () => ElevatedButton(
            onPressed: bookQrController.termsAndConditions.value
                ? () {
                    bookQrController.generateTicket();
                  }
                : null,
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: TColors.grey,
              padding: const EdgeInsets.symmetric(
                horizontal: TSizes.defaultSpace,
                vertical: TSizes.defaultSpace / 2,
              ),
              side: const BorderSide(color: TColors.accent),
            ),
            child: Text(
              'Proceed to Pay  \u{20B9}${bookQrController.passengerCount.value * bookQrController.qrFareData.first.finalFare!}/-',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: bookQrController.termsAndConditions.value
                        ? TColors.light
                        : TColors.darkGrey,
                  ),
            ),
          ),
        ),
        const SizedBox(
          height: TSizes.defaultSpace,
        )
      ],
    );
  }
}
