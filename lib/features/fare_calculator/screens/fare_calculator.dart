import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/widgets/appbar/t_appbar.dart';
import 'package:tsavaari/features/fare_calculator/screens/widgets/fare_display_card.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/book_qr_controller.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/station_list_controller.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/source_destination_selection.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/ticket_type_selection.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';

class FareCalculatorScreen extends StatelessWidget {
  const FareCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(StationListController());
    Get.put(BookQrController());
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Fare Calculator'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.defaultSpace),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(TSizes.md),
                    border: Border.all(
                      width: 1,
                      color: TColors.grey,
                    ),
                  ),
                  child: const Column(
                    children: [
                      //-- Ticket type selection
                      TicketTypeSlection(),
                      //-- Source and Destination station selection
                      SourceDestinationSelection(),

                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                const FareDisplayCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
