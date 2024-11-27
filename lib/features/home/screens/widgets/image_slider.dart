import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/widgets/containers/t_circular_container.dart';
import 'package:tsavaari/common/widgets/images/rounded_corner_image.dart';
import 'package:tsavaari/features/home/controllers/banner_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';

import 'package:tsavaari/utils/loaders/shimmer_effect.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    super.key,
    this.autoPlay = false,
  });

  final bool autoPlay;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Column(
      children: [
        Obx(() {
          //Loader
          if (controller.isLoading.value) {
            return const ShimmerEffect(width: double.infinity, height: 180);
          }
          //No data found
          if (controller.bannersList.isEmpty) {
            return const Center(
              child: Text('No Data Found!'),
            );
          }
          return CarouselSlider(
            options: CarouselOptions(
              autoPlay: autoPlay,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                controller.updatePageIndicator(index);
              },
            ),
            items: controller.bannersList
                .map((banner) => RoundedCornerImage(
                      imageUrl: banner.imageUrl,
                      applyBoxShadow: false,
                      isNetworkImage: false,
                      onPressed: () {
                        if (banner.targetPageIndex != null) {
                          // NavigationController.instance
                          //     .onDestinationSelectionChange(
                          //         banner.targetPageIndex!);
                        } else {
                          Get.toNamed(banner.targetScreen);
                        }
                      },
                    ))
                .toList(),
          );
        }),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < controller.bannersList.length; i++)
                TCircularContainer(
                  width: 20,
                  height: 4,
                  backgroundColor: controller.carouselCurrentIndex.value == i
                      ? TColors.primary
                      : TColors.grey,
                  margin: const EdgeInsets.only(right: 10),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
