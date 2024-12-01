import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/common/controllers/checkbox_controller.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/proceed_to_pay_btn.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/bottom_sheet_pageview_controller.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/refund_preview_controller.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';

class RefundPreview extends StatelessWidget {
  const RefundPreview({super.key, this.tickets});

  final List<TicketsListModel>? tickets;

  @override
  Widget build(BuildContext context) {
    Get.put(RefundPreviewController());
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    BottomSheetPageViewController.instace.previousPage(context);
                  },
                  icon: const Icon(Iconsax.arrow_left)),
              const SizedBox(
                width: TSizes.md,
              ),
              Text('Cancel Ticket',
                  style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Select Passengers to Cancel'),
              TextButton(
                onPressed: () {},
                child: const Text('Select All'),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(TSizes.md),
              border: Border.all(
                width: 1,
                color: TColors.grey,
              ),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Obx(
                    () => Radio(
                        toggleable: true,
                        value: index,
                        groupValue: RefundPreviewController
                            .instance.radioSelectedValue
                            .indexWhere((element) => element == index),
                        onChanged: (value) {
                          print(
                              '--------------------------------------------------');

                          print(RefundPreviewController
                              .instance.radioSelectedValue);

                          RefundPreviewController.instance.radioSelectedValue
                              .addIf(
                                  !RefundPreviewController
                                      .instance.radioSelectedValue
                                      .contains(index),
                                  index);
                        }),
                  ),
                  title: Text('Passenger ${(index + 1).toString()}'),
                  subtitle: const Text(
                    'Cancel Possible',
                  ),
                  subtitleTextStyle: const TextStyle(color: TColors.success),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ' \u{20B9} ${tickets![index].finalCost!}/-',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const Text('Refund Amount'),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: TSizes.spaceBtwItems,
                );
              },
              itemCount: tickets!.length,
            ),
          ),
          ProceedToPayBtn(
            btnText: 'Proceed to Cancel',
            onPressed:
                CheckBoxController.instance.checkBoxState.value ? () {} : null,
          ),
        ],
      ),
    );
  }
}
