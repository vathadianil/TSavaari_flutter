import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tsavaari/data/repositories/metro_card/metro_card_repository.dart';
import 'package:tsavaari/features/card_reacharge/models/card_details_by_user_model.dart';
import 'package:tsavaari/features/card_reacharge/models/card_travel_history_model.dart';
import 'package:tsavaari/utils/popups/loaders.dart';
import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class MetroCardController extends GetxController {
  static MetroCardController get instance => Get.find();

  //variables
  final isCardDetailsLoading = false.obs;
  final isTravelHistoryLoading = false.obs;
  final cardTravelHistoryData = <CardTravelHistoryModel>[].obs;
  final cardDetailsByUser = <CardDetailsByUserModel>{}.obs;
  final _cardRepository = Get.put(MetroCardRepository());
  final userId = '336838';
  final carouselCurrentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMetroCardDetailsByUser();
  }

  //Update page navigation dots
  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }

  String getBankRequestDateTime() {
    final now = DateTime.now();
    final formattedDateTime = "${now.year.toString().padLeft(4, '0')}"
        "${now.month.toString().padLeft(2, '0')}"
        "${now.day.toString().padLeft(2, '0')}"
        "${now.hour.toString().padLeft(2, '0')}"
        "${now.minute.toString().padLeft(2, '0')}"
        "${now.second.toString().padLeft(2, '0')}";
    return formattedDateTime;
  }

  String getBankReferenceNumber(String cardNumber, String bankRequestDateTime) {
    final backRef = bankRequestDateTime + generateRandomNumber(6);
    return backRef;
  }

  String generateRandomNumber(int charLength) {
    if (charLength < 1) return '0';

    final random = Random();
    final min = pow(10, charLength - 1).toInt();
    final max = pow(10, charLength).toInt() - 1;

    return (min + random.nextInt(max - min + 1)).toString();
  }

  String getHash(String cardNumber, String bankRefNumber) {
    final base = (cardNumber + bankRefNumber).trim();

    // Convert the string to bytes (UTF-8)
    final bytes = utf8.encode(base);

    // Compute the SHA-256 hash
    final digest = sha256.convert(bytes);

    // Convert the hash to a hexadecimal string
    return digest.toString();
  }

  //Fetch Travel History
  Future<void> fetchMetroCardDetailsByUser() async {
    try {
      isCardDetailsLoading.value = true;
      cardDetailsByUser.clear();
      final cardDetails =
          await _cardRepository.getMetroCardDetailsByUser(userId);
      if (cardDetails.returnCode == '0' &&
          cardDetails.returnMessage == 'SUCCESS') {
        cardDetailsByUser.add(cardDetails);
      } else {
        throw 'Something went wrong. Please Try again later!';
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isCardDetailsLoading.value = false;
    }
  }

  //Fetch Travel History
  Future<void> fetchMetroCardTravelHistory() async {
    try {
      isTravelHistoryLoading.value = true;
      final travelHistory = await _cardRepository.getMetroCardTravelHistory();
      cardTravelHistoryData.assignAll(travelHistory);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isTravelHistoryLoading.value = false;
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
