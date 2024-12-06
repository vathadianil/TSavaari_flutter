import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tsavaari/data/repositories/book_qr/book_qr_repository.dart';
import 'package:tsavaari/features/fare_calculator/models/fare_calculation_model.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/station_list_controller.dart';
import 'package:tsavaari/features/qr/book_qr/models/qr_get_fare_model.dart';
import 'package:tsavaari/features/qr/display_qr/screens/display_qr.dart';
import 'package:tsavaari/routes/routes.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/merchant_id.dart';
import 'package:tsavaari/utils/constants/ticket_status.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/helpers/network_manager.dart';
import 'package:tsavaari/utils/local_storage/storage_utility.dart';
import 'package:tsavaari/utils/popups/full_screen_loader.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class BookQrController extends GetxController {
  static BookQrController get instance => Get.find();

  //variables
  final isLoading = false.obs;
  final ticketType = false.obs;
  final passengerCount = 1.obs;
  final source = ''.obs;
  final destination = ''.obs;
  final deviceStorage = GetStorage();
  final bookQrRepository = Get.put(BookQrRepository());
  final stationController = StationListController.instance;
  final qrFareData = <QrGetFareModel>{}.obs;
  final fareCalculationData = <FareCalculationModel>{}.obs;

  Future<void> getFare() async {
    try {
      final token = await TLocalStorage().readData('token');

      final ticketTypeId = ticketType.value
          ? TicketStatus.ticketTypeRjt.toString()
          : TicketStatus.ticketTypeSjt.toString();

      final fromStation = source.value != ''
          ? THelperFunctions.getStationFromStationName(
              source.value, stationController.stationList)
          : null;

      final fromStationId = fromStation?.stationId;

      final toStation = destination.value != ''
          ? THelperFunctions.getStationFromStationName(
              destination.value, stationController.stationList)
          : null;
      final toStationId = toStation?.stationId;

      if (token == null ||
          token == '' ||
          fromStationId == null ||
          fromStationId == '' ||
          toStationId == null ||
          toStationId == '') {
        return;
      }

      if (fromStationId == toStationId) {
        TLoaders.errorSnackBar(
            title: 'Invalid Inut!',
            message: 'Origin and Desitnation station should be diffrent');
        return;
      }

      isLoading.value = true;

      if (Get.currentRoute == Routes.bookQr) {
        final payload = {
          "token": "$token",
          "fromStationId": fromStationId,
          "merchant_id": MerchantDetails.merchantId,
          "ticketTypeId": ticketTypeId, //SJT = 10 RJT=20
          "toStationId": toStationId,
          "travelDatetime": "${DateTime.now()}",
          "zoneNumberOrStored_ValueAmount": 0 //STATIC VALUE
        };
        final fareData = await bookQrRepository.fetchFare(payload);
        if (qrFareData.isNotEmpty) {
          qrFareData.clear();
        }
        qrFareData.add(fareData);
      } else if (Get.currentRoute == Routes.fareCalculator) {
        final payload = {
          "fromStation": source.value,
          "ticketTypeId": ticketTypeId, //SJT = 10 RJT=20
          "toStation": destination.value,
        };
        final data = await bookQrRepository.fetchFareCalculationData(payload);

        if (fareCalculationData.isNotEmpty) {
          fareCalculationData.clear();
        }
        if (data.r!.isEmpty) {
          TLoaders.errorSnackBar(
              title: 'Oh Snap!',
              message: 'Something went wrong. Please try again later');
          return;
        }
        fareCalculationData.add(data);
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //Remove loader
      isLoading.value = false;
    }
  }

  Future<void> generateTicket() async {
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

      String platformCode = TDeviceUtils.getPlatfromString();

      final payload = {
        "customer_details": {
          "customer_id": "CUSTID123",
          "customer_email": "abc@gmail.com",
          "customer_phone": "9999999999",
          "customer_name": "abcds"
        },
        "order_meta": {
          "return_url": "https://www.cashfree.com/devstudio/thankyou",
          "notify_url":
              "https://122.252.226.254:5114/api/v1/NotifyUrl/CFPaymentRequest"
        },
        "order_id": "SAL$platformCode${DateTime.now().millisecondsSinceEpoch}",
        "order_amount": (passengerCount.value * qrFareData.first.finalFare!),
        "order_currency": "INR",
        "order_note": "some order note here"
      };

      final createOrderData =
          await bookQrRepository.createQrPaymentOrder(payload);

      final session = CFSessionBuilder()
          .setEnvironment(CFEnvironment.SANDBOX)
          .setOrderId(createOrderData.orderId!)
          .setPaymentSessionId(createOrderData.paymentSessionId!)
          .build();

      final cfWebCheckout =
          CFWebCheckoutPaymentBuilder().setSession(session).build();
      final cfPaymentGateWay = CFPaymentGatewayService();
      cfPaymentGateWay.setCallback((orderId) async {
        try {
          final verifyPayment = await bookQrRepository.verifyPayment(orderId);

          if (verifyPayment.orderStatus == 'PAID') {
            final token = await deviceStorage.read('token');
            final ticketTypeId = ticketType.value
                ? TicketStatus.ticketTypeRjt.toString()
                : TicketStatus.ticketTypeSjt.toString();

            final fromStation = source.value != ''
                ? stationController.stationList
                    .firstWhere((station) => station.name == source.value)
                : null;

            final fromStationId = fromStation?.stationId;

            final toStation = destination.value != ''
                ? stationController.stationList
                    .firstWhere((station) => station.name == destination.value)
                : null;
            final toStationId = toStation?.stationId;

            final requestPayload = {
              "token": "$token",
              "merchantOrderId": verifyPayment.orderId,
              "merchantId": MerchantDetails.merchantId,
              "transType": "0",
              "fromStationId": fromStationId,
              "toStationid": toStationId,
              "ticketTypeId": ticketTypeId,
              "noOfTickets": passengerCount.value,
              "travelDateTime": "${DateTime.now()}",
              "merchantEachTicketFareBeforeGst": 0,
              "merchantEachTicketFareAfterGst": 0,
              "merchantTotalFareBeforeGst": 0,
              "merchantTotalCgst": 0,
              "merchantTotalSgst": 0,
              "merchantTotalFareAfterGst": 0,
              "ltmrhlPassId": "",
              "patronPhoneNumber": "9999999999",
              "fareQuoteIdforOneTicket":
                  "${qrFareData.first.fareQuotIdforOneTicket}",
            };

            final ticketData =
                await bookQrRepository.generateTicket(requestPayload);

            //Stop Loading
            TFullScreenLoader.stopLoading();

            //Navigate to Dispaly QR Page
            if (ticketData.returnCode == '0' &&
                ticketData.returnMsg == 'SUCESS') {
              Get.offAll(() => DisplayQrScreen(
                    tickets: ticketData.tickets!,
                    stationList: stationController.stationList,
                    orderId: ticketData.orderId!,
                  ));
            } else {
              throw 'Something went wrong. Please try again later!';
            }
          }
        } catch (e) {
          TFullScreenLoader.stopLoading();
          TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
        }
      }, (p0, orderId) {
        //Stop Loading
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
            title: 'Oh Snap!', message: p0.getMessage().toString());
      });
      cfPaymentGateWay.doPayment(cfWebCheckout);
    } on CFException catch (e) {
      //Stop Loading
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } catch (e) {
      //Stop Loading
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
