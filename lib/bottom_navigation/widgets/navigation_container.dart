import 'package:flutter/material.dart';
import 'package:tsavaari/bottom_navigation/model/navigation_model.dart';
import 'package:tsavaari/bottom_navigation/widgets/navigation_btn.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/t_icons.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

final List<BottomNavigationModel> navigationList = [
  BottomNavigationModel(
      id: '1', active: true, icon: 'home', targetPageIndex: 0, title: 'Home'),
  // BottomNavigationModel(
  //     id: '2',
  //     active: true,
  //     icon: 'history',
  //     targetPageIndex: 1,
  //     title: 'History'),
  BottomNavigationModel(
      id: '3',
      active: true,
      icon: 'order',
      targetPageIndex: 1,
      title: 'Orders'),
  BottomNavigationModel(
      id: '4',
      active: true,
      icon: 'user',
      targetPageIndex: 2,
      title: 'Profile'),
];

class NavigationContainer extends StatelessWidget {
  const NavigationContainer(
      {super.key, required this.currentIndex, required this.onPressed});

  final int currentIndex;
  final Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: TDeviceUtils.getScreenWidth(context) * .1,
          right: TDeviceUtils.getScreenWidth(context) * .1,
          bottom: TSizes.md),
      child: Material(
        color: Colors.transparent,
        elevation: TSizes.sm,
        borderRadius: BorderRadius.circular(TSizes.borderRadiusXL),
        child: Container(
          width: TDeviceUtils.getScreenWidth(context),
          height: TDeviceUtils.getScreenWidth(context) * .15,
          decoration: BoxDecoration(
            color: TColors.primary,
            borderRadius: BorderRadius.circular(TSizes.borderRadiusXL),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: navigationList
                .map(
                  (navigationItem) => NavigationBtn(
                    icon: TIcons.getIcon(navigationItem.icon),
                    index: navigationItem.targetPageIndex,
                    currentIndex: currentIndex,
                    onPressed: onPressed,
                    text: navigationItem.title,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
