import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/common/widgets/containers/t_ticket_shape_widget.dart';
import 'package:tsavaari/features/qr/book_qr/models/station_list_model.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/display_route_container.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/display_qr_controller.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/qr_ticket_content_container.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/ticket_status_codes.dart';

class QrTicketCard extends StatelessWidget {
  const QrTicketCard({
    super.key,
    required this.tickets,
    required this.stationList,
  });
  final List<TicketsListModel> tickets;
  final List<StationListModel> stationList;

  @override
  Widget build(BuildContext context) {
    final displayQrController = DisplayQrController.instance;
    return Column(
      children: [
        TTicketShapeWidget(
          child: Column(
            children: [
              QrTicketContentContainer(
                tickets: tickets,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              //-- Route and platform info container

              Obx(
                () => Column(
                  children: [
                    if (tickets[displayQrController.carouselCurrentIndex.value]
                                .platFormNo !=
                            null &&
                        (tickets[displayQrController.carouselCurrentIndex.value]
                                    .statusId ==
                                TicketStatusCodes.newTicket ||
                            tickets[displayQrController
                                        .carouselCurrentIndex.value]
                                    .ticketStatus ==
                                TicketStatusCodes.newTicketString ||
                            tickets[displayQrController
                                        .carouselCurrentIndex.value]
                                    .statusId ==
                                TicketStatusCodes.entryUsed))
                      DisplayrouteContainer(
                          tickets: tickets, stationList: stationList)
                    else
                      Stepper(
                        connectorColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.selected)) {
                            return TColors.primary;
                          }
                          return TColors.grey;
                        }),
                        controlsBuilder: (context, details) {
                          if (details.stepIndex == 0) {
                            return Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Purchase Id',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: TColors.black),
                                    ),
                                    Text(
                                      '4332432545slkfjslkfjslkfjs',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(color: TColors.black),
                                    )
                                  ],
                                )
                              ],
                            );
                          } else {
                            return const Row(
                              children: [],
                            );
                          }
                        },
                        stepIconBuilder: (stepIndex, stepState) {
                          if (stepIndex == 0) {
                            return const Icon(
                              Iconsax.tick_circle,
                              color: TColors.white,
                            );
                          } else {
                            return const Icon(
                              Iconsax.clock,
                              color: TColors.white,
                            );
                          }
                        },
                        steps: [
                          Step(
                            isActive: true,
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Miyapur',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: TColors.black),
                                ),
                                Text('17 Mar 2024 18:23 AM',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(color: TColors.black)),
                              ],
                            ),
                            content: const SizedBox.shrink(),
                          ),
                          Step(
                            isActive: false,
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Entry',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: TColors.black)),
                                Text('17 Mar 2024 18:23 AM',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(color: TColors.black)),
                              ],
                            ),
                            content: const SizedBox.shrink(),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
