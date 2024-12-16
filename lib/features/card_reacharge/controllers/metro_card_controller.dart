import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tsavaari/data/repositories/metro_card/metro_card_repository.dart';
import 'package:tsavaari/features/card_reacharge/models/card_details_by_user_model.dart';
import 'package:tsavaari/features/card_reacharge/models/card_travel_history_model.dart';
import 'package:tsavaari/features/card_reacharge/models/card_trx_details_model.dart';
import 'package:tsavaari/features/card_reacharge/models/last_recharge_status_model.dart';
import 'package:tsavaari/utils/constants/card_recharge_utils.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/helpers/network_manager.dart';
import 'package:tsavaari/utils/popups/full_screen_loader.dart';
import 'package:tsavaari/utils/popups/loaders.dart';
import 'dart:convert';

class MetroCardController extends GetxController {
  static MetroCardController get instance => Get.find();

  //variables
  final isCardDetailsLoading = false.obs;
  final isTravelHistoryLoading = false.obs;
  final isLastRcgStatusLoading = false.obs;
  final isCardTrxLoading = false.obs;
  final cardTravelHistoryData = <CardTravelHistoryModel>[].obs;
  final cardDetailsByUser = <CardDetailsByUserModel>{}.obs;
  final lastRcgStatus = <LastRechargeStatusModel>{}.obs;
  final cardTrxListData = <CardTrxListModel>[].obs;
  final _cardRepository = Get.put(MetroCardRepository());
  final userId = '336838';
  final carouselCurrentIndex = 0.obs;
  final cardHolderName = TextEditingController();
  final cardNumber = TextEditingController();

