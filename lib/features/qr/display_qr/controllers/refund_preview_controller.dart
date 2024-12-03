import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tsavaari/bottom_navigation/bottom_navigation_menu.dart';
import 'package:tsavaari/data/repositories/refund_qr/refund_qr_repository.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/merchant_id.dart';
import 'package:tsavaari/utils/helpers/network_manager.dart';
import 'package:tsavaari/utils/popups/full_screen_loader.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class RefundPreviewController extends GetxController {
  RefundPreviewController({
    required this.tickets,
  });
  static RefundPreviewController get instance => Get.find();

  RxList radioSelectedValue = [].obs;
  List<TicketsListModel> tickets;
  final deviceStorage = GetStorage();
  final isLoading = false.obs;
  final _refundQrRepository = Get.put(RefundQrRepository());
  final refundPreviewData = [].obs;
  final refundConfirmData = [].obs;
  var apiArray = <Future<dynamic>>[];
  RxDouble totalRefunAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getRefundPreview();
  }

  Future<void> getRefundPreview() async {
    try {
      final token = await deviceStorage.read('token');
      refundPreviewData.clear();

      for (var index = 0; index < tickets.length; index++) {
        Future.delayed(Duration(seconds: index), () async {
          isLoading.value = true;
          final response = await _refundQrRepository.refundPreview({
            "token": "$token",
            "ticketId": (tickets[index].ticketType == 'SJT' ||
                    tickets[index].ticketTypeId == 10)
                ? tickets[index].ticketId
                : '',
            "rjtId": (tickets[index].ticketType == 'RJT' ||
                    tickets[index].ticketTypeId == 20)
                ? (tickets[index].rjtID ?? tickets[index].rjtId)
                : '',
            "passId": "",
            "merchantId": MerchantDetails.merchantId,
            "ltmrhlPurchaseId": "",
            "transactionType": "",
            "refundQuoteId": ""
          });
          refundPreviewData.add(response);
          if (index == tickets.length - 1) {
            isLoading.value = false;
          }
        });
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //Remove loader
      isLoading.value = false;
    }
  }

  Future<void> getRefundConfirm() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Processing your request', TImages.trainAnimation);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //Stop Loading
        TFullScreenLoader.stopLoading();
        TLoaders.customToast(message: 'No Internet Connection');
        return;
      }

      final token = await deviceStorage.read('token') ?? '';

      if (token == '') {
        //Stop Loading
        TFullScreenLoader.stopLoading();
        TLoaders.customToast(
            message: 'Your session expired!. Please Login again');
        return;
      }

      //Creating refund order

      // final refundOrderPayload = {
      //   "order_id": "string",
      //   "refund_amount": 0,
      //   "refund_id": "string",
      //   "refund_note": "string",
      //   "refund_speed": "STANDARD"
      // };

      var refundQuoteIdList = [];
      for (var index = 0; index < tickets.length; index++) {
        if (tickets[index].ticketType == 'RJT' ||
            tickets[index].ticketTypeId == 20) {
          refundQuoteIdList.addIf(
              radioSelectedValue.contains(refundPreviewData[index].rjtId),
              refundPreviewData[index].refundQuoteId);
        } else {
          refundQuoteIdList.addIf(
              radioSelectedValue.contains(refundPreviewData[index].ticketid),
              refundPreviewData[index].refundQuoteId);
        }
      }
      for (var index = 0; index < radioSelectedValue.length; index++) {
        apiArray.add(_refundQrRepository.refundConfirm({
          "token": "$token",
          "ticketId": (tickets[index].ticketType == 'SJT' ||
                  tickets[index].ticketTypeId == 10)
              ? radioSelectedValue[index]
              : '',
          "rjtId": (tickets[index].ticketType == 'RJT' ||
                  tickets[index].ticketTypeId == 20)
              ? radioSelectedValue[index]
              : '',
          "passId": "",
          "merchantId": MerchantDetails.merchantId,
          "ltmrhlPurchaseId": "",
          "transactionType": "107",
          "refundQuoteId": refundQuoteIdList[index]
        }));
      }

      final response = await Future.wait(apiArray);
      refundConfirmData.assignAll(response);

      //Stop Loading
      TFullScreenLoader.stopLoading();
      var isSuccess = true;
      for (var refundStatus in response) {
        if (refundStatus.returnCode != '0') {
          isSuccess = false;
        }
      }
      TLoaders.successSnackBar(
          title: 'Success', message: 'Your tickets have been refunded');
      if (isSuccess) {
        Get.offAll(() => const BottomNavigationMenu());
      }
    } catch (e) {
      //Stop Loading
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
