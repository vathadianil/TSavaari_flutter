import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/book_qr_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class TicketTypeSlection extends StatelessWidget {
  const TicketTypeSlection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = BookQrController.instance;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            controller.ticketType.value = false;
            controller.getFare();
          },
          child:
              Text(TTexts.oneWay, style: Theme.of(context).textTheme.bodyLarge),
        ),
        Transform.scale(
          scale: .7,
          child: Obx(
            () => Switch(
              value: controller.ticketType.value,
              onChanged: (value) {
                controller.ticketType.value = !controller.ticketType.value;
                controller.getFare();
              },
              thumbColor: MaterialStateColor.resolveWith(
                (states) => states.contains(MaterialState.selected)
                    ? TColors.primary
                    : TColors.primary,
              ),
              activeColor: TColors.white,
              activeTrackColor: dark ? TColors.white : TColors.white,
              inactiveTrackColor: TColors.white,
              trackOutlineWidth: MaterialStateProperty.all(2),
              trackOutlineColor: MaterialStateColor.resolveWith(
                (states) => states.contains(MaterialState.selected)
                    ? TColors.primary
                    : TColors.primary,
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            controller.ticketType.value = true;
            controller.getFare();
          },
          child: Text(TTexts.roundTrip,
              style: Theme.of(context).textTheme.bodyLarge),
        )
      ],
    );
  }
}