  GlobalKey<FormState> cardAddOrUpdateFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchMetroCardDetailsByUser();
  }

  //Update page navigation dots
  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }

  //Fetch Card Details
  Future<void> fetchMetroCardDetailsByUser() async {
    try {
      isCardDetailsLoading.value = true;
      cardDetailsByUser.clear();
      final cardDetails =
          await _cardRepository.getMetroCardDetailsByUser(userId);
      if (cardDetails.returnCode == '0') {
        cardDetailsByUser.add(cardDetails);
        fetchCardLastTrasactionStatus(cardDetails.cardDetails![0].cardNo!);
        fetchCardTransactionDetails(cardDetails.cardDetails![0].cardNo!);
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isCardDetailsLoading.value = false;
    }
  }

  //Add or update card
  Future<void> addOrUpdateCardDetailsByUser(String type) async {
    try {
      final cardId = type == 'add'
          ? 0
          : cardDetailsByUser.first.cardDetails![carouselCurrentIndex.value].id;
      final cardNo = type == 'add'
          ? cardNumber.text
          : cardDetailsByUser
              .first.cardDetails![carouselCurrentIndex.value].cardNo;
      final cardDesc = cardHolderName.text;

      //Form Validation
      if (!cardAddOrUpdateFormKey.currentState!.validate()) {
        return;
      }

      //Loading
      TFullScreenLoader.openLoadingDialog(
          'Validating. Please Wait....', TImages.trainAnimation);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //Stop Loading
        TFullScreenLoader.stopLoading();
        TLoaders.customToast(message: 'No Internet Connection');
        return;
      }

      final payload = {
        "id": cardId,
        "userID": userId,
        "cardNo": cardNo,
        "cardDesc": cardDesc
      };
      final response =
          await _cardRepository.addOrUpdateCardDetailsByUser(payload);
      if (response.returnCode == '0') {
        TFullScreenLoader.stopLoading();
        //Removing Dialog
        TFullScreenLoader.stopLoading();

        TLoaders.successSnackBar(
          title: 'Success!',
          message: type == 'add'
              ? 'Card Details added succesfully'
              : 'Card Details updated succesfully',
        );

        //Fetching cards from server
        fetchMetroCardDetailsByUser();
      } else {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
          title: 'Oh Snap!',
          message: type == 'add'
              ? 'Unable to add card Details.Please try again later!'
              : 'Unable to add card Details.Please try again later!',
        );
      }
      //Stop Loading
      // TFullScreenLoader.stopLoading();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: type == 'add'
            ? 'Unable to add card Details.Please try again later!'
            : 'Unable to add card Details.Please try again later!',
      );
    }
  }

  //Add or update card
  Future<void> deleteCardDetailsByUser() async {
    try {
      //Loading
      TFullScreenLoader.openLoadingDialog(
          'Validating. Please Wait....', TImages.trainAnimation);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //Stop Loading
        TFullScreenLoader.stopLoading();
        TLoaders.customToast(message: 'No Internet Connection');
        return;
      }

      final cardId =
          cardDetailsByUser.first.cardDetails![carouselCurrentIndex.value].id;

      final response = await _cardRepository.deleteCardDetailsByUser(cardId);

      if (response.returnCode == '0') {
        TFullScreenLoader.stopLoading();

        TLoaders.successSnackBar(
          title: 'Success!',
          message: 'Card Details Deleted succesfully',
        );
        fetchMetroCardDetailsByUser();
      } else {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
          title: 'Oh Snap!',
          message: 'Unable to Delete card details.Please try again later!',
        );
      }
      //Stop Loading
      TFullScreenLoader.stopLoading();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
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

  // void copyTextToClipboard(String text) async {
  //   const String textToCopy = '2244325454543654365435';

  //   if (textToCopy.isNotEmpty) {
  //     try {
  //       await Clipboard.setData(const ClipboardData(text: textToCopy));
  //     } catch (e) {
  //       TLoaders.errorSnackBar(title: 'Failed to Copy to Clipboard');
  //     }
  //   }
  // }

  Future<void> fetchCardLastTrasactionStatus(String cardNumber) async {
    try {
      // Create the plain credentials
      isLastRcgStatusLoading.value = true;
      String plainCredentials = CardRechargeUtils.plainCredentials;

      // Encode to Base64
      String base64Credentials = base64Encode(utf8.encode(plainCredentials));
      String authorizationHeader = "Basic $base64Credentials";

      // Generate required data
      String bankRequestDateTime = CardRechargeUtils.getBankRequestDateTime();
      String bankRefNumber = CardRechargeUtils.getBankReferenceNumber(
          cardNumber, bankRequestDateTime);

      String bankCode = CardRechargeUtils.bankCode;
      String hash = CardRechargeUtils.getHash(cardNumber, bankRefNumber);

      // Prepare the request body
      Map<String, String> payload = {
        "TicketEngravedID": cardNumber,
        "BankCode": bankCode,
        "BankReferenceNumber": bankRefNumber,
        "Hash": hash,
      };

      // Prepare the HTTP headers
      Map<String, String> headers = {
        "Authorization": authorizationHeader,
        "Content-Type": "application/json",
      };

      // Make the POST request
      lastRcgStatus.clear();
      final response = await _cardRepository.getLastTransactionDetailsByCard(
          payload, headers);
      lastRcgStatus.add(response);
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error', message: 'Failed to fetch last recharge status');
    } finally {
      isLastRcgStatusLoading.value = false;
    }
  }

  Future<void> fetchCardTransactionDetails(String cardNumber) async {
    try {
      // Create the plain credentials
      isCardTrxLoading.value = true;
      String plainCredentials = CardRechargeUtils.plainCredentials;

      // Encode to Base64
      String base64Credentials = base64Encode(utf8.encode(plainCredentials));
      String authorizationHeader = "Basic $base64Credentials";

      // Generate required data
      String bankCode = CardRechargeUtils.bankCode;
      String hash = CardRechargeUtils.getHash(cardNumber, bankCode);

      // Prepare the request body
      Map<String, String> payload = {
        "TicketEngravedID": cardNumber,
        "BankCode": bankCode,
        "Hash": hash,
      };

      // Prepare the HTTP headers
      Map<String, String> headers = {
        "Authorization": authorizationHeader,
        "Content-Type": "application/json",
      };

      // Make the POST request
      cardTrxListData.clear();

      final response =
          await _cardRepository.getCardTrxDetails(payload, headers);

      cardTrxListData
          .assignAll(response.response as Iterable<CardTrxListModel>);
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error', message: 'Failed to Fetch Card transaction history');
    } finally {
      isCardTrxLoading.value = false;
    }
  }
}
