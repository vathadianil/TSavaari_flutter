import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/home/models/banner_model.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  //Variables

  //Get all the banners
  Future<List<BannerModel>> getAllBanners() async {
    try {
      final list = [
        BannerModel(
            id: '1',
            active: true,
            imageUrl: TImages.banner1,
            targetScreen: '/'),
        BannerModel(
            id: '2',
            active: true,
            imageUrl: TImages.banner2,
            targetScreen: '/'),
        BannerModel(
            id: '3',
            active: true,
            imageUrl: TImages.banner3,
            targetScreen: '/'),
        BannerModel(
            id: '4',
            active: true,
            imageUrl: TImages.banner4,
            targetScreen: '/'),
        BannerModel(
            id: '5',
            active: true,
            imageUrl: TImages.banner5,
            targetScreen: '/'),
        BannerModel(
            id: '6',
            active: true,
            imageUrl: TImages.banner6,
            targetScreen: '/'),
        BannerModel(
            id: '7',
            active: true,
            imageUrl: TImages.banner7,
            targetScreen: '/'),
        BannerModel(
            id: '8',
            active: true,
            imageUrl: TImages.banner8,
            targetScreen: '/'),
      ].toList();
      // .map((data) => BannerModel.fromJson(data))
      return list;
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code).message!;
    } catch (e) {
      throw 'Something went wrong. Please try again later!';
    }
  }
}
