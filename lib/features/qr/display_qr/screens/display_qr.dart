import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/bottom_navigation/bottom_navigation_menu.dart';
import 'package:tsavaari/common/controllers/checkbox_controller.dart';
import 'package:tsavaari/common/widgets/appbar/t_appbar.dart';
import 'package:tsavaari/common/widgets/layout/max_width_container.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/change_destination_preview_controller.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/display_qr_controller.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/refund_preview_controller.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/display_qr_bottom_sheet.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/need_help_button.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/qr_ticket_card.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/qr_tab_container.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/features/qr/book_qr/models/station_list_model.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/constants/ticket_status_codes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class DisplayQrScreen extends StatelessWidget {
  const DisplayQrScreen(
      {super.key,
      required this.tickets,
      required this.stationList,
      this.orderId = '',
      this.previousScreenIndication = 'bookQr'});
  final List<TicketsListModel>? tickets;
  final List<StationListModel> stationList;
  final String previousScreenIndication;
  final String orderId;

  @override
  Widget build(BuildContext context) {
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final displayQrController = Get.put(DisplayQrController());

    Get.put(CheckBoxController());
    List<TicketsListModel> getFormatttedTicketData(String indicator) {
      List<TicketsListModel> copiedtickets = [];

      if (tickets![0].ticketTypeId == TicketStatusCodes.ticketTypeRjt &&
          indicator == 'oneWay') {
        copiedtickets = [];
        for (var i = 0; i < tickets!.length; i++) {
          copiedtickets.addIf(i.isEven, tickets![i]);
        }
      } else if (tickets![0].ticketTypeId == TicketStatusCodes.ticketTypeRjt &&
          indicator == 'roundTrip') {
        copiedtickets = [];
        for (var i = 0; i < tickets!.length; i++) {
          copiedtickets.addIf(i.isOdd, tickets![i]);
        }
      }
      return copiedtickets;
    }

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: false,
        title: Text(
          TTexts.yourTickets,
          textScaler: TextScaleUtil.getScaledText(context, maxScale: 3),
        ),
        actions: [
          if (tickets![displayQrController.carouselCurrentIndex.value]
                  .entryExitType !=
              TicketStatusCodes.exitOnly.toString())
            NeedHelpButton(onPressed: () {
              displayQrController.resetScreenBrightness();
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return DisplayQrBottomSheet(
                      tickets: (tickets![0].ticketTypeId ==
                                  TicketStatusCodes.ticketTypeRjt &&
                              previousScreenIndication == 'bookQr')
                          ? getFormatttedTicketData('oneWay')
                          : tickets,
                      stationList: stationList,
                      orderId: orderId,
                    );
                  }).whenComplete(() {
                Get.delete<RefundPreviewController>();
                Get.delete<ChangeDestinationPreviewController>();
              });
            }),
          IconButton(
              onPressed: () {
                if (previousScreenIndication == 'bookQr') {
                  Get.offAll(() => const BottomNavigationMenu());
                } else {
                  Get.back();
                }
              },
              icon: Icon(
                Iconsax.close_circle,
                size: screenWidth * .06,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: MaxWidthContaiiner(
              child: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Center(
                  child: Column(
                    children: [
                      //-- Qr Ticket Card
                      if (tickets![0].ticketTypeId ==
                          TicketStatusCodes.ticketTypeRjt)
                        QrTabContainer(
                          stationList: stationList,
                          tabChildren: const [
                            Tab(
                              text: TTexts.inward,
                            ),
                            Tab(
                              text: TTexts.outWard,
                            ),
                          ],
                          onWayData: getFormatttedTicketData('oneWay'),
                          roundTripData: getFormatttedTicketData('roundTrip'),
                        ),
                      if (tickets![0].ticketTypeId ==
                              TicketStatusCodes.ticketTypeSjt ||
                          tickets![0].ticketType ==
                              TicketStatusCodes.ticketTypeSjtString ||
                          tickets![0].ticketType ==
                              TicketStatusCodes.ticketTypeRjtString ||
                          tickets![0].oldTicketStatusId ==
                              TicketStatusCodes.changeDestination.toString())
                        QrTicketCard(
                          tickets: tickets!,
                          stationList: stationList,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
