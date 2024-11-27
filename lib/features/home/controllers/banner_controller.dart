import 'package:get/get.dart';
import 'package:tsavaari/data/repositories/banner/banner_repository.dart';
import 'package:tsavaari/features/home/models/banner_model.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  //Variables
  final _bannerRepository = Get.put(BannerRepository());
  final carouselCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<BannerModel> bannersList = <BannerModel>[].obs;

  //Update page navigation dots
  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }

  //Fetch banners
  Future<void> fetchBanners() async {
    try {
      //Show loader while loading categories
      isLoading.value = true;

      final banners = await _bannerRepository.getAllBanners();
      bannersList.assignAll(banners);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //Remove loader
      isLoading.value = false;
    }
  }
}
