import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';

class PassengerCount extends StatelessWidget {
  const PassengerCount({
    super.key,
    required this.totalTicketCount,
    required this.currentValue,
  });
  final int totalTicketCount;
  final int currentValue;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Passenger',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: TColors.dark,
                )),
        const SizedBox(
          width: TSizes.sm,
        ),
        Text(
          '$currentValue/$totalTicketCount',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: TColors.dark,
              ),
        ),
      ],
    );
  }
}
