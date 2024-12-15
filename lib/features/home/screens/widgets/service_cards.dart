import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/widgets/containers/t_circular_container.dart';
import 'package:tsavaari/features/home/models/metro_services_model.dart';
import 'package:tsavaari/features/home/screens/widgets/social_media_popup.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/t_icons.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class ServiceCards extends StatelessWidget {
  const ServiceCards({super.key, required this.service});
  final MetroServicesModel service;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    return InkWell(
      onTap: () {
        if (service.targetScreen == '/media') {
          Get.dialog(const Dialog(
            child: SocialMediaPopup(),
          ));
        } else {
          Get.toNamed(service.targetScreen);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: TCircularContainer(
              applyBoxShadow: true,
              backgroundColor: dark ? TColors.dark : TColors.white,
              boxShadowColor:
                  dark ? TColors.accent.withOpacity(.3) : TColors.accent,
              radius: TSizes.borderRadiusMd,
              child: Icon(
                TIcons.getIcon(service.icon),
                size: screenWidth * .11,
                color: dark ? TColors.accent : TColors.primary,
              ),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems / 2,
          ),
          Text(
            service.title,
            textScaler: TextScaleUtil.getScaledText(context, maxScale: 3),
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
