import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
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
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!refundController.isLoading.value &&
                    tickets!.length ==
                        refundController.refundPreviewData.length &&
                    refundController.refundPreviewData.isNotEmpty)
                  const Text('Select Passengers to Cancel'),

                //--Select all button
                if (!refundController.isLoading.value &&
                    tickets!.length ==
                        refundController.refundPreviewData.length &&
                    refundController.refundPreviewData.isNotEmpty)
                  TextButton(
                    onPressed: () {
                      for (var index = 0; index < tickets!.length; index++) {
                        if (refundController
                                .refundPreviewData[index].returnCode ==
                            '0') {
                          if (tickets![index].ticketType == 'RJT' ||
                              tickets![index].ticketTypeId == 20) {
                            if (refundController.radioSelectedValue.contains(
                                (tickets![index].rjtID ??
                                    tickets![index].rjtId))) {
                              refundController.radioSelectedValue.remove(
                                  (tickets![index].rjtID ??
                                      tickets![index].rjtId));
                            } else {
                              refundController.radioSelectedValue.add(
                                  (tickets![index].rjtID ??
                                      tickets![index].rjtId));
                            }
                          } else {
                            if (refundController.radioSelectedValue
                                .contains(tickets![index].ticketId)) {
                              refundController.radioSelectedValue
                                  .remove(tickets![index].ticketId);
                            } else {
                              refundController.radioSelectedValue
                                  .add(tickets![index].ticketId);
                            }
                          }
                        }
                      }
                    },
                    child: const Text('Select All'),
                  ),
              ],
            ),
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
                          onTap: refundController
                                      .refundPreviewData[index].returnCode ==
                                  '0'
                              ? () {
                                  onValueChanged(index);
                                }
                              : null,
                          leading: Obx(
                            () => Checkbox(
                                //if the ticket is RJT we are checking for rjtid ortherwise ticketid
                                value: (tickets![index].ticketType == 'RJT' ||
                                        tickets![index].ticketTypeId == 20)
                                    ? refundController.radioSelectedValue
                                        .contains((tickets![index].rjtID ??
                                            tickets![index].rjtId))
                                    : refundController.radioSelectedValue
                                        .contains(
                                        tickets![index].ticketId,
                                      ),
                                onChanged: refundController
                                            .refundPreviewData[index]
                                            .returnCode ==
                                        '0'
                                    ? (value) {
                                        onValueChanged(index);
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
            () => refundController.radioSelectedValue.isNotEmpty
                ? ProceedToPayBtn(
                    btnText: 'Proceed to Cancel',
                    onPressed:
                        (CheckBoxController.instance.checkBoxState.value &&
                                refundController.radioSelectedValue.isNotEmpty)
                            ? () {
                                Navigator.pop(context);
                                refundController.getRefundConfirm();
                              }
                            : null,
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  void onValueChanged(int index) {
    if (tickets![index].ticketType == 'RJT' ||
        tickets![index].ticketTypeId == 20) {
      if (RefundPreviewController.instance.radioSelectedValue
          .contains((tickets![index].rjtID ?? tickets![index].rjtId))) {
        RefundPreviewController.instance.radioSelectedValue
            .remove((tickets![index].rjtID ?? tickets![index].rjtId));
      } else {
        RefundPreviewController.instance.radioSelectedValue
            .add((tickets![index].rjtID ?? tickets![index].rjtId));
      }
    } else {
      if (RefundPreviewController.instance.radioSelectedValue
          .contains(tickets![index].ticketId)) {
        RefundPreviewController.instance.radioSelectedValue
            .remove(tickets![index].ticketId);
      } else {
        RefundPreviewController.instance.radioSelectedValue
            .add(tickets![index].ticketId);
      }
    }
  }
}
