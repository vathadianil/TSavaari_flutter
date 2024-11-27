import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/book_qr_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class TicketCountSelection extends StatelessWidget {
  const TicketCountSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = BookQrController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Iconsax.people5,
              color: dark ? TColors.accent : TColors.primary,
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems / 2,
            ),
            Text('Passengers', style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
        Obx(
          () => Row(
            children: [
              ElevatedButton(
                onPressed: controller.passengerCount.value <= 1
                    ? null
                    : () {
                        controller.passengerCount.value--;
                      },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  minimumSize: const Size(TSizes.xl * 1.2, TSizes.xl),
                ),
                child: const Icon(Iconsax.minus),
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems / 2,
              ),
              Text(controller.passengerCount.value.toString(),
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(
                width: TSizes.spaceBtwItems / 2,
              ),
              ElevatedButton(
                onPressed: controller.passengerCount.value >= 6
                    ? null
                    : () {
                        controller.passengerCount.value++;
                      },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  minimumSize: const Size(TSizes.xl * 1.2, TSizes.xl),
                ),
                child: const Icon(Iconsax.add),
              ),
            ],
          ),
        )
      ],
    );
  }
}
