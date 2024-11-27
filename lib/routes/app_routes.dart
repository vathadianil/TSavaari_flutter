import 'package:get/get.dart';
import 'package:tsavaari/features/fare_calculator/screens/fare_calculator.dart';
import 'package:tsavaari/features/metro_network_map/screens/network_map.dart';
import 'package:tsavaari/features/qr/book_qr/screens/book_qr.dart';
import 'package:tsavaari/features/card_reacharge/screens/card_reachage.dart';
import 'package:tsavaari/features/station_facilities/screens/station_facilities.dart';
import 'package:tsavaari/routes/routes.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: Routes.bookQr, page: () => const BookQrScreen()),
    GetPage(
        name: Routes.cardReacharge, page: () => const CardReachargeScreen()),
    GetPage(
        name: Routes.fareCalculator, page: () => const FareCalculatorScreen()),
    GetPage(name: Routes.metroNetworkMap, page: () => const NetworkMapScreen()),
    GetPage(
        name: Routes.stationFacilities,
        page: () => const StationFacilitiesScreen()),
  ];
}
