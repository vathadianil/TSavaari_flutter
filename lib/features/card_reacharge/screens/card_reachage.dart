import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/controllers/button_tabbar_controller.dart';
import 'package:tsavaari/common/widgets/appbar/button_tabbar.dart';
import 'package:tsavaari/common/widgets/appbar/t_appbar.dart';
import 'package:tsavaari/common/widgets/containers/t_flip.dart';
import 'package:tsavaari/features/card_reacharge/controllers/metro_card_controller.dart';
// import 'package:tsavaari/common/widgets/text/t_section_heading.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/card_back_view.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/card_front_view.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/card_topup_history.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/tap_on_the_card_text.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/travel_history_card.dart';
import 'package:tsavaari/utils/constants/sizes.dart';

class CardReachargeScreen extends StatelessWidget {
  const CardReachargeScreen({super.key});

  get cardNumber => '1234123412341234';

  get expiryDate => '04/24';

  get cardHolderName => 'Sam';

  get cardHeight => 220.0;

  get cardBalance => '2000.00';

  @override
  Widget build(BuildContext context) {
    Get.put(MetroCardController());
    final btnTabbarController = Get.put(ButtonTabbarController());
    final buttonTexts = [
      "Travel History",
      "Topup History",
    ];
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Card Recharge'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Obx(
          () => Column(
            children: [
              //--Metro Card
              TFlip(
                  foreGroudndWidget: CardFrontView(
                    cardHeight: cardHeight,
                    cardHolderName: cardHolderName,
                    cardBalance: cardBalance,
                    cardNumber: cardNumber,
                  ),
                  backGroundWidget: CardBackView(
                    cardHeight: cardHeight,
                    cardHolderName: cardHolderName,
                    cardBalance: cardBalance,
                    cardNumber: cardNumber,
                  )),
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

              ButtonTabbar(
                buttonTexts: buttonTexts,
                onTap: (index) {
                  btnTabbarController.tabIndex.value = index;
                },
              ),

              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              //--Travel history cards
              if (btnTabbarController.tabIndex.value == 0)
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const TravelHistoryCard();
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: TSizes.spaceBtwItems,
                    );
                  },
                ),

              if (btnTabbarController.tabIndex.value == 1)
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CardTopupHistory(index: index);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: TSizes.spaceBtwItems,
                    );
                  },
                  itemCount: 2,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
