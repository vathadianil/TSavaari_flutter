import 'package:flutter/material.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/display_qr_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class CustonQrStep {
  static Step step(DisplayQrController displayQrController,
      BuildContext context, String title, String subTitle,
      {bool isActive = false, String info = ''}) {
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    return Step(
      isActive: isActive,
      state: isActive ? StepState.complete : StepState.disabled,
      title: SizedBox(
        width: screenWidth * .5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (info != '')
              Text(info,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: TColors.black)),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: TColors.black),
            ),
          ],
        ),
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
