import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/qr/book_qr/models/station_list_model.dart';
import 'package:tsavaari/utils/constants/api_constants.dart';
import 'package:tsavaari/utils/http/http_client.dart';

class StationListRepository extends GetxController {
  Future<StationDataModel> fetchStationList(String token) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.getStations,
        {"token": token},
      );

      return StationDataModel.fromJson(data);
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code).message!;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }
}
