import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/controllers/checkbox_controller.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/terms_and_conditions_popup.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

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
    final dark = THelperFunctions.isDarkMode(context);
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
                TextButton(
                  onPressed: () {
                    Get.dialog(const Dialog(
                      child: TermsandConditionsPopup(),
                    ));
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(left: TSizes.sm),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: dark ? TColors.accent : TColors.primary,
                            width: 1),
                      ),
                    ),
                    child: SizedBox(
                      width: TDeviceUtils.getScreenWidth(context) * .32,
                      child: Text(
                        maxLines: 1,
                        TTexts.termsConditions,
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                              color: dark ? TColors.accent : TColors.primary,
                            ),
                      ),
                    ),
                  ),
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
