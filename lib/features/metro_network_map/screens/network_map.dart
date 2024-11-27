import 'package:flutter/material.dart';
import 'package:tsavaari/common/widgets/appbar/t_appbar.dart';
import 'package:tsavaari/common/widgets/images/rounded_corner_image.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class NetworkMapScreen extends StatelessWidget {
  const NetworkMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Metro Network Map'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: InteractiveViewer(
          maxScale: 8,
          child: RoundedCornerImage(
            height: TDeviceUtils.getScreenHeight() * .9,
            isNetworkImage: false,
            imageUrl: TImages.metroNetworkMap,
          ),
        ),
      ),
    );
  }
}
