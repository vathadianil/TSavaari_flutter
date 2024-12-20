import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/controllers/checkbox_controller.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/book_qr_controller.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/display_fare.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/proceed_to_pay_btn.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/qr_shimmer_container.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';

class DisplayFarePayBtnContainer extends StatelessWidget {
  const DisplayFarePayBtnContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          if (BookQrController.instance.isLoading.value)
            const QrShimmerContainer(),
          if (BookQrController.instance.qrFareData.isNotEmpty &&
              !BookQrController.instance.isLoading.value)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(TSizes.md),
                border: Border.all(
                  width: 1,
                  color: TColors.grey,
                ),
              ),
              child: Column(
                children: [
                  const DisplayFare(),
                  //-- Proceed to pay button
                  ProceedToPayBtn(
                    btnText:
                        '${TTexts.proccedToPay}  ${TTexts.rupeeSymbol}${BookQrController.instance.passengerCount.value * BookQrController.instance.qrFareData.first.finalFare!}/-',
                    onPressed: CheckBoxController.instance.checkBoxState.value
                        ? () {
                            BookQrController.instance.generateTicket();
                          }
                        : null,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
