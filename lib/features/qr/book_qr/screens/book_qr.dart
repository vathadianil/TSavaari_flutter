import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/widgets/appbar/t_appbar.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/book_qr_controller.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/station_list_controller.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/display_fare_and_pay_btn_container.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/source_destination_selection.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/ticket_count_selection.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/ticket_type_selection.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';

class BookQrScreen extends StatelessWidget {
  const BookQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(StationListController());
    Get.put(BookQrController());
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Plan Your Journey'),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(TSizes.md),
                border: Border.all(
                  width: 1,
                  color: TColors.grey,
                ),
              ),
              child: const Column(
                children: [
                  //-- Ticket type Selection
                  TicketTypeSlection(),

                  SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),

                  //-- No. of Tickets selection
                  TicketCountSelection(),

                  SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),

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
            //-- Display Total Fare and Route
            const DisplayFarePayBtnContainer(),
          ],
        ),
      ),
      bottomNavigationBar: const Image(
        image: AssetImage(
          TImages.trainImg,
        ),
      ),
    );
  }
}
