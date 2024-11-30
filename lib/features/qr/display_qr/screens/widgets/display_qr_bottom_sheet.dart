import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/bottom_sheet_pageview_controller.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/bottom_sheet_main_page.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/refund_preview.dart';
import 'package:tsavaari/utils/constants/sizes.dart';

class DisplayQrBottomSheet extends StatelessWidget {
  const DisplayQrBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bottomSheetController = Get.put(BottomSheetPageViewController());
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: PageView(
        controller: bottomSheetController.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          BottomSheetMainPage(
            onTap: () {
              bottomSheetController.nextPage(context);
            },
          ),
          const RefundPreview(),
        ],
      ),
    );
  }
}
