import 'package:flutter/material.dart';
import 'package:tsavaari/features/station_facilities/models/dummy_facilities_model.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class NearByFacilities extends StatelessWidget {
  const NearByFacilities({
    super.key,
    required this.nearbyFacilitiesList,
  });

  final List<DummyNearbyFaciliteis> nearbyFacilitiesList;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return SizedBox(
      height: 100,
      child: ListView.separated(
        itemCount: nearbyFacilitiesList.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(TSizes.sm),
                decoration: BoxDecoration(
                  color: isDark ? TColors.dark : TColors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: isDark ? TColors.darkGrey : TColors.accent,
                      blurRadius: TSizes.md,
                      offset: const Offset(0, TSizes.sm),
                    ),
                  ],
                ),
                child: Image(
                  image: AssetImage(nearbyFacilitiesList[index].imageUrl),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
              SizedBox(
                width: 70,
                child: Text(
                  textAlign: TextAlign.center,
                  nearbyFacilitiesList[index].title,
                  style: Theme.of(context).textTheme.labelSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: TSizes.spaceBtwItems,
          );
        },
      ),
    );
  }
}
