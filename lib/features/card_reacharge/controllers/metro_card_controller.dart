import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/data/repositories/metro_card/metro_card_repository.dart';
import 'package:tsavaari/features/card_reacharge/models/card_details_by_user_model.dart';
import 'package:tsavaari/features/card_reacharge/models/card_travel_history_model.dart';
import 'package:tsavaari/features/card_reacharge/models/card_trx_details_model.dart';
import 'package:tsavaari/features/card_reacharge/models/last_recharge_status_model.dart';
import 'package:tsavaari/features/card_reacharge/models/nebula_card_validation_model.dart';
import 'package:tsavaari/features/card_reacharge/models/sqs_details_model.dart';
import 'package:tsavaari/utils/helpers/card_recharge_utils.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/helpers/network_manager.dart';
import 'package:tsavaari/utils/popups/full_screen_loader.dart';
import 'package:tsavaari/utils/popups/loaders.dart';
import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;

class MetroCardController extends GetxController {
  static MetroCardController get instance => Get.find();

  //variables
  final isCardDetailsLoading = false.obs;
  final isTravelHistoryLoading = false.obs;
  final isLastRcgStatusLoading = false.obs;
  final isCardTrxLoading = false.obs;
  final isNebulaCardValidating = false.obs;
  final cardTravelHistoryData = <CardTravelHistoryModel>[].obs;
  final storeNebulaCardValidationDetails = <NebulaCardValidationModel>[].obs;
  final cardDetailsByUser = <CardDetailsByUserModel>{}.obs;
  final lastRcgStatus = <LastRechargeStatusModel>{}.obs;
  final cardTrxListData = <CardTrxListModel>[].obs;
  final _cardRepository = Get.put(MetroCardRepository());
  final userId = '336838';
  final carouselCurrentIndex = 0.obs;
  final cardHolderName = TextEditingController();
  final cardNumber = TextEditingController();
  final selectedTopupAmount = '0'.obs;

