import 'package:flutter/material.dart';
import 'package:tsavaari/common/widgets/layout/max_width_container.dart';
import 'package:tsavaari/common/widgets/layout/t_grid_layout.dart';
import 'package:tsavaari/common/widgets/text/t_section_heading.dart';
import 'package:tsavaari/features/home/models/metro_services_model.dart';
import 'package:tsavaari/features/home/screens/widgets/header_section_container.dart';
import 'package:tsavaari/features/home/screens/widgets/home_app_bar.dart';
import 'package:tsavaari/features/home/screens/widgets/image_slider.dart';
import 'package:tsavaari/features/home/screens/widgets/service_cards.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = TDeviceUtils.getScreenHeight();
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final List<MetroServicesModel> servicesList = [
      MetroServicesModel(
        id: '1',
        active: true,
        icon: 'qrcode',
        title: 'Book\nTicket',
        targetScreen: '/book-qr',
      ),
      MetroServicesModel(
        id: '2',
        active: true,
        icon: 'card',
        title: 'Card\nRecharge',
        targetScreen: '/card-recharge',
      ),
      MetroServicesModel(
        id: '3',
        active: true,
        icon: 'fare',
        title: 'Fare\nCalculator',
        targetScreen: '/fare-calculator',
      ),
      MetroServicesModel(
        id: '4',
        active: true,
        icon: 'facilities',
        title: 'Station\nFacilities',
        targetScreen: '/station-facilities',
      ),
      MetroServicesModel(
        id: '5',
        active: true,
        icon: 'map',
        title: 'Metro\nMap',
        targetScreen: '/metro-network-map',
      ),
      MetroServicesModel(
        id: '6',
        active: true,
        icon: 'media',
        title: 'Follow\nUs',
        targetScreen: '/media',
      ),
    ];

    List<MetroServicesModel> getActiveServiceList() {
      final activeServices =
          servicesList.where((service) => service.active).toList();
      return activeServices;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Appbar
            const HeaderSectionContainer(
              child: Padding(
                padding: EdgeInsets.only(bottom: TSizes.spaceBtwSections),
                child: HomeAppBar(),
              ),
            ),

            //Body
            MaxWidthContaiiner(
              child: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    const ImageSlider(
                      autoPlay: true,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),

                    //Heading

                    const TSectionHeading(
                      title: TTexts.metroServicesSectionHeading,
                      showActionBtn: false,
                      padding: EdgeInsets.only(left: 0),
                    ),

                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),

                    // Services Grid
                    GridLayout(
                      itemCount: getActiveServiceList().length,
                      mainAxisExtent: screenHeight * .15,
                      crossAxisCount: 3,
                      mainAxisSpacing: TSizes.gridViewSpacing,
                      crossAxisSpacing: screenWidth * .08,
                      itemBuilder: (BuildContext context, int index) {
                        final activeServiceList = getActiveServiceList();
                        return ServiceCards(
                          service: activeServiceList[index],
                        );
                      },
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections * 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
