import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tsavaari/data/repositories/authentication/authenticaion_repository.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/helpers/network_manager.dart';
import 'package:tsavaari/utils/popups/full_screen_loader.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  //Variables
  final deviceStorage = GetStorage();

  Future<void> login(context) async {
    try {
      //Loading
      TFullScreenLoader.openLoadingDialog(
          'Logging you in',
          THelperFunctions.isDarkMode(context)
              ? TImages.trainAnimationDark
              : TImages.trainAnimationLight);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //Stop Loading
        TFullScreenLoader.stopLoading();
        TLoaders.customToast(message: 'No Internet Connection');
        return;
      }

      //Form Validation
      // if (!loginFormKey.currentState!.validate()) {
      //   //Stop Loading
      //   TFullScreenLoader.stopLoading();
      //   return;
      // }

      //Login user using email and password authentication
      final token = await AuthenticationRepository.instance.login();
      await deviceStorage.write('token', token.accessToken);

      //Stop Loading
      TFullScreenLoader.stopLoading();

      //Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (error) {
      //Stop Loading
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: error.toString());
    }
  }

  Future<void> logout(context) async {
    try {
      //Loading
      TFullScreenLoader.openLoadingDialog(
          'Logging you out',
          THelperFunctions.isDarkMode(context)
              ? TImages.trainAnimationDark
              : TImages.trainAnimationLight);
      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //Stop Loading
        TFullScreenLoader.stopLoading();
        TLoaders.customToast(message: 'No Internet Connection');
        return;
      }

      //remove token
      await deviceStorage.remove('token');

      //Stop Loading
      TFullScreenLoader.stopLoading();

      //Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (error) {
      //Stop Loading
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: error.toString());
    }
  }
}
