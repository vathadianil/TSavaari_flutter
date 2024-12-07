import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/controllers/checkbox_controller.dart';
import 'package:tsavaari/common/widgets/button/underlined_text_button.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/terms_and_conditions_popup.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';

class ProceedToPayBtn extends StatelessWidget {
  const ProceedToPayBtn({
    super.key,
    required this.btnText,
    required this.onPressed,
  });

  final String btnText;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final checkBoxController = CheckBoxController.instance;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(
              () => Checkbox(
                value: checkBoxController.checkBoxState.value,
                onChanged: (value) => checkBoxController.checkBoxState.value =
                    !checkBoxController.checkBoxState.value,
              ),
            ),
            Row(
              children: [
                Text(
                  TTexts.iAgree,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                UnderLinedTextButton(
                  btnText: TTexts.termsConditions,
                  onPressed: () {
                    Get.dialog(const Dialog(
                      child: TermsandConditionsPopup(),
                    ));
                  },
                ),
              ],
            )
          ],
        ),
        Obx(
          () => ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: checkBoxController.checkBoxState.value
                  ? TColors.primary
                  : TColors.grey,
              padding: const EdgeInsets.symmetric(
                horizontal: TSizes.defaultSpace,
                vertical: TSizes.defaultSpace / 2,
              ),
              side: const BorderSide(color: TColors.accent),
            ),
            child: Text(
              btnText,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: checkBoxController.checkBoxState.value
                        ? TColors.light
                        : TColors.darkGrey,
                  ),
            ),
          ),
        ),
        const SizedBox(
          height: TSizes.defaultSpace,
        )
      ],
    );
  }
}
