import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/widgets/appbar/t_appbar.dart';
import 'package:tsavaari/common/widgets/notifications/notification_icon.dart';
import 'package:tsavaari/features/authentication/controllers/user_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/loaders/shimmer_effect.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return TAppBar(
      showBackArrow: false,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: TDeviceUtils.getScreenWidth(context) * .035,
            backgroundColor: TColors.white,
            backgroundImage: const AssetImage(TImages.appLogo),
          ),
          const SizedBox(
            width: TSizes.spaceBtwItems,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () {
                  if (controller.isProfileLoading.value) {
                    return const ShimmerEffect(width: 80, height: 15);
                  }
                  return SizedBox(
                    width: TDeviceUtils.getScreenWidth(context) * .4,
                    child: Text(
                      // controller.user.value.fullname,
                      'Hi, Sam',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textScaler:
                          TextScaler.linear(ScaleSize.textScaleFactor(context)),
                      style: Theme.of(context).textTheme.headlineSmall!.apply(
                            color: TColors.white,
                          ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems / 4,
              ),
              SizedBox(
                width: TDeviceUtils.getScreenWidth(context) * .43,
                child: Text(
                  TTexts.homeAppbarTitle,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .apply(color: TColors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textScaler: TextScaler.linear(
                    ScaleSize.textScaleFactor(context, maxTextScaleFactor: 2.7),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        InkWell(
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.share,
                color: TColors.white,
                size: TDeviceUtils.getScreenWidth(context) * .04,
              ),
              Text(
                TTexts.share,
                textScaler: TextScaler.linear(
                  ScaleSize.textScaleFactor(context, maxTextScaleFactor: 2.2),
                ),
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: TColors.white),
              )
            ],
          ),
        ),
        NotificationIcon(
          onPressed: () {},
        ),
      ],
    );
  }
}
