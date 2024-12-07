import 'package:flutter/material.dart';
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
    final textScaler = TextScaleUtil.getScaledText(context);
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final controller = Get.put(UserController());
    return TAppBar(
      showBackArrow: false,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: screenWidth * .035,
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
                    width: screenWidth * .4,
                    child: Text(
                      // controller.user.value.fullname,
                      'Hi, Sam',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textScaler: textScaler,
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
                width: screenWidth * .43,
                child: Text(TTexts.homeAppbarTitle,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .apply(color: TColors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textScaler:
                        TextScaleUtil.getScaledText(context, maxScale: 2.7)),
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
                size: screenWidth * .04,
              ),
              Text(
                TTexts.share,
                textScaler: TextScaleUtil.getScaledText(context, maxScale: 2.2),
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
