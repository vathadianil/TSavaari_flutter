import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/card_reacharge/models/card_details_by_user_model.dart';
import 'package:tsavaari/features/card_reacharge/models/card_travel_history_model.dart';
import 'package:tsavaari/utils/constants/api_constants.dart';
import 'package:tsavaari/utils/exceptions/format_exceptions.dart';
import 'package:tsavaari/utils/exceptions/platform_exceptions.dart';
import 'package:tsavaari/utils/http/http_client.dart';

class MetroCardRepository extends GetxController {
  static MetroCardRepository get instance => Get.find();

  Future<CardDetailsByUserModel> getMetroCardDetailsByUser(userId) async {
    try {
      final data = await THttpHelper.get(
        '${ApiEndPoint.getCardDetailsByUser}$userId',
      );
      return CardDetailsByUserModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<CardDetailsByUserModel> addOrUpdateCardDetailsByUser(payload) async {
    try {
      final data =
          await THttpHelper.post(ApiEndPoint.addOrUpdateCardDetails, payload);
      return CardDetailsByUserModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<CardDetailsByUserModel> deleteCardDetailsByUser(payload) async {
    try {
      final data =
          await THttpHelper.delete('${ApiEndPoint.deleteCard}$payload');
      return CardDetailsByUserModel.fromJson(data);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<List<CardTravelHistoryModel>> getMetroCardTravelHistory() async {
    try {
      final list = [
        CardTravelHistoryModel(
            fromStation: 'Hi Tech City',
            toStation: 'Nagole',
            travelDateTime: '20240715',
            dDCTAmount: '55',
            reminingBalance: '593'),
        CardTravelHistoryModel(
            fromStation: 'Nagole',
            toStation: 'Hi Tech City',
            travelDateTime: '20240712',
            dDCTAmount: '55',
            reminingBalance: '648'),
      ].toList();

      return list;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }
}
