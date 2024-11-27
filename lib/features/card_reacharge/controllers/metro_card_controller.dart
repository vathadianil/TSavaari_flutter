import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tsavaari/data/repositories/metro_card/metro_card_repository.dart';
import 'package:tsavaari/features/card_reacharge/models/card_travel_history_model.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class MetroCardController extends GetxController {
  static MetroCardController get instance => Get.find();

  //variables
  final isLoading = false.obs;
  final cardTravelHistoryData = <CardTravelHistoryModel>[].obs;
  final _cardRepository = Get.put(MetroCardRepository());

  //Fetch Travel History
  Future<void> fetchMetroCardTravelHistory() async {
    try {
      //Show loader while loading categories
      isLoading.value = true;
      final travelHistory = await _cardRepository.getMetroCardTravelHistory();
      cardTravelHistoryData.assignAll(travelHistory);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //Remove loader
      isLoading.value = false;
    }
  }

  void copyTextToClipboard(String text) async {
    const String textToCopy = '2244325454543654365435';

    if (textToCopy.isNotEmpty) {
      try {
        await Clipboard.setData(const ClipboardData(text: textToCopy));
      } catch (e) {
        TLoaders.errorSnackBar(title: 'Failed to Copy to Clipboard');
      }
    }
  }
}
