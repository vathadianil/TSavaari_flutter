import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/common/widgets/dropdown/t_dropdown.dart';
import 'package:tsavaari/common/widgets/text/t_section_heading.dart';
import 'package:tsavaari/features/home/screens/widgets/header_section_container.dart';
import 'package:tsavaari/features/qr/book_qr/controllers/station_list_controller.dart';
import 'package:tsavaari/features/station_facilities/models/dummy_facilities_model.dart';
import 'package:tsavaari/features/station_facilities/screens/widgets/nearby_station_facilities.dart';
import 'package:tsavaari/features/station_facilities/screens/widgets/within_station_facilities.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/loaders/shimmer_effect.dart';

class StationFacilitiesScreen extends StatelessWidget {
  const StationFacilitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nearbyFacilitiesList = [
      const DummyNearbyFaciliteis(
          title: 'Shuttle Service', imageUrl: TImages.shuttleService),
      const DummyNearbyFaciliteis(
          title: 'Vehicle Parking', imageUrl: TImages.parking),
      const DummyNearbyFaciliteis(
          title: 'Neighbourhood Areas', imageUrl: TImages.neighbourhoodArea),
      const DummyNearbyFaciliteis(
          title: 'Bus Stops', imageUrl: TImages.busStops),
      const DummyNearbyFaciliteis(
          title: 'Catchment Areas', imageUrl: TImages.catchmentArea),
    ];

    final stationFacilities = [
      const DummyStationFaciliteis(
        title: 'Platform Information',
        subtitle:
            'Platfrom No 1 \nTowrds Raidurg \nPlatform No 2 \nTowards Nagole.',
        imageUrl: TImages.platform,
      ),
      const DummyStationFaciliteis(
        title: 'Metro Timings',
        subtitle:
            'Hyderabad Metro Rail is operational from 06:00AM to 11:00PM. The first train starts at 06:00AM and last train departs at 11:00PM from all terminal stations.',
        imageUrl: TImages.metroTiming,
      ),
      const DummyStationFaciliteis(
        title: 'Elevators/Lifts',
        subtitle: 'Available at Street level near B and D Gates',
        imageUrl: TImages.elevator,
      ),
      const DummyStationFaciliteis(
        title: 'Escalators',
        subtitle: 'Available at Street level near A and C Gates',
        imageUrl: TImages.escalators,
      ),
      const DummyStationFaciliteis(
        title: 'First Aid Room',
        subtitle: 'Available at Concourse level near B Gate',
        imageUrl: TImages.firstAid,
      ),
      const DummyStationFaciliteis(
        title: 'Free Drinking Water',
        subtitle: 'Available at Concourse level near A and D Gates',
        imageUrl: TImages.drinkingWater,
      ),
      const DummyStationFaciliteis(
        title: 'Washrooms',
        subtitle: 'Available at Concourse level near A and C Gates',
        imageUrl: TImages.washRoom,
      ),
    ];
    final controller = Get.put(StationListController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeaderSectionContainer(
              child: Image(
                image: AssetImage(TImages.stationFaciliteisHeroImg),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                TSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  //--Drop down to select station
                  Obx(
                    () => controller.isLoading.value
                        ? const ShimmerEffect(
                            width: double.infinity,
                            height: 50,
                          )
                        : TDropdown(
                            value: '',
                            items: controller.stationList
                                .map((item) => item.name!)
                                .toList(),
                            labelText: 'Choose Station',
                            showLeadingIcon: true,
                            onChanged: (value) {},
                          ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  //--Near by stion facilities
                  const TSectionHeading(
                    title: 'Near by Facilities',
                    showActionBtn: false,
                    padding: EdgeInsets.all(0),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  NearByFacilities(nearbyFacilitiesList: nearbyFacilitiesList),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  //--With in stion facilities
                  const TSectionHeading(
                    title: 'Station Facilities',
                    showActionBtn: false,
                    padding: EdgeInsets.all(0),
                  ),

                  WithinStationFacilities(stationFacilities: stationFacilities)
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: TSizes.appBarHeight / 2),
        child: SizedBox(
          width: 36,
          height: 36,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {
                Get.back();
              },
              backgroundColor: TColors.black,
              shape: const CircleBorder(),
              child: const Icon(
                Iconsax.arrow_left,
                color: TColors.white,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
