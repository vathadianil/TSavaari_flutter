import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';

class TicketStatusChip extends StatelessWidget {
  const TicketStatusChip({
    super.key,
    required this.ticketStatus,
    this.left = 0,
    this.bottom = 25,
  });

  final String ticketStatus;
  final double left;
  final double bottom;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      bottom: bottom,
      child: Transform.rotate(
        angle: -math.pi / 4,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: TSizes.md,
          ),
          decoration: BoxDecoration(
            color: TColors.light,
            border: Border.all(color: TColors.success, width: 2),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                TSizes.sm,
              ),
            ),
          ),
          child: Text(
            ticketStatus,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: TColors.success,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
