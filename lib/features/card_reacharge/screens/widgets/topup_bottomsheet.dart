import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/card_reacharge/models/nebula_card_validation_model.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/confirm_topup.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/topup_bottom_sheet_main_page.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/bottom_sheet_pageview_controller.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class TopupBottomSheet extends StatelessWidget {
  const TopupBottomSheet({super.key, required this.cardData});

  final NebulaCardValidationModel cardData;

  @override
  Widget build(BuildContext context) {
    final bottomSheetContoller = Get.put(BottomSheetPageViewController());
    final screenHeight = TDeviceUtils.getScreenHeight();
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child:
          // Obx(
          //   () =>
          SizedBox(
        // height: bottomSheetContoller.currentPageIndex.value == 0
        //     ? screenHeight * .65
        //     : screenHeight * .65,
        height: screenHeight * .65,
        child: PageView(
          controller: bottomSheetContoller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            TopupMainPage(cardData: cardData),
            ConfirmTopup(
              cardDetails: cardData,
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
