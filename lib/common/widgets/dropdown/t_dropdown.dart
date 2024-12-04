import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class TDropdown extends StatelessWidget {
  const TDropdown({
    super.key,
    this.width = 400,
    this.height = 50,
    this.value,
    required this.items,
    required this.labelText,
    required this.onChanged,
    this.showLeadingIcon = false,
    this.labelColor,
  });

  final double width;
  final double height;
  final String? value;
  final List<String> items;
  final String labelText;
  final ValueChanged<String?> onChanged;
  final bool showLeadingIcon;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return DropdownSearch<String>(
      autoValidateMode: AutovalidateMode.always,
      filterFn: (item, filter) {
        return item.toLowerCase().startsWith(filter.toLowerCase());
      },
      selectedItem: value,
      dropdownButtonProps: DropdownButtonProps(
        icon: const Icon(Iconsax.arrow_circle_down4),
        color: dark ? TColors.accent : TColors.primary,
      ),
      popupProps: PopupProps.dialog(
        showSearchBox: true,
        showSelectedItems: true,
        isFilterOnline: false,
        searchDelay: const Duration(milliseconds: 100),
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: "Search...",
            hintStyle: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: dark ? TColors.grey : TColors.darkGrey),
            prefixIcon: Icon(
              Icons.search,
              size: TSizes.md,
              color: dark ? TColors.grey : TColors.darkGrey,
            ),
          ),
        ),
        containerBuilder: (context, child) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(TSizes.sm),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(TSizes.sm),
                color: dark ? TColors.dark : TColors.light,
                boxShadow: [
                  BoxShadow(
                    color: dark
                        ? TColors.light.withOpacity(0.3)
                        : TColors.grey.withOpacity(0.3),
                    blurRadius: 5,
                    spreadRadius: 7,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: child,
            ),
          );
        },
        itemBuilder: (context, item, isSelected) {
          return Container(
            padding: const EdgeInsets.symmetric(
              vertical: TSizes.defaultSpace / 2,
              horizontal: TSizes.defaultSpace,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: .5,
                  color: dark
                      ? TColors.darkContainer
                      : TColors.dark.withOpacity(.1),
                ),
              ),
            ),
            child: Text(
              item,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        },
      ),
      items: items,
      dropdownDecoratorProps: DropDownDecoratorProps(
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.left,
        dropdownSearchDecoration: InputDecoration.collapsed(
          hintText: labelText,
        ),
      ),
      dropdownBuilder: (context, selectedItem) => Row(
        children: [
          const SizedBox(
            width: TSizes.defaultSpace,
          ),
          if (showLeadingIcon)
            const Icon(
              Iconsax.location,
              size: TSizes.md,
            ),
          if (showLeadingIcon)
            const SizedBox(
              width: TSizes.xs,
            ),
          Text(
            selectedItem = selectedItem != '' ? selectedItem! : labelText,
            style: selectedItem != ''
                ? Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: labelColor)
                : Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: labelColor),
          ),
        ],
      ),
      onChanged: onChanged,
    );
  }
}
