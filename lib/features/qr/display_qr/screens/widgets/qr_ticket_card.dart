import 'package:flutter/material.dart';
import 'package:tsavaari/common/widgets/containers/t_ticket_shape_widget.dart';
import 'package:tsavaari/features/qr/book_qr/models/station_list_model.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/display_route_container.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/qr_ticket_content_container.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

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
    final isDark = THelperFunctions.isDarkMode(context);

    return Column(
      children: [
        PhysicalModel(
          color: isDark
              ? TColors.dark.withOpacity(.5)
              : TColors.grey.withOpacity(.01),
          shape: BoxShape.rectangle,
          elevation: isDark ? TSizes.sm : TSizes.lg,
          shadowColor: isDark ? TColors.white : TColors.grey,
          borderRadius: BorderRadius.circular(TSizes.md),
          child: TTicketShapeWidget(
            child: Container(
              decoration: BoxDecoration(
                  color: TColors.white,
                  borderRadius: BorderRadius.circular(TSizes.md)),
              padding: const EdgeInsets.all(
                TSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  QrTicketContentContainer(
                    tickets: tickets,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  //-- Route and platform info container

                  DisplayrouteContainer(
                      tickets: tickets, stationList: stationList),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
