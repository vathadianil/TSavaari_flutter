import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tsavaari/data/repositories/book_qr/station_list_repository.dart';
import 'package:tsavaari/features/authentication/screens/login/login.dart';
import 'package:tsavaari/features/qr/book_qr/models/station_list_model.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class StationListController extends GetxController {
  static StationListController get instance => Get.find();

//Variables
  final isLoading = true.obs;
  final stationListRepository = Get.put(StationListRepository());
  final deviceStorage = GetStorage();
  RxList<StationListModel> stationList = <StationListModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getStationList();
  }

  Future<void> getStationList() async {
    try {
      //Show loader while loading categories
      isLoading.value = true;
      final token = await deviceStorage.read('token') ?? '';

      if (token != '') {
        final stationsData =
            await stationListRepository.fetchStationList(token);
        stationList
            .assignAll(stationsData.stations as Iterable<StationListModel>);
        final stationListMap =
            stationList.map((station) => station.toJson()).toList();
        String jsonStringStationListMap = jsonEncode(stationListMap);
        await deviceStorage.write('stationList', jsonStringStationListMap);
      } else {
        TLoaders.errorSnackBar(
            title: 'Oh Snap!',
            message: 'Your Session has expired!. Please Login Again.');
        Get.offAll(
          () => const LoginScreen(),
        );
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //Remove loader
      isLoading.value = false;
    }
  }
}
