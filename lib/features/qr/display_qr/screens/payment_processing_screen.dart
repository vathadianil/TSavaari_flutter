import 'package:flutter/material.dart';
import 'package:tsavaari/common/widgets/layout/max_width_container.dart';

import 'package:tsavaari/features/qr/book_qr/models/create_order_model.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/loaders/animation_loader.dart';

class PaymentProcessingScreen extends StatelessWidget {
  const PaymentProcessingScreen({super.key, required this.verifyPayment});
  final CreateOrderModel verifyPayment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
              child: MaxWidthContaiiner(
                  child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  // const CircularProgressIndicator(
                  //   color: TColors.primary,
                  // ),
                  const TAnimationLoaderWidget(
                    isGifanimation: false,
                    animation: TImages.loaderAnimation,
                    text: '',
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Text(
                    'Payment In Progress',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Text(
                    'Do not close the app',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections * 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Date:',
                      ),
                      Text(
                        verifyPayment.createdAt ?? '',
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Order Id:',
                      ),
                      Text(
                        verifyPayment.orderId ?? '',
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Amount:',
                      ),
                      Text(
                        '${TTexts.rupeeSymbol}${verifyPayment.orderAmount!.toString()}/-',
                        style: Theme.of(context).textTheme.headlineMedium,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ))),
        ),
      ),
    );
  }
}
