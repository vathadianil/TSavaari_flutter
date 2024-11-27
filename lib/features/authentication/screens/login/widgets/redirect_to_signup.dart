import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class RedirectToSignUp extends StatelessWidget {
  const RedirectToSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          TTexts.signUpText,
          softWrap: true,
          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
          style: Theme.of(context).textTheme.labelSmall,
        ),
        TextButton(
          onPressed: () {},
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: dark ? TColors.accent : TColors.primary, width: 1),
              ),
            ),
            child: Text(
              TTexts.signUp,
              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(
                context,
              )),
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: dark ? TColors.accent : TColors.primary,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
