import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/bottom_navigation/controller/navigation_controller.dart';
import 'package:tsavaari/bottom_navigation/widgets/floating_button.dart';
import 'package:tsavaari/bottom_navigation/widgets/navigation_container.dart';
import 'package:tsavaari/features/my_orders/controllers/orders_controller.dart';
import 'package:tsavaari/features/qr/display_qr/screens/display_qr.dart';

class BottomNavigationMenu extends StatelessWidget {
  const BottomNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final ordersController = Get.put(OrdersController());
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
            if (ordersController.activeTickets.isNotEmpty &&
                ordersController.activeTickets.first.ticketHistory != null &&
                ordersController
                        .activeTickets
                        .first
                        .ticketHistory![ordersController
                                .activeTickets.first.ticketHistory!.length -
                            1]
                        .tickets![0]
                        .ticketStatus ==
                    'NEW')
              FloatingButton(
                onTap: () {
                  DisplayQrScreen(
                    stationList: [],
                    tickets: ordersController
                        .activeTickets
                        .first
                        .ticketHistory![ordersController
                                .activeTickets.first.ticketHistory!.length -
                            1]
                        .tickets!,
                    orderId: ordersController
                                .activeTickets
                                .first
                                .ticketHistory![ordersController.activeTickets
                                        .first.ticketHistory!.length -
                                    1]
                                .tickets![0]
                                .orderID !=
                            null
                        ? ordersController
                            .activeTickets
                            .first
                            .ticketHistory![ordersController
                                    .activeTickets.first.ticketHistory!.length -
                                1]
                            .tickets![0]
                            .orderID!
                            .substring(14, 33)
                        : '',
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
