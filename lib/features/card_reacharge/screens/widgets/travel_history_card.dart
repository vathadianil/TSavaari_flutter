import 'package:flutter/material.dart';
import 'package:tsavaari/common/widgets/shapes/circle_shape.dart';
import 'package:tsavaari/common/widgets/shapes/dashed_vertical_line.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class TravelHistoryCard extends StatelessWidget {
  const TravelHistoryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        TSizes.sm,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.md),
        color: isDark ? TColors.dark : TColors.light,
        border: Border.all(
          width: 1,
          color: isDark ? TColors.darkerGrey : TColors.grey,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '24 Nov 2024',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: TSizes.sm,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Deducted Amt. ',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        '\u{20B9}100/-',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(fontSize: 22),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.sm,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.md, vertical: TSizes.sm),
                    decoration: BoxDecoration(
                      color: isDark ? TColors.darkContainer : TColors.white,
                      borderRadius: BorderRadius.circular(TSizes.lg),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Balance',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(
                          width: TSizes.sm,
                        ),
                        Text(
                          '\u{20B9}900/-',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleShape(
                            borderWidth: 2,
                            width: 12,
                            height: 12,
                          ),
                          SizedBox(
                            width: TSizes.sm,
                          ),
                          SizedBox(
                            width: 80,
                            child: Text(
                              'Nagole',
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: TSizes.spaceBtwSections + 3,
                      ),
                      Row(
                        children: [
                          CircleShape(
                            borderWidth: 2,
                            width: 12,
                            height: 12,
                            fillColor: TColors.dark,
                          ),
                          SizedBox(
                            width: TSizes.sm,
                          ),
                          SizedBox(
                            width: 80,
                            child: Text(
                              'Uppal',
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    top: 15,
                    left: 6,
                    child: CustomPaint(
                      size: Size(3, 38),
                      painter:
                          DashedLineVerticalPainter(color: TColors.darkGrey),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       '24 Nov 2024',
      //       style: Theme.of(context).textTheme.labelLarge,
      //     ),
      //     Row(
      //       children: [
      //         const Column(
      //           children: [
      //             CircleShape(
      //               borderWidth: 2,
      //               width: 12,
      //               height: 12,
      //             ),
      //             SizedBox(
      //               height: TSizes.sm,
      //             ),
      //             Text('Nagole'),
      //           ],
      //         ),
      //         Flexible(
      //             child: Column(
      //           children: [
      //             Text(
      //               '\u{20B9}30/-',
      //               style: Theme.of(context).textTheme.displaySmall,
      //             ),
      //             const Divider(),
      //             Container(
      //               padding: const EdgeInsets.symmetric(
      //                   horizontal: TSizes.md, vertical: TSizes.sm),
      //               decoration: BoxDecoration(
      //                 color: isDark
      //                     ? TColors.darkContainer
      //                     : TColors.white,
      //                 borderRadius: BorderRadius.circular(TSizes.lg),
      //               ),
      //               child: Row(
      //                 mainAxisSize: MainAxisSize.min,
      //                 children: [
      //                   Text(
      //                     'Balance',
      //                     style: Theme.of(context).textTheme.labelSmall,
      //                   ),
      //                   const SizedBox(
      //                     width: TSizes.sm,
      //                   ),
      //                   Text(
      //                     '\u{20B9}900/-',
      //                     style: Theme.of(context).textTheme.bodyLarge,
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         )),
      //         Column(
      //           children: [
      //             CircleShape(
      //               borderWidth: 2,
      //               width: 12,
      //               height: 12,
      //             ),
      //             SizedBox(
      //               height: TSizes.sm,
      //             ),
      //             Text('Uppal'),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}
