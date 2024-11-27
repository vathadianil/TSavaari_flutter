import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/authentication/models/user_model.dart';
import 'package:tsavaari/utils/exceptions/platform_exceptions.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  //-- Function to fetch user data from  db

  Future<UserModel?> fetchUserDetails() async {
    try {
      // code call api service to fecth data
      return null;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please Try again later!';
    }
  }

  //-- Function to update user data in  db
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
// code call api service to update data
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please Try again later!';
    }
  }

  //Upload Image
  Future<String?> uploadImage(String path, XFile image) async {
    try {
      //code to upload image
      return null;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please Try again later!';
    }
  }
}
