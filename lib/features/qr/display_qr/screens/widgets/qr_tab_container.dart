import 'package:flutter/material.dart';
import 'package:tsavaari/common/widgets/appbar/t_tabbar.dart';
import 'package:tsavaari/common/widgets/containers/t_ticket_shape_widget.dart';
import 'package:tsavaari/features/qr/book_qr/models/station_list_model.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/display_route_container.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/display_qr_controller.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/qr_ticket_content_container.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class QrTabContainer extends StatefulWidget {
  const QrTabContainer(
      {super.key,
      required this.tabChildren,
      required this.onWayData,
      required this.roundTripData,
      required this.stationList});
  final List<Widget> tabChildren;
  final List<TicketsListModel> onWayData;
  final List<TicketsListModel> roundTripData;
  final List<StationListModel> stationList;

  @override
  State<QrTabContainer> createState() => _QrTabContainerState();
}

class _QrTabContainerState extends State<QrTabContainer>
    with TickerProviderStateMixin {
  late TabController _tabBarController;
  @override
  void initState() {
    super.initState();
    _tabBarController =
        TabController(length: widget.tabChildren.length, vsync: this);
    _tabBarController.addListener(() {
      DisplayQrController.instance.carouselCurrentIndex.value = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = TDeviceUtils.getScreenHeight();
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    return Column(
      children: [
        TTabbar(
          controller: _tabBarController,
          tabs: widget.tabChildren,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        SizedBox(
          width: double.maxFinite,
          height: screenWidth <= TSizes.smallSceenSize
              ? screenHeight * 1.02
              : screenHeight * .82,
          child: TTicketShapeWidget(
            child: TabBarView(
              controller: _tabBarController,
              children: [
                Column(
                  children: [
                    QrTicketContentContainer(
                      tickets: widget.onWayData,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    //-- Route and platform info container

                    DisplayrouteContainer(
                      tickets: widget.onWayData,
                      stationList: widget.stationList,
                    ),
                  ],
                ),
                Column(
                  children: [
                    QrTicketContentContainer(
                      tickets: widget.roundTripData,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    //-- Route and platform info container

                    DisplayrouteContainer(
                      tickets: widget.roundTripData,
                      stationList: widget.stationList,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
