import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';

class RefundPreview extends StatelessWidget {
  const RefundPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FloatingActionButton(
              onPressed: () {},
              mini: true,
              shape: const CircleBorder(),
              backgroundColor: TColors.grey,
              child: const Icon(
                Iconsax.arrow_left_24,
                color: TColors.black,
              ),
            ),
            const SizedBox(
              width: TSizes.md,
            ),
            Text(
              'Cancel Ticket',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: TColors.error),
            ),
          ],
        ),
      ],
    );
  }
}
