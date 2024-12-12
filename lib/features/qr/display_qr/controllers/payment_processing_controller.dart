import 'package:get/get.dart';
import 'package:tsavaari/data/repositories/book_qr/book_qr_repository.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/station_list_controller.dart';
import 'package:tsavaari/features/qr/book_qr/models/create_order_model.dart';
import 'package:tsavaari/features/qr/display_qr/screens/display_qr.dart';
import 'package:tsavaari/utils/payment_gateway/cash_free.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class PaymentProcessingController extends GetxController {
  PaymentProcessingController(
      {required this.verifyPaymentData, required this.requestPayload});
  final CreateOrderModel verifyPaymentData;
  final Map<String, Object?> requestPayload;
  final bookQrRepository = Get.put(BookQrRepository());
  final stationController = Get.put(StationListController());
  var verifyApiCounter = 0;
  final isPaymentVerifing = false.obs;
  final hasVerifyPaymentSuccess = false.obs;
  final cashFreePaymentController = Get.put(CashFreeController());

  @override
  void onInit() {
    super.onInit();
    verifyOrder();
  }

  Future<void> verifyOrder() async {
    try {
      isPaymentVerifing.value = true;
      //Retry limit reached
      if (verifyApiCounter == 2) {
        hasVerifyPaymentSuccess.value = false;
      } else {
        //calling verify payment after second
        Future.delayed(const Duration(seconds: 10), () async {
          try {
            final verifyPayment =
                await bookQrRepository.verifyPayment(verifyPaymentData.orderId);
            if (verifyPayment.orderStatus == 'PAID') {
              isPaymentVerifing.value = true;
              generateTicket();
            } else {
              verifyApiCounter++;
              verifyOrder();
            }
          } catch (e) {
            isPaymentVerifing.value = false;
            hasVerifyPaymentSuccess.value = false;
            TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
          }
        });
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> generateTicket() async {
    try {
      final ticketData = await bookQrRepository.generateTicket(requestPayload);

      //Navigate to Dispaly QR Page
      if (ticketData.returnCode == '0' && ticketData.returnMsg == 'SUCESS') {
        //Stop Loading

        Get.offAll(() => DisplayQrScreen(
              tickets: ticketData.tickets!,
              stationList: stationController.stationList,
              orderId: ticketData.orderId!,
            ));
      } else {
        final refundOrderResponse =
            await cashFreePaymentController.createRefundOrder(
                verifyPaymentData.orderId!, verifyPaymentData.orderAmount!);
        if (refundOrderResponse.cfPaymentId != null &&
            refundOrderResponse.cfRefundId != null) {
          final getRefundStatus =
              await cashFreePaymentController.getRefundStatus(
                  verifyPaymentData.orderId!, refundOrderResponse.refundId!);
          if (getRefundStatus.refundStatus == 'SUCCESS') {
          } else if (getRefundStatus.refundStatus == 'PENDING') {}
        }
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
