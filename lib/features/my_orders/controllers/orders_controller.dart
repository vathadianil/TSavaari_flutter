import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tsavaari/data/repositories/my_orders/my_orders_repository.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/utils/constants/merchant_id.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class OrdersController extends GetxController {
  static OrdersController get instance => Get.find();
  //Variables
  final isLoading = true.obs;
  final deviceStorage = GetStorage();
  final activeTickets = <ActiveTicketModel>{}.obs;
  final _myOrdersRepository = Get.put(MyOrdersRepository());

  @override
  void onInit() {
    super.onInit();
    getActiveTickets();
  }

  Future<void> getActiveTickets() async {
    try {
      //Show loader while loading categories
      isLoading.value = true;
      final token = await deviceStorage.read('token');

      final payload = {
        "patornPhoneNumber": "9999999999",
        "merchantId": MerchantDetails.merchantId,
        "selectMonthYear": "",
        "authorization": token
      };
      if (token != null) {
        final activeTicketData =
            await _myOrdersRepository.fetchActiveTickets(payload);
        if (activeTickets.isNotEmpty) {
          activeTickets.clear();
        }

        if (activeTicketData.ticketHistory != null) {
          activeTickets.add(activeTicketData);
        }
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //Remove loader
      isLoading.value = false;
    }
  }

  Future<void> getPastTickets() async {
    try {
      //Show loader while loading categories
      isLoading.value = true;
      final token = await deviceStorage.read('token');

      final payload = {
        "patornPhoneNumber": "9999999999",
        "merchantId": MerchantDetails.merchantId,
        "selectMonthYear": "",
        "authorization": token
      };
      if (token != null) {
        final activeTicketData =
            await _myOrdersRepository.fetchPastTickets(payload);
        if (activeTickets.isNotEmpty) {
          activeTickets.clear();
        }

        if (activeTicketData.ticketHistory != null) {
          activeTickets.add(activeTicketData);
        }
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //Remove loader
      isLoading.value = false;
    }
  }
}
