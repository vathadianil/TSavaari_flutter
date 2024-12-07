import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({
    super.key,
    required this.onPressed,
    this.iconColor,
    this.notificationCount = '0',
  });

  final VoidCallback onPressed;
  final Color? iconColor;
  final String notificationCount;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = TDeviceUtils.getScreenWidth(context);
    final double iconSize = screenWidth * 0.06;
    final double badgeSize = screenWidth > 400 ? iconSize * .6 : iconSize * 0.8;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            Iconsax.notification,
            color: iconColor ?? TColors.white,
            size: iconSize,
          ),
        ),
        // Notification Badge
        Positioned(
          top: iconSize * 0.15,
          right: iconSize * 0.15,
          child: Container(
            width: badgeSize,
            height: badgeSize,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(badgeSize / 2),
            ),
            child: Center(
              child: Text(
                notificationCount,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: TColors.white,
                      fontSize: badgeSize * 0.5,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
