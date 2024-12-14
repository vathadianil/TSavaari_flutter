import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/controllers/button_tabbar_controller.dart';
import 'package:tsavaari/common/widgets/appbar/button_tabbar.dart';
import 'package:tsavaari/common/widgets/appbar/t_appbar.dart';
import 'package:tsavaari/features/card_reacharge/controllers/metro_card_controller.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/add_card.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/card_layout.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/card_layout_shimmer.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/card_topup_history.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/travel_history_card.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class CardReachargeScreen extends StatelessWidget {
  const CardReachargeScreen({super.key});

  get expiryDate => '04/24';

  get cardBalance => '2000.00';

  @override
  Widget build(BuildContext context) {
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final cardHeight = screenWidth * .5;
    final cardController = Get.put(MetroCardController());
    final btnTabbarController = Get.put(ButtonTabbarController());
    final buttonTexts = [
      "Travel History",
      "Topup History",
    ];
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: const Text('Card Recharge'),
        actions: [
          AddCard(
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Obx(
          () => Column(
            children: [
              //--Metro Card
              if (cardController.isCardDetailsLoading.value)
                CardLayoutShimmer(cardHeight: cardHeight),
              if (!cardController.isCardDetailsLoading.value)
                CardLayout(
                  cardHeight: cardHeight,
                  cardBalance: cardBalance,
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
              //--Transaction history cards
              if (btnTabbarController.tabIndex.value == 1)
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
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
