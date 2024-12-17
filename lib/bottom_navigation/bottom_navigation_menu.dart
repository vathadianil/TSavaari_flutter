import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/bottom_navigation/controller/navigation_controller.dart';
// import 'package:tsavaari/bottom_navigation/widgets/floating_button.dart';
import 'package:tsavaari/bottom_navigation/widgets/navigation_container.dart';
import 'package:tsavaari/features/my_orders/controllers/orders_controller.dart';
// import 'package:tsavaari/features/qr/book_qr/controllers/station_list_controller.dart';
// import 'package:tsavaari/features/qr/display_qr/screens/display_qr.dart';
// import 'package:tsavaari/utils/constants/ticket_status_codes.dart';

class BottomNavigationMenu extends StatelessWidget {
  const BottomNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    // final ordersController = Get.put(OrdersController());
    // final stationListController = Get.put(StationListController());
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            controller.screens[controller.selectedIndex.value],
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: NavigationContainer(
                currentIndex: controller.selectedIndex.value,
                onPressed: (index) {
                  controller.onDestinationSelectionChange(index);
                  Get.delete<OrdersController>();
                },
              ),
            ),
            // if (ordersController.activeTickets.isNotEmpty &&
            //     ordersController.activeTickets.first.ticketHistory != null &&
            //     (ordersController.activeTickets.first.ticketHistory![0]
            //                 .tickets![0].ticketStatus ==
            //             TicketStatusCodes.newTicketString ||
            //         ordersController.activeTickets.first.ticketHistory![0]
            //                 .tickets![0].ticketStatus ==
            //             TicketStatusCodes.entryUsedString))
            //   FloatingButton(
            //     ticketStatus: ordersController.activeTickets.first
            //             .ticketHistory![0].tickets![0].ticketStatus ??
            //         '',
            //     onTap: () {
            //       Get.to(() => DisplayQrScreen(
            //             stationList: stationListController.stationList,
            //             tickets: ordersController
            //                 .activeTickets.first.ticketHistory![0].tickets!,
            //             orderId: ordersController.activeTickets.first
            //                         .ticketHistory![0].tickets![0].orderID !=
            //                     null
            //                 ? ordersController.activeTickets.first
            //                     .ticketHistory![0].tickets![0].orderID!
            //                     .substring(14, 37)
            //                 : '',
            //           ));
            //     },
            //   ),
          ],
        ),
      ),
    );
  }
}
