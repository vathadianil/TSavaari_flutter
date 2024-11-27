import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';

class TicketExpiry extends StatelessWidget {
  const TicketExpiry({
    super.key,
    required this.dateTime,
  });

  final String dateTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Valid Upto',
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(color: TColors.black),
        ),
        const SizedBox(
          width: TSizes.defaultSpace / 2,
        ),
        Text(
          dateTime,
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(color: TColors.black, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
