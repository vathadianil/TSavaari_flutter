import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsavaari/data/repositories/user/user_repository.dart';
import 'package:tsavaari/features/authentication/models/user_model.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  //Variables
  Rx<UserModel> user = UserModel.empty().obs;
  final isProfileLoading = false.obs;
  final isImageUploading = false.obs;
  final userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  //Fetch user record from db

  fetchUserRecord() async {
    try {
      isProfileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      isProfileLoading.value = false;
    }
  }

  //Upload image
  uploadProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );
      if (image != null) {
        isImageUploading.value = true;
        final imageUrl =
            await userRepository.uploadImage('Users/Images/Profile/', image);
        //Update user image record
        // Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        // await userRepository.updateSingleField(json);
        user.value.profilePicture = imageUrl!;
        user.refresh();
      }

      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Profile image has been updated');
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'OhSnap!', message: 'Something went Wrong. $e');
    } finally {
      isImageUploading.value = false;
    }
  }
}
