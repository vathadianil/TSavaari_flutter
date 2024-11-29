import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/bottom_navigation/bottom_navigation_menu.dart';
import 'package:tsavaari/common/widgets/appbar/t_appbar.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/display_qr_controller.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/qr_ticket_card.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/qr_tab_container.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/features/qr/book_qr/models/station_list_model.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class DisplayQrScreen extends StatelessWidget {
  const DisplayQrScreen(
      {super.key, required this.tickets, required this.stationList});
  final List<TicketsListModel>? tickets;
  final List<StationListModel> stationList;

  @override
  Widget build(BuildContext context) {
    final displayQrController = Get.put(DisplayQrController());

    List<TicketsListModel> getFormatttedTicketData(String indicator) {
      List<TicketsListModel> copiedtickets = [];

      if (tickets![0].ticketTypeId == 20 && indicator == 'oneWay') {
        copiedtickets = [];
        for (var i = 0; i < tickets!.length; i++) {
          copiedtickets.addIf(i.isEven, tickets![i]);
        }
      } else if (tickets![0].ticketTypeId == 20 && indicator == 'roundTrip') {
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
        title: const Text('Your Tickets'),
        actions: [
          OutlinedButton(
            onPressed: () {
              displayQrController.resetScreenBrightness();
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'We are here to help!',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: THelperFunctions.isDarkMode(context)
                                    ? TColors.accent
                                    : TColors.primary,
                              ),
                              borderRadius: BorderRadius.circular(
                                TSizes.md,
                              ),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Iconsax.location,
                                color: THelperFunctions.isDarkMode(context)
                                    ? TColors.accent
                                    : TColors.primary,
                              ),
                              title: Text(
                                'Change Destination',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                        color:
                                            THelperFunctions.isDarkMode(context)
                                                ? TColors.accent
                                                : TColors.primary),
                              ),
                              subtitle: Text(
                                'Want to change your destination station?. Press here.',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: TColors.error),
                              borderRadius: BorderRadius.circular(TSizes.md),
                            ),
                            child: ListTile(
                              leading: const Icon(
                                Iconsax.ticket,
                                color: TColors.error,
                              ),
                              title: Text(
                                'Cancel Ticket',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(color: TColors.error),
                              ),
                              subtitle: Text(
                                'Want to Canel your Journey!. Press here for Refund.',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                  color: THelperFunctions.isDarkMode(context)
                      ? TColors.light
                      : TColors.dark),
              minimumSize: const Size(TSizes.sm, TSizes.lg),
              padding: const EdgeInsets.symmetric(
                horizontal: TSizes.sm,
                vertical: 0,
              ),
            ),
            child: Text(
              'Need Help ?',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
          IconButton(
              onPressed: () {
                Get.offAll(() => const BottomNavigationMenu());
              },
              icon: const Icon(
                Iconsax.close_circle,
                size: TSizes.iconLg,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Center(
            child: Column(
              children: [
                //-- Qr Ticket Card
                if (tickets![0].ticketTypeId == 20)
                  QrTabContainer(
                    stationList: stationList,
                    tabChildren: const [
                      Tab(
                        text: 'Inward',
                      ),
                      Tab(
                        text: 'Retrun',
                      ),
                    ],
                    onWayData: getFormatttedTicketData('oneWay'),
                    roundTripData: getFormatttedTicketData('roundTrip'),
                  ),
                if (tickets![0].ticketTypeId == 10 ||
                    tickets![0].ticketType == 'SJT' ||
                    tickets![0].ticketType == 'RJT')
                  QrTicketCard(tickets: tickets!, stationList: stationList),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
