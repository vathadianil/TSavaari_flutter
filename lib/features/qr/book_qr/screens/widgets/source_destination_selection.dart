import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/common/widgets/dropdown/t_dropdown.dart';
import 'package:tsavaari/common/widgets/shapes/circle_shape.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/book_qr_controller.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/station_list_controller.dart';
import 'package:tsavaari/routes/routes.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/loaders/shimmer_effect.dart';
import 'package:tsavaari/common/widgets/shapes/dashed_vertical_line.dart';

class SourceDestinationSelection extends StatelessWidget {
  const SourceDestinationSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = StationListController.instance;
    final bookQrController = BookQrController.instance;

    return Stack(
      children: [
        Obx(
          () => Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (Get.currentRoute == Routes.fareCalculator)
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                    Text(
                      'Origin',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    if (controller.isLoading.value)
                      const ShimmerEffect(
                        width: double.infinity,
                        height: 50,
                      )
                    else
                      TDropdown(
                          value: bookQrController.source.value,
                          items: controller.stationList
                              .map((item) => item.name!)
                              .toList(),
                          labelText: 'Starting from',
                          onChanged: (value) {
                            bookQrController.source.value = value!;
                            bookQrController.getFare();
                          }),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    Text(
                      'Destination',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    if (controller.isLoading.value)
                      const ShimmerEffect(
                        width: double.infinity,
                        height: 50,
                      )
                    else
                      TDropdown(
                        value: bookQrController.destination.value,
                        items: controller.stationList
                            .map((item) => item.name!)
                            .toList(),
                        labelText: 'Going to',
                        onChanged: (value) {
                          bookQrController.destination.value = value!;
                          bookQrController.getFare();
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Positioned(
            top: 50,
            left: 0,
            child: CircleShape(
              darkModeBorderColor: TColors.light,
              lightModeBorderColor: TColors.darkerGrey,
            )),
        const Positioned(
          top: 65,
          left: 7,
          child: CustomPaint(
            size: Size(2, 65),
            painter: DashedLineVerticalPainter(),
          ),
        ),
        const Positioned(
          bottom: 20,
          left: 0,
          child: CircleShape(
            fillColor: TColors.success,
            darkModeBorderColor: TColors.success,
            lightModeBorderColor: TColors.success,
          ),
        ),
        Get.currentRoute == Routes.bookQr
            ? Positioned(
                top: 65,
                right: 55,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: ElevatedButton(
                    onPressed: () {
                      final temp = bookQrController.source.value;
                      bookQrController.source.value =
                          bookQrController.destination.value;
                      bookQrController.destination.value = temp;
                      bookQrController.getFare();
                    },
                    child: const Icon(Iconsax.arrow_3),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}