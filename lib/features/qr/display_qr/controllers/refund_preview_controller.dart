import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tsavaari/data/repositories/refund_qr/refund_qr_repository.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/utils/constants/merchant_id.dart';
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
  var apiArray = <Future<dynamic>>[];

  @override
  void onInit() {
    super.onInit();
    getRefundPreview();
  }

  Future<void> getRefundPreview() async {
    try {
      final token = await deviceStorage.read('token');
      isLoading.value = true;
      for (var ticketData in tickets) {
        apiArray.add(_refundQrRepository.refundPreview({
          "token": "$token",
          "ticketId": ticketData.ticketId,
          "rjtId": "",
          "passId": "",
          "merchantId": MerchantDetails.merchantId,
          "ltmrhlPurchaseId": "",
          "transactionType": "Refund",
          "refundQuoteId": ""
        }));
      }

      final response = await Future.wait(apiArray);
      refundPreviewData.assignAll(response);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //Remove loader
      isLoading.value = false;
    }
  }
}
