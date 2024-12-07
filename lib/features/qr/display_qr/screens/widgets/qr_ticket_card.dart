import 'package:flutter/material.dart';
import 'package:tsavaari/common/widgets/containers/t_ticket_shape_widget.dart';
import 'package:tsavaari/features/qr/book_qr/models/station_list_model.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/display_route_container.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/features/qr/display_qr/screens/widgets/qr_ticket_content_container.dart';
import 'package:tsavaari/utils/constants/sizes.dart';

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
    return Column(
      children: [
        TTicketShapeWidget(
          child: Column(
            children: [
              QrTicketContentContainer(
                tickets: tickets,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              //-- Route and platform info container

              if (tickets[0].platFormNo != null)
                DisplayrouteContainer(
                    tickets: tickets, stationList: stationList),
            ],
          ),
        ),
      ],
    );
  }
}
