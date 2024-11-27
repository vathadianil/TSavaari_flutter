import 'package:flutter/material.dart';
import 'package:tsavaari/features/station_facilities/models/dummy_facilities_model.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class WithinStationFacilities extends StatelessWidget {
  const WithinStationFacilities({
    super.key,
    required this.stationFacilities,
  });

  final List<DummyStationFaciliteis> stationFacilities;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return ListView.separated(
      itemCount: stationFacilities.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              color: isDark ? TColors.dark : TColors.white,
              borderRadius: BorderRadius.circular(TSizes.md),
              boxShadow: [
                BoxShadow(
                    color: isDark ? TColors.darkGrey : TColors.grey,
                    blurRadius: TSizes.md)
              ]),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(stationFacilities[index].imageUrl),
            ),
            title: Padding(
              padding: const EdgeInsets.only(
                bottom: TSizes.spaceBtwItems / 2,
              ),
              child: Text(
                stationFacilities[index].title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            dense: true,
            subtitle: Text(
              stationFacilities[index].subtitle,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: TSizes.spaceBtwItems * 2,
        );
      },
    );
  }
}
