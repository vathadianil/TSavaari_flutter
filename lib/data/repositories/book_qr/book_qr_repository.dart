import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/fare_calculator/models/fare_calculation_model.dart';
import 'package:tsavaari/features/qr/book_qr/models/create_order_model.dart';
import 'package:tsavaari/features/qr/book_qr/models/qr_get_fare_model.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/utils/constants/api_constants.dart';
import 'package:tsavaari/utils/http/http_client.dart';

class BookQrRepository extends GetxController {
  static BookQrRepository get instance => Get.find();
  Future<QrGetFareModel> fetchFare(payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.getFare,
        payload,
      );

      return QrGetFareModel.fromJson(data);
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code).message!;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<CreateOrderModel> createQrPaymentOrder(payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.createQrPaymentOrder,
        payload,
      );
      return CreateOrderModel.fromJson(data);
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code).message!;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<CreateOrderModel> verifyPayment(orderId) async {
    try {
      final data = await THttpHelper.get(
        '${ApiEndPoint.verifyPayment}/$orderId',
      );
      return CreateOrderModel.fromJson(data);
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code).message!;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<QrTicketModel> generateTicket(payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.generateTicket,
        payload,
      );
      return QrTicketModel.fromJson(data);
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code).message!;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<FareCalculationModel> fetchFareCalculationData(payload) async {
    try {
      final data = await THttpHelper.get(
          '${ApiEndPoint.getFareCalculation + payload['fromStation']}&toStation=${payload['toStation']}',
          newUrl: false);
      return FareCalculationModel.fromJson(data);
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code).message!;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }
}