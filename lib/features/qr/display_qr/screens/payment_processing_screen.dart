import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/bottom_navigation/bottom_navigation_menu.dart';
import 'package:tsavaari/common/widgets/layout/max_width_container.dart';
import 'package:tsavaari/features/qr/book_qr/models/create_order_model.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/payment_processing_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/loaders/animation_loader.dart';

class PaymentProcessingScreen extends StatelessWidget {
  const PaymentProcessingScreen(
      {super.key,
      required this.verifyPayment,
      required this.generateTicketPayload});
  final CreateOrderModel verifyPayment;
  final Map<String, Object?> generateTicketPayload;

  @override
  Widget build(BuildContext context) {
    final paymentProcessingController = Get.put(PaymentProcessingController(
        verifyPaymentData: verifyPayment,
        requestPayload: generateTicketPayload));
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
              child: MaxWidthContaiiner(
                  child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  if (paymentProcessingController.isPaymentVerifing.value)
                    const TAnimationLoaderWidget(
                      animation: TImages.trainAnimation,
                      text: 'Payment In Progress...',
                    ),
                  if (paymentProcessingController.hasVerifyPaymentSuccess.value)
                    const TAnimationLoaderWidget(
                      animation: TImages.paymentSuccess,
                      text: 'Payment Success...',
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
                        style: Theme.of(context).textTheme.titleSmall,
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
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.defaultSpace,
                          vertical: TSizes.defaultSpace / 2,
                        ),
                        side: const BorderSide(color: TColors.accent),
                      ),
                      onPressed: () {
                        Get.offAll(() => const BottomNavigationMenu());
                      },
                      child: const Text('Go Back to Home'))
                ],
              ),
            ),
          ))),
        ),
      ),
    );
  }
}
