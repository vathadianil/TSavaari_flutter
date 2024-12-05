import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/common/controllers/checkbox_controller.dart';
import 'package:tsavaari/common/widgets/dropdown/t_dropdown.dart';
import 'package:tsavaari/features/qr/book_qr/models/station_list_model.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/proceed_to_pay_btn.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/bottom_sheet_pageview_controller.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/change_destination_preview_controller.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/loaders/shimmer_effect.dart';

class ChangeDesinationPreview extends StatelessWidget {
  const ChangeDesinationPreview({super.key, this.tickets, this.stationList});

  final List<TicketsListModel>? tickets;
  final List<StationListModel>? stationList;

  @override
  Widget build(BuildContext context) {
    final changeDestinationPreviewController = Get.put(
        ChangeDestinationPreviewController(
            tickets: tickets!, stationList: stationList!));
    Get.put(CheckBoxController());

    print('-----------------------------------------');
    print(tickets![2].ticketId);

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
                    Get.delete<ChangeDestinationPreviewController>();
                    Get.delete<CheckBoxController>();
                  },
                  icon: const Icon(Iconsax.arrow_left)),
              const SizedBox(
                width: TSizes.md,
              ),
              Text('Change Destiantion',
                  style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Select Passengers '),

              // --Select all button
              TextButton(
                onPressed: () {
                  onValueChanged(0, isSelectAll: true);
                },
                child: const Text('Select All'),
              ),
            ],
          ),
          const SizedBox(height: TSizes.sm),
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
                  if (changeDestinationPreviewController.isLoading.value)
                    Padding(
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return const ShimmerEffect(
                                width: double.infinity, height: 60);
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: TSizes.spaceBtwItems,
                            );
                          },
                          itemCount: 2),
                    ),
                  if (!changeDestinationPreviewController.isLoading.value)
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: !changeDestinationPreviewController
                                  .isChangeDestinationPreviewChecked.value
                              ? () {
                                  onValueChanged(index);
                                }
                              : null,
                          leading: Obx(
                            () => !changeDestinationPreviewController
                                    .isChangeDestinationPreviewChecked.value
                                ? Checkbox(
                                    //if the ticket is RJT we are checking for rjtid ortherwise ticketid
                                    value: isTicketSelected(index),
                                    onChanged: (value) {
                                      onValueChanged(index);
                                    },
                                  )
                                : const SizedBox(),
                          ),
                          title: Text('Passenger ${(index + 1).toString()}'),
                          subtitle: (!changeDestinationPreviewController
                                      .isLoading.value &&
                                  changeDestinationPreviewController
                                      .isChangeDestinationPreviewChecked
                                      .value &&
                                  changeDestinationPreviewController
                                      .changeDestinationPreviewData.isNotEmpty)
                              ? Text(
                                  _isDestinationChangable(index)
                                      ? 'Updated destination will be ${changeDestinationPreviewController.stationName.value}'
                                      : 'Change Destination Not Possible',
                                )
                              : Text(
                                  'Current Destination ${tickets![index].fromStation ?? THelperFunctions.getStationFromStationId(tickets![index].fromStationId!, stationList!).name}'),
                          subtitleTextStyle: changeDestinationPreviewController
                                  .isChangeDestinationPreviewChecked.value
                              ? TextStyle(
                                  color: _isDestinationChangable(index)
                                      ? TColors.success
                                      : TColors.error,
                                )
                              : Theme.of(context).textTheme.labelLarge,
                          trailing: changeDestinationPreviewController
                                  .isChangeDestinationPreviewChecked.value
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '\u{20B9} ${changeDestinationPreviewController.changeDestinationPreviewData[index].totalFareAdjusted}/-',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    const Text('Payable Amount'),
                                  ],
                                )
                              : const SizedBox(),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: TSizes.spaceBtwItems,
                        );
                      },
                      itemCount: (!changeDestinationPreviewController
                                  .isLoading.value &&
                              changeDestinationPreviewController
                                  .isChangeDestinationPreviewChecked.value &&
                              changeDestinationPreviewController
                                  .changeDestinationPreviewData.isNotEmpty)
                          ? changeDestinationPreviewController
                              .changeDestinationPreviewData.length
                          : tickets!.length,
                    ),
                  if (!changeDestinationPreviewController
                      .isChangeDestinationPreviewChecked.value)
                    Padding(
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      child: TDropdown(
                          labelColor: TColors.error,
                          value: changeDestinationPreviewController
                              .stationName.value,
                          items:
                              stationList!.map((item) => item.name!).toList(),
                          labelText: 'Select New Destination',
                          onChanged: (value) {
                            changeDestinationPreviewController
                                .stationName.value = value!;
                          }),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Obx(
            () => (!changeDestinationPreviewController.isLoading.value &&
                    changeDestinationPreviewController
                        .isChangeDestinationPossible.value &&
                    changeDestinationPreviewController
                        .changeDestinationPreviewData.isNotEmpty)
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.defaultSpace),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total to be Paid'),
                        Text(
                          '\u{20B9}${changeDestinationPreviewController.totalAmount.value.toString()}/-',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ),
          Obx(
            () => Column(
              children: [
                if (changeDestinationPreviewController.isLoading.value)
                  const ShimmerEffect(width: double.infinity, height: 60),
                if (!changeDestinationPreviewController.isLoading.value &&
                    !changeDestinationPreviewController
                        .isChangeDestinationPreviewChecked.value)
                  ProceedToPayBtn(
                    btnText: 'Submit',
                    onPressed: () {
                      changeDestinationPreviewController
                          .changeDestinationPreview();
                    },
                  ),
                if (!changeDestinationPreviewController.isLoading.value &&
                    changeDestinationPreviewController
                        .isChangeDestinationPossible.value)
                  ProceedToPayBtn(
                    btnText: 'Proceed to Pay',
                    onPressed: () {
                      Navigator.pop(context);
                      changeDestinationPreviewController
                          .getChangeDestinationConfirm();
                    },
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  bool isTicketSelected(int index) {
    var ticketId = _getTicketId(index);
    return ChangeDestinationPreviewController.instance.checkBoxValue
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
    ChangeDestinationPreviewController.instance.checkBoxValue.clear();

    for (var index = 0; index < tickets!.length; index++) {
      var ticketId = _getTicketId(index);
      ChangeDestinationPreviewController.instance.checkBoxValue.add(ticketId);
    }
  }

  void _toggleTicketSelection(int index) {
    var ticketId = _getTicketId(index);

    if (ChangeDestinationPreviewController.instance.checkBoxValue
        .contains(ticketId)) {
      ChangeDestinationPreviewController.instance.checkBoxValue
          .remove(ticketId);
    } else {
      ChangeDestinationPreviewController.instance.checkBoxValue.add(ticketId);
    }
  }

  bool _isDestinationChangable(int index) {
    return ChangeDestinationPreviewController
            .instance.changeDestinationPreviewData[index].returnCode ==
        '0';
  }

  dynamic _getTicketId(int index) {
    return tickets![index].ticketId;
  }
}
