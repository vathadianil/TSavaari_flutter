import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/book_qr_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';

class ProceedToPayBtn extends StatelessWidget {
  const ProceedToPayBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bookQrController = BookQrController.instance;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: TSizes.defaultSpace / 2,
      ),
      child: ElevatedButton(
        onPressed: () {
          bookQrController.generateTicket(context);
        },
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: TSizes.defaultSpace,
              vertical: TSizes.defaultSpace / 2,
            ),
            side: const BorderSide(color: TColors.accent)),
        child: Obx(
          () => Text(
            'Proceed to Pay  \u{20B9}${bookQrController.passengerCount.value * bookQrController.qrFareData.first.finalFare!}/-',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: TColors.light,
                ),
          ),
        ),
      ),
    );
  }
}
