import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({
    super.key,
    required this.onPressed,
    this.iconColor,
  });
  final VoidCallback onPressed;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Stack(
          children: [
            IconButton(
              onPressed: onPressed,
              icon: Icon(
                Iconsax.notification,
                color: TColors.white,
                size: TDeviceUtils.getScreenWidth(context) * .05,
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: Container(
                width: TDeviceUtils.getScreenWidth(context) * .04,
                height: TDeviceUtils.getScreenWidth(context) * .04,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(
                    '2',
                    textScaler: TextScaler.linear(
                      ScaleSize.textScaleFactor(
                        context,
                        maxTextScaleFactor: 3,
                      ),
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .apply(color: TColors.white, fontSizeFactor: .8),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
