import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/widgets/containers/t_ticket_shape_widget.dart';
import 'package:tsavaari/features/qr/book_qr/models/station_list_model.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/display_route_container.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/display_qr_controller.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/qr_main_stepper.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/qr_ticket_content_container.dart';
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
                      QrStepper(
                        tickets: tickets,
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
