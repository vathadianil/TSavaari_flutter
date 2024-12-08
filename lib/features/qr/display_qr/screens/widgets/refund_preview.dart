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
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/loaders/shimmer_effect.dart';

class RefundPreview extends StatelessWidget {
  const RefundPreview({super.key, this.tickets, required this.orderId});

  final List<TicketsListModel>? tickets;
  final String orderId;

  @override
  Widget build(BuildContext context) {
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final refundController =
        Get.put(RefundPreviewController(tickets: tickets!, orderId: orderId));
    Get.put(CheckBoxController());

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
                    Get.delete<CheckBoxController>();
                  },
                  icon: const Icon(Iconsax.arrow_left)),
              const SizedBox(
                width: TSizes.md,
              ),
              Text(TTexts.cancelTicket,
                  textScaler: TextScaleUtil.getScaledText(context),
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
                  Text(
                    TTexts.selectPassengers,
                    textScaler:
                        TextScaleUtil.getScaledText(context, maxScale: 2.4),
                  ),

                //--Select all button
                if (!refundController.isLoading.value &&
                    tickets!.length ==
                        refundController.refundPreviewData.length &&
                    refundController.refundPreviewData.isNotEmpty)
                  TextButton(
                    onPressed: () {
                      onValueChanged(0, isSelectAll: true);
                    },
                    child: Text(
                      TTexts.selectAll,
                      textScaler:
                          TextScaleUtil.getScaledText(context, maxScale: 2.4),
                    ),
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
                    const Text(TTexts.noDataFound),
                  if (refundController.isLoading.value)
                    Padding(
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      child: ListView.separated(
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
                    ),
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
                                value: isTicketSelected(index),
                                onChanged: refundController
                                            .refundPreviewData[index]
                                            .returnCode ==
                                        '0'
                                    ? (value) {
                                        onValueChanged(index);
                                      }
                                    : null),
                          ),
                          title: Text(
                            '${TTexts.passenger} ${(index + 1).toString()}',
                            textScaler: TextScaleUtil.getScaledText(context,
                                maxScale: 2.4),
                          ),
                          subtitle: Text(
                            refundController
                                        .refundPreviewData[index].returnCode ==
                                    '0'
                                ? TTexts.refundPossible
                                : TTexts.refundNotPossible,
                            textScaler: TextScaleUtil.getScaledText(context,
                                maxScale: 2.4),
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
                                '${TTexts.rupeeSymbol} ${refundController.refundPreviewData[index].refundAmount ?? 0}/-',
                                textScaler: TextScaleUtil.getScaledText(context,
                                    maxScale: 2.4),
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              Text(
                                TTexts.refundAmt,
                                textScaler: TextScaleUtil.getScaledText(context,
                                    maxScale: 2.4),
                              ),
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
            () => refundController.radioSelectedValue.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.defaultSpace),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          TTexts.totalToBeRefund,
                          textScaler: TextScaleUtil.getScaledText(context,
                              maxScale: 2.5),
                        ),
                        Text(
                          '${TTexts.rupeeSymbol}${refundController.totalRefundAmount.value.toString()}/-',
                          textScaler: TextScaleUtil.getScaledText(context),
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
          SizedBox(
            height: screenWidth * 0.05,
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

  bool isTicketSelected(int index) {
    var ticketId = _getTicketId(index);
    return RefundPreviewController.instance.radioSelectedValue
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
    RefundPreviewController.instance.radioSelectedValue.clear();

    for (var index = 0; index < tickets!.length; index++) {
      if (_isRefundable(index)) {
        var ticketId = _getTicketId(index);
        RefundPreviewController.instance.radioSelectedValue.add(ticketId);
      }
    }
  }

  void _toggleTicketSelection(int index) {
    var ticketId = _getTicketId(index);
    int refundAmount =
        RefundPreviewController.instance.refundPreviewData[index].refundAmount!;

    if (RefundPreviewController.instance.radioSelectedValue
        .contains(ticketId)) {
      RefundPreviewController.instance.radioSelectedValue.remove(ticketId);
      RefundPreviewController.instance.totalRefundAmount.value -= refundAmount;
    } else {
      RefundPreviewController.instance.radioSelectedValue.add(ticketId);
      RefundPreviewController.instance.totalRefundAmount.value += refundAmount;
    }
  }

  bool _isRefundable(int index) {
    return RefundPreviewController
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