  GlobalKey<FormState> cardAddOrUpdateFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchMetroCardDetailsByUser();
  }

  //Update page navigation dots
  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
    if (!storeNebulaCardValidationDetails.asMap().containsKey(index)) {
      validateNebulaCard(
          cardDetailsByUser.first.cardDetails![index].cardNo!, 'fetch');
    }
  }

  //Fetch Card Details
  Future<void> fetchMetroCardDetailsByUser({callingfrom = 'fetch'}) async {
    try {
      isCardDetailsLoading.value = true;
      cardDetailsByUser.clear();
      final cardDetails =
          await _cardRepository.getMetroCardDetailsByUser(userId);
      if (cardDetails.returnCode == '0') {
        cardDetailsByUser.add(cardDetails);
        // fetchCardLastTrasactionStatus(cardDetails.cardDetails![0].cardNo!);
        // fetchCardTransactionDetails(cardDetails.cardDetails![0].cardNo!);
        if (callingfrom == 'fetch' || callingfrom == 'delete') {
          validateNebulaCard(cardDetails.cardDetails![0].cardNo!, callingfrom);
        }
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

      if (type == 'add') {
        final cardValidationData = await validateNebulaCard(cardNo!, 'add');
        if (cardValidationData!.nebulaCardValidationStatus == '03') {
          TFullScreenLoader.stopLoading();
          TLoaders.errorSnackBar(
              title: 'Error',
              message: cardValidationData.nebulaCardValidationMessage);
          return;
        } else {
          storeNebulaCardValidationDetails.insert(0, cardValidationData);
        }
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
        fetchMetroCardDetailsByUser(callingfrom: 'add');
      } else {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
          title: 'Oh Snap!',
          message: type == 'add'
              ? 'Unable to add card Details.Please try again later!'
              : 'Unable to add card Details.Please try again later!',
        );
      }
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

      final cardNo = cardDetailsByUser
          .first.cardDetails![carouselCurrentIndex.value].cardNo;

      final response =
          await _cardRepository.deleteCardDetailsByUser(userId, cardNo);

      if (response.returnCode == '0') {
        TFullScreenLoader.stopLoading();

        TLoaders.successSnackBar(
          title: 'Success!',
          message: 'Card Details Deleted succesfully',
        );
        carouselCurrentIndex.value = 0;
        storeNebulaCardValidationDetails.clear();
        fetchMetroCardDetailsByUser(callingfrom: 'delete');
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

  Future<NebulaCardValidationModel?> validateNebulaCard(
      String cardNumber, String callingfrom) async {
    try {
      // Create the plain credentials
      isNebulaCardValidating.value = true;
      // isCardDetailsLoading.value = true;

      final sqsDetails = await getSqsDetails();

      if (sqsDetails != null) {
        String accessToken = CardRechargeUtils.getDecryptedString(
            sqsDetails.samsungToken,
            CardRechargeUtils.cardValidationDecryptString);

        // Prepare the HTTP headers
        Map<String, String> headers = {
          "Authorization": accessToken,
          "Content-Type": "application/json",
        };

        // Generate required data
        String bankRequestDateTime =
            CardRechargeUtils.getBankRequestDateTimeForValidation();
        String bankRefNumber = CardRechargeUtils.getBankReferenceNumber(
            cardNumber, bankRequestDateTime);
        String hash = CardRechargeUtils.getHash(cardNumber, bankRefNumber);

        // Prepare the request body
        Map<String, String> payload = {
          "TicketEngravedID": cardNumber,
          "BankCode": CardRechargeUtils.bankCode,
          "BankReferenceNumber": bankRefNumber,
          'BankRequestDateTime': bankRequestDateTime,
          "TopUpChannel": CardRechargeUtils.topUpChannel,
          "Hash": hash,
        };
        // Make the POST request

        final response =
            await _cardRepository.validateNebulaCard(payload, headers);
        // if(response.nebulaCardValidationStatus == ''){

        // }
        if (callingfrom == 'fetch') {
          storeNebulaCardValidationDetails.insert(
              carouselCurrentIndex.value, response);
        } else if (callingfrom == 'delete') {
          storeNebulaCardValidationDetails.insert(0, response);
        }
        return response;
      } else {
        throw 'Failed to fetch Card validation details!';
      }
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error', message: 'Failed to fetch Card validation details');
    } finally {
      isNebulaCardValidating.value = false;
      // isCardDetailsLoading.value = false;
    }
    return null;
  }

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

  Future<SqsDetailsModel?> getSqsDetails() async {
    try {
      final data = await _cardRepository.getSqsDetails();
      String decryptedText = decryptAes(
          data['response'] as String, CardRechargeUtils.decryptAesKey);

      if (decryptedText.isNotEmpty) {
        // Parse decrypted JSON
        final Map<String, dynamic> obj = jsonDecode(decryptedText);

        String accessKey = obj['a'];
        String secret = obj['s'];
        String url = obj['u'];
        String samsungToken = obj['t'];

        if (accessKey.isNotEmpty && secret.isNotEmpty) {
          // Pass values to callback
          final sqlsDetails = SqsDetailsModel(
              accessKey: accessKey,
              secret: secret,
              url: url,
              samsungToken: samsungToken);
          return sqlsDetails;
        } else {
          throw ("Invalid credentials received.");
        }
      } else {
        throw ("Decryption failed.");
      }
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error', message: 'Something went wrong. Please Try again!');
    }
    return null;
  }

  String decryptAes(String encryptedText, String secretKey) {
    try {
      // Decode Base64-encoded encrypted text
      final encryptedBytes = base64Decode(encryptedText);

      // Convert the secret key to 16 bytes for AES-128 or 32 bytes for AES-256
      final key = encrypt.Key.fromUtf8(secretKey.padRight(32, ' '));
      final iv = encrypt.IV(Uint8List(16));

      // Set up the encrypter with AES in CBC mode and PKCS5 padding
      final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'),
      );

      // Decrypt the data
      final decrypted = encrypter.decryptBytes(
        encrypt.Encrypted(encryptedBytes),
        iv: iv,
      );
      return utf8.decode(decrypted);
    } catch (e) {
      throw "Decryption Error: $e";
    }
  }
}
