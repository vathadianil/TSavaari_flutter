import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/qr/display_qr/models/refund_preview_model.dart';
import 'package:tsavaari/utils/constants/api_constants.dart';
import 'package:tsavaari/utils/http/http_client.dart';

class RefundQrRepository extends GetxController {
  Future<RefundPreviewModel> refundPreview(payload) async {
    try {
      final data = await THttpHelper.post(
        ApiEndPoint.refundPreview,
        payload,
      );

      return RefundPreviewModel.fromJson(data);
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code).message!;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }
}
