import 'package:get/get.dart';
import 'package:tsavaari/features/home/screens/home.dart';
import 'package:tsavaari/features/my_orders/my_orders.dart';
import 'package:tsavaari/features/profile/profile.dart';
import 'package:tsavaari/features/travel_history/travel_history.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();
  final Rx<int> selectedIndex = 0.obs;
  final right = 5.0.obs;
  final top = (TDeviceUtils.getScreenHeight() * 0.65).obs;
  final screens = [
    const HomeScreen(),
    const TravelHistoryScreen(),
    const MyOrdersScreen(),
    const ProfileScreen()
  ];

  void onDestinationSelectionChange(int index) {
    selectedIndex.value = index;
  }
}
