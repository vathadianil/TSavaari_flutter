import 'package:flutter/material.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/display_qr_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';

class CustonQrStep {
  static Step step(DisplayQrController displayQrController,
      BuildContext context, String title, String subTitle,
      {bool isActive = false}) {
    return Step(
      isActive: isActive,
      state: isActive ? StepState.complete : StepState.disabled,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: TColors.black),
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context)
            .textTheme
            .labelSmall!
            .copyWith(color: TColors.black),
      ),
      content: const SizedBox.shrink(),
    );
  }
}
