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
    this.borderColor = TColors.success,
    this.textColor = TColors.success,
    this.backgroundColor = TColors.light,
  });

  final String ticketStatus;
  final double left;
  final double bottom;
  final Color borderColor;
  final Color textColor;
  final Color backgroundColor;

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
            color: backgroundColor,
            border: Border.all(color: borderColor, width: 2),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                TSizes.sm,
              ),
            ),
          ),
          child: Text(
            ticketStatus,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
