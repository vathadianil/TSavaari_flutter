import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/utils/constants/api_constants.dart';
import 'package:tsavaari/utils/http/http_client.dart';

class MyOrdersRepository extends GetxController {
  Future<ActiveTicketModel> fetchActiveTickets(payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.getActiveTickets,
        payload,
        newUrl: false,
      );
      print(
          '-----------------------------------------------------------------------');
      print(data);
      return ActiveTicketModel.fromJson(data);
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code).message!;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }

  Future<ActiveTicketModel> fetchPastTickets(payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.getPastTickets,
        payload,
        newUrl: false,
      );
      return ActiveTicketModel.fromJson(data);
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code).message!;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }
}
