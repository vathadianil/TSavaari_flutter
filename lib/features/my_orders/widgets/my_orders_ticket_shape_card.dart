import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tsavaari/common/controllers/button_tabbar_controller.dart';
import 'package:tsavaari/common/widgets/containers/t_ticket_shape_widget.dart';
import 'package:tsavaari/common/widgets/shapes/circle_shape.dart';
import 'package:tsavaari/common/widgets/shapes/dashed_horizontal_line.dart';
import 'package:tsavaari/features/my_orders/widgets/ticket_status.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class MyOrdersTicketShapeCard extends StatelessWidget {
  const MyOrdersTicketShapeCard(
      {super.key, required this.ticketData, required this.onTap});

  final TicketHistory ticketData;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final tabController = ButtonTabbarController.instance;

    return InkWell(
      onTap: onTap,
      child: PhysicalModel(
        color: isDark
            ? TColors.dark.withOpacity(.5)
            : TColors.grey.withOpacity(.01),
        shape: BoxShape.rectangle,
        elevation: TSizes.sm,
        shadowColor: isDark ? TColors.white.withOpacity(.2) : TColors.grey,
        borderRadius: BorderRadius.circular(TSizes.md),
        child: TTicketShapeWidget(
          child: Container(
            decoration: BoxDecoration(
                color: isDark ? TColors.dark : TColors.light,
                borderRadius: BorderRadius.circular(TSizes.md)),
            padding: const EdgeInsets.all(
              TSizes.defaultSpace,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  ticketData.purchaseDate!,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(
                  height: TSizes.sm,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleShape(
                      width: TSizes.sm,
                      height: TSizes.sm,
                      darkModeBorderColor: TColors.primary,
                      lightModeBorderColor: TColors.primary,
                      fillColor: TColors.primary,
                    ),
                    SizedBox(
                        width: TDeviceUtils.getScreenWidth(context) * .25,
                        child: const DashedHorizontalLine(
                          dashWidth: 4,
                          color: TColors.primary,
                        )),
                    const Icon(
                      Icons.train,
                      color: TColors.primary,
                    ),
                    SizedBox(
                        width: TDeviceUtils.getScreenWidth(context) * .25,
                        child: const DashedHorizontalLine(
                          dashWidth: 4,
                          color: TColors.primary,
                        )),
                    const CircleShape(
                      width: TSizes.sm,
                      height: TSizes.sm,
                      darkModeBorderColor: TColors.primary,
                      lightModeBorderColor: TColors.primary,
                      fillColor: TColors.primary,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: TDeviceUtils.getScreenWidth(context) * .2,
                      child: Text(
                        ticketData.fromStation ?? '',
                        style: Theme.of(context).textTheme.bodyLarge!,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: TDeviceUtils.getScreenWidth(context) * .1,
                    ),
                    Text(
                      ticketData.purchaseTime!,
                      style: Theme.of(context).textTheme.labelSmall!,
                    ),
                    SizedBox(
                      width: TDeviceUtils.getScreenWidth(context) * .1,
                    ),
                    SizedBox(
                      width: TDeviceUtils.getScreenWidth(context) * .2,
                      child: Text(
                        ticketData.toStation ?? '',
                        style: Theme.of(context).textTheme.bodyLarge!,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                const DashedHorizontalLine(
                  color: TColors.darkGrey,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Passengers',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Text(
                          '${ticketData.noOfPersons} Adults',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Total Fare',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Text(
                          '${ticketData.totalFareAmount}/-',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        SizedBox(
                          width: TDeviceUtils.getScreenWidth(context) * .2,
                          child: QrImageView(
                            data: 'https://www.ltmetro.com',
                            version: QrVersions.auto,
                            eyeStyle: QrEyeStyle(
                              color: tabController.tabIndex.value == 1
                                  ? TColors.darkGrey
                                  : isDark
                                      ? TColors.light
                                      : TColors.dark,
                              eyeShape: QrEyeShape.square,
                            ),
                            dataModuleStyle: QrDataModuleStyle(
                              color: tabController.tabIndex.value == 1
                                  ? TColors.darkGrey
                                  : isDark
                                      ? TColors.light
                                      : TColors.dark,
                            ),
                          ),
                        ),
                        (tabController.tabIndex.value == 1)
                            ? const TicketStatusChip(
                                left: 0,
                                bottom: 30,
                                ticketStatus: 'Expired',
                                borderColor: TColors.error,
                                textColor: TColors.error,
                              )
                            : (ticketData.tickets![0].statusId == 20)
                                ? const TicketStatusChip(
                                    left: -2,
                                    bottom: 30,
                                    textColor: TColors.secondary,
                                    borderColor: TColors.secondary,
                                    backgroundColor: TColors.dark,
                                    ticketStatus: 'In Transit',
                                    padding: EdgeInsets.symmetric(
                                      horizontal: TSizes.sm,
                                    ),
                                  )
                                : (ticketData.tickets![0].statusId == 40)
                                    ? const TicketStatusChip(
                                        left: -2,
                                        bottom: 30,
                                        textColor: TColors.error,
                                        borderColor: TColors.error,
                                        ticketStatus: 'Refunded',
                                        padding: EdgeInsets.symmetric(
                                          horizontal: TSizes.sm,
                                        ),
                                      )
                                    : (ticketData.tickets![0].statusId == 60)
                                        ? const TicketStatusChip(
                                            left: -2,
                                            bottom: 30,
                                            textColor: TColors.warning,
                                            borderColor: TColors.warning,
                                            ticketStatus: 'Change Dt',
                                            padding: EdgeInsets.symmetric(
                                              horizontal: TSizes.sm,
                                            ),
                                          )
                                        : const TicketStatusChip(
                                            left: 7,
                                            bottom: 28,
                                            ticketStatus: 'New',
                                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
