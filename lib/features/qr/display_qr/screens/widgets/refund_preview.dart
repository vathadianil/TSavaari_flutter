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
import 'package:tsavaari/utils/loaders/shimmer_effect.dart';

class RefundPreview extends StatelessWidget {
  const RefundPreview({super.key, this.tickets});

  final List<TicketsListModel>? tickets;

  @override
  Widget build(BuildContext context) {
    final refundController =
        Get.put(RefundPreviewController(tickets: tickets!));
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
            child: Obx(
              () => Column(
                children: [
                  if (!refundController.isLoading.value &&
                      refundController.refundPreviewData.isEmpty)
                    const Text('No Data Found'),
                  if (refundController.isLoading.value)
                    ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return const ShimmerEffect(
                            width: double.infinity,
                            height: 60,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: TSizes.spaceBtwItems,
                          );
                        },
                        itemCount: 2),
                  if (!refundController.isLoading.value &&
                      tickets!.length ==
                          refundController.refundPreviewData.length &&
                      refundController.refundPreviewData.isNotEmpty)
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Obx(
                            () => Checkbox(
                                value: refundController.radioSelectedValue
                                    .contains(tickets![index].ticketId),
                                onChanged: refundController
                                            .refundPreviewData[index]
                                            .returnCode ==
                                        '0'
                                    ? (value) {
                                        if (refundController.radioSelectedValue
                                            .contains(
                                                tickets![index].ticketId)) {
                                          refundController.radioSelectedValue
                                              .remove(tickets![index].ticketId);
                                        } else {
                                          refundController.radioSelectedValue
                                              .add(tickets![index].ticketId);
                                        }
                                      }
                                    : null),
                          ),
                          title: Text('Passenger ${(index + 1).toString()}'),
                          subtitle: Text(
                            refundController
                                        .refundPreviewData[index].returnCode ==
                                    '0'
                                ? 'Refund Possble'
                                : 'Refund Not Possible',
                          ),
                          subtitleTextStyle: TextStyle(
                              color: refundController.refundPreviewData[index]
                                          .returnCode ==
                                      '0'
                                  ? TColors.success
                                  : TColors.error),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '\u{20B9} ${refundController.refundPreviewData[index].refundAmount ?? '0'}/-',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
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
                ],
              ),
            ),
          ),
          Obx(
            () => ProceedToPayBtn(
              btnText: 'Proceed to Cancel',
              onPressed: (CheckBoxController.instance.checkBoxState.value &&
                      refundController.radioSelectedValue.isNotEmpty)
                  ? () {
                      Navigator.pop(context);
                      refundController.getRefundConfirm();
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
