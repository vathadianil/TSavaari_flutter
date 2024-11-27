import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';

class TicketStatus extends StatelessWidget {
  const TicketStatus({
    super.key,
    required this.ticketStatus,
  });

  final String ticketStatus;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Status',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: TColors.dark,
              ),
        ),
        const SizedBox(
          width: TSizes.sm,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: TSizes.md, vertical: TSizes.sm / 2),
          decoration: BoxDecoration(
            color: TColors.success,
            borderRadius: BorderRadius.circular(TSizes.lg),
          ),
          child: Text(
            ticketStatus,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: TColors.white),
          ),
        ),
      ],
    );
  }
}
