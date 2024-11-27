import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/card_reacharge/models/card_travel_history_model.dart';

class MetroCardRepository extends GetxController {
  static MetroCardRepository get instance => Get.find();

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
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code).message!;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }
}
