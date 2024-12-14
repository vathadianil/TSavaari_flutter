import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/widgets/containers/t_circular_container.dart';
import 'package:tsavaari/common/widgets/containers/t_flip.dart';
import 'package:tsavaari/features/card_reacharge/controllers/metro_card_controller.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/card_back_view.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/card_front_view.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/tap_on_the_card_text.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class CardLayout extends StatelessWidget {
  const CardLayout({
    super.key,
    required this.cardHeight,
    required this.cardBalance,
  });

  final double cardHeight;
  final String cardBalance;

  @override
  Widget build(BuildContext context) {
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final cardController = MetroCardController.instance;
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: false,
            disableCenter: false,
            height: screenWidth * .55,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              cardController.updatePageIndicator(index);
            },
          ),
          items: cardController.cardDetailsByUser.first.cardDetails!
              .map(
                (cardData) => TFlip(
                  foreGroudndWidget: CardFrontView(
                    cardHeight: cardHeight,
                    cardHolderName: cardData.cardDesc ?? '',
                    cardBalance: cardBalance,
                    cardNumber: cardData.cardNo ?? '',
                  ),
                  backGroundWidget: CardBackView(
                    cardHeight: cardHeight,
                    cardNumber: cardData.cardNo ?? '',
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        if (!cardController.isCardDetailsLoading.value)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0;
                  i <
                      cardController
                          .cardDetailsByUser.first.cardDetails!.length;
                  i++)
                Obx(
                  () => TCircularContainer(
                    width: TDeviceUtils.getScreenWidth(context) * .04,
                    height: TDeviceUtils.getScreenWidth(context) * .01,
                    backgroundColor:
                        cardController.carouselCurrentIndex.value == i
                            ? TColors.primary
                            : TColors.grey,
                    margin: const EdgeInsets.only(right: 10),
                  ),
                ),
            ],
          ),

        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        //-- Tap on Card Text
        const TapOnTheCardText(),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        const Divider(),

        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
      ],
    );
  }
}
