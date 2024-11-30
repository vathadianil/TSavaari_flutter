import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/book_qr_controller.dart';
import 'package:tsavaari/utils/constants/sizes.dart';

class DisplayFare extends StatelessWidget {
  const DisplayFare({super.key});

  @override
  Widget build(BuildContext context) {
    final bookQrController = BookQrController.instance;

    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(
          top: TSizes.defaultSpace,
          left: TSizes.defaultSpace,
          right: TSizes.defaultSpace,
        ),
        child: Column(
          children: [
            //--Display fare
            if (!bookQrController.isLoading.value)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Fare',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Row(
                        children: [
                          Text(
                            '${bookQrController.passengerCount.value} X ${bookQrController.qrFareData.first.finalFare.toString()} = ',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            width: TSizes.spaceBtwItems / 2,
                          ),
                          Text(
                            '${bookQrController.passengerCount.value * bookQrController.qrFareData.first.finalFare!}/-',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    'Per ticket fare Rs. ${bookQrController.qrFareData.first.finalFare}/- (${bookQrController.ticketType.value ? 'Round Trip' : 'One way'})',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const Divider(),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
