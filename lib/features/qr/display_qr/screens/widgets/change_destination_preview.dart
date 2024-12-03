import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/common/controllers/checkbox_controller.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/proceed_to_pay_btn.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/bottom_sheet_pageview_controller.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/change_destination_preview_controller.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/loaders/shimmer_effect.dart';

class ChangeDesinationPreview extends StatelessWidget {
  const ChangeDesinationPreview({super.key, this.tickets});

  final List<TicketsListModel>? tickets;

  @override
  Widget build(BuildContext context) {
    final changeDestinationPreviewController =
        Get.put(ChangeDestinationPreviewController(tickets: tickets!));

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    BottomSheetPageViewController.instace.firstPage(context);
                  },
                  icon: const Icon(Iconsax.arrow_left)),
              const SizedBox(
                width: TSizes.md,
              ),
              Text('Change Destiantion',
                  style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!changeDestinationPreviewController.isLoading.value &&
                    tickets!.length ==
                        changeDestinationPreviewController
                            .refundPreviewData.length &&
                    changeDestinationPreviewController
                        .refundPreviewData.isNotEmpty)
                  const Text('Select Passengers'),

                //--Select all button
                if (!changeDestinationPreviewController.isLoading.value &&
                    tickets!.length ==
                        changeDestinationPreviewController
                            .refundPreviewData.length &&
                    changeDestinationPreviewController
                        .refundPreviewData.isNotEmpty)
                  TextButton(
                    onPressed: () {
                      onValueChanged(0, isSelectAll: true);
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
                  if (!changeDestinationPreviewController.isLoading.value &&
                      changeDestinationPreviewController
                          .refundPreviewData.isEmpty)
                    const Text('No Data Found'),
                  if (changeDestinationPreviewController.isLoading.value)
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
                  if (!changeDestinationPreviewController.isLoading.value &&
                      tickets!.length ==
                          changeDestinationPreviewController
                              .refundPreviewData.length &&
                      changeDestinationPreviewController
                          .refundPreviewData.isNotEmpty)
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: changeDestinationPreviewController
                                      .refundPreviewData[index].returnCode ==
                                  '0'
                              ? () {
                                  onValueChanged(index);
                                }
                              : null,
                          leading: Obx(
                            () => Checkbox(
                                //if the ticket is RJT we are checking for rjtid ortherwise ticketid
                                value: isTicketSelected(index),
                                onChanged: changeDestinationPreviewController
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
                            changeDestinationPreviewController
                                        .refundPreviewData[index].returnCode ==
                                    '0'
                                ? 'Refund Possble'
                                : 'Refund Not Possible',
                          ),
                          subtitleTextStyle: TextStyle(
                              color: changeDestinationPreviewController
                                          .refundPreviewData[index]
                                          .returnCode ==
                                      '0'
                                  ? TColors.success
                                  : TColors.error),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '\u{20B9} ${changeDestinationPreviewController.refundPreviewData[index].refundAmount ?? 0}/-',
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
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Obx(
            () =>
                changeDestinationPreviewController.radioSelectedValue.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: TSizes.defaultSpace),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total to be Refunded'),
                            Text(
                              '\u{20B9}${changeDestinationPreviewController.totalRefundAmount.value.toString()}/-',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(color: TColors.error),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
          ),
          Obx(
            () =>
                changeDestinationPreviewController.radioSelectedValue.isNotEmpty
                    ? ProceedToPayBtn(
                        btnText: 'Proceed to Cancel',
                        onPressed:
                            (CheckBoxController.instance.checkBoxState.value &&
                                    changeDestinationPreviewController
                                        .radioSelectedValue.isNotEmpty)
                                ? () {
                                    Navigator.pop(context);
                                    changeDestinationPreviewController
                                        .getRefundConfirm();
                                  }
                                : null,
                      )
                    : const SizedBox(),
          ),
        ],
      ),
    );
  }

  bool isTicketSelected(int index) {
    var ticketId = _getTicketId(index);
    return ChangeDestinationPreviewController.instance.radioSelectedValue
        .contains(ticketId);
  }

  void onValueChanged(int index, {bool isSelectAll = false}) {
    if (isSelectAll) {
      _selectAllTickets();
    } else {
      _toggleTicketSelection(index);
    }
  }

  void _selectAllTickets() {
    ChangeDestinationPreviewController.instance.radioSelectedValue.clear();

    for (var index = 0; index < tickets!.length; index++) {
      if (_isRefundable(index)) {
        var ticketId = _getTicketId(index);
        ChangeDestinationPreviewController.instance.radioSelectedValue
            .add(ticketId);
      }
    }
  }

  void _toggleTicketSelection(int index) {
    var ticketId = _getTicketId(index);
    int refundAmount = ChangeDestinationPreviewController
        .instance.refundPreviewData[index].refundAmount!;

    if (ChangeDestinationPreviewController.instance.radioSelectedValue
        .contains(ticketId)) {
      ChangeDestinationPreviewController.instance.radioSelectedValue
          .remove(ticketId);
      ChangeDestinationPreviewController.instance.totalRefundAmount.value -=
          refundAmount;
    } else {
      ChangeDestinationPreviewController.instance.radioSelectedValue
          .add(ticketId);
      ChangeDestinationPreviewController.instance.totalRefundAmount.value +=
          refundAmount;
    }
  }

  bool _isRefundable(int index) {
    return ChangeDestinationPreviewController
            .instance.refundPreviewData[index].returnCode ==
        '0';
  }

  dynamic _getTicketId(int index) {
    if (tickets![index].ticketType == 'RJT' ||
        tickets![index].ticketTypeId == 20) {
      return tickets![index].rjtID ?? tickets![index].rjtId;
    } else {
      return tickets![index].ticketId;
    }
  }
}
