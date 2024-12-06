import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/controllers/button_tabbar_controller.dart';
import 'package:tsavaari/common/widgets/appbar/button_tabbar.dart';
import 'package:tsavaari/common/widgets/text/t_section_heading.dart';
import 'package:tsavaari/features/my_orders/controllers/orders_controller.dart';
import 'package:tsavaari/features/my_orders/widgets/my_orders_shimmer.dart';
import 'package:tsavaari/features/my_orders/widgets/my_orders_ticket_shape_card.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/station_list_controller.dart';
import 'package:tsavaari/features/qr/display_qr/screens/display_qr.dart';
import 'package:tsavaari/utils/constants/sizes.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stationController = Get.put(StationListController());
    final tabBarController = Get.put(ButtonTabbarController());
    final ordersController = Get.put(OrdersController());
    final buttonTexts = [
      "Active Tickets",
      "Past Tickets",
    ];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                //--Heading
                const TSectionHeading(
                  padding: EdgeInsets.all(0),
                  title: 'Order History',
                  showActionBtn: false,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),

                //-- Tabbar to change Active and Past Tickets
                ButtonTabbar(
                  buttonTexts: buttonTexts,
                  onTap: (index) {
                    tabBarController.tabIndex.value = index;
                    if (index == 0) {
                      ordersController.getActiveTickets();
                    } else if (index == 1) {
                      ordersController.getPastTickets();
                    }
                  },
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                Obx(
                  () => (ordersController.isLoading.value ||
                          stationController.isLoading.value)
                      ? ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return const MyOrdersShimmer();
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: TSizes.spaceBtwSections,
                            );
                          },
                          itemCount: 2,
                        )
                      : (ordersController.activeTickets.isNotEmpty &&
                              tabBarController.tabIndex.value == 0)
                          //--Active Tickets
                          ? ListView.separated(
                              shrinkWrap: true,
                              reverse: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return MyOrdersTicketShapeCard(
                                  ticketData: ordersController.activeTickets
                                      .first.ticketHistory![index],
                                  stationList: stationController.stationList,
                                  onTap: () {
                                    Get.to(() => DisplayQrScreen(
                                          tickets: ordersController
                                              .activeTickets
                                              .first
                                              .ticketHistory![index]
                                              .tickets,
                                          stationList:
                                              stationController.stationList,
                                          previousScreenIndication: 'myOrders',
                                          orderId: ordersController
                                                      .activeTickets
                                                      .first
                                                      .ticketHistory![index]
                                                      .tickets![0]
                                                      .orderID !=
                                                  null
                                              ? ordersController
                                                  .activeTickets
                                                  .first
                                                  .ticketHistory![index]
                                                  .tickets![0]
                                                  .orderID!
                                                  .substring(14, 33)
                                              : '',
                                        ));
                                  },
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: TSizes.spaceBtwItems * 2,
                                );
                              },
                              itemCount: ordersController
                                  .activeTickets.first.ticketHistory!.length,
                            )
                          : (ordersController.activeTickets.isNotEmpty &&
                                  tabBarController.tabIndex.value == 1)
                              //--Past Tickets
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  reverse: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return MyOrdersTicketShapeCard(
                                      ticketData: ordersController.activeTickets
                                          .first.ticketHistory![index],
                                      stationList:
                                          stationController.stationList,
                                      onTap: () {
                                        Get.to(
                                          () => DisplayQrScreen(
                                            tickets: ordersController
                                                .activeTickets
                                                .first
                                                .ticketHistory![index]
                                                .tickets,
                                            stationList:
                                                stationController.stationList,
                                            previousScreenIndication:
                                                'myOrders',
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: TSizes.spaceBtwItems * 2,
                                    );
                                  },
                                  itemCount: ordersController.activeTickets
                                      .first.ticketHistory!.length,
                                )
                              : const Center(
                                  child: Text('Data not Found'),
                                ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
