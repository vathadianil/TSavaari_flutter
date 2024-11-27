import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tsavaari/bottom_navigation/bottom_navigation_menu.dart';
import 'package:tsavaari/features/authentication/models/token_model.dart';
import 'package:tsavaari/features/authentication/screens/login/login.dart';
import 'package:tsavaari/utils/constants/api_constants.dart';
import 'package:tsavaari/utils/http/http_client.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //Variables
  final deviceStorage = GetStorage();

  //Called from app.dart on app launch
  @override
  void onReady() {
    super.onReady();
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  //Function show relevant screen
  screenRedirect() {
    final token = deviceStorage.read('token');
    if (token != null) {
      Get.offAll(() => const BottomNavigationMenu());
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }

  Future<TokenModel> login() async {
    try {
      final data = await THttpHelper.get(
        ApiEndPoint.getToken,
      );
      return TokenModel.fromJson(data);
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code).message!;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }
}
