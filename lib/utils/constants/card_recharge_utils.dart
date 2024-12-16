import 'dart:math';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class CardRechargeUtils {
  static String plainCredentials = "HYDMetroMobileApp:MobileApp@HydMetro1234";
  static String bankCode = "05";

  static String getBankRequestDateTime() {
    final now = DateTime.now();
    final formattedDateTime = "${now.year.toString().padLeft(4, '0')}"
        "${now.month.toString().padLeft(2, '0')}"
        "${now.day.toString().padLeft(2, '0')}"
        "${now.hour.toString().padLeft(2, '0')}"
        "${now.minute.toString().padLeft(2, '0')}"
        "${now.second.toString().padLeft(2, '0')}";
    return formattedDateTime;
  }

  static String getBankReferenceNumber(
      String cardNumber, String bankRequestDateTime) {
    final backRef = bankRequestDateTime + generateRandomNumber(6);
    return backRef;
  }

  static String generateRandomNumber(int charLength) {
    if (charLength < 1) return '0';

    final random = Random();
    final min = pow(10, charLength - 1).toInt();
    final max = pow(10, charLength).toInt() - 1;

    return (min + random.nextInt(max - min + 1)).toString();
  }

  static String getHash(String cardNumber, String bankRefNumberOrBankCode) {
    final base = (cardNumber + bankRefNumberOrBankCode).trim();

    // Convert the string to bytes (UTF-8)
    final bytes = utf8.encode(base);

    // Compute the SHA-256 hash
    final digest = sha256.convert(bytes);

    // Convert the hash to a hexadecimal string
    return digest.toString();
  }
}
