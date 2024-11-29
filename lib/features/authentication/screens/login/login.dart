import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/widgets/images/rounded_corner_image.dart';
import 'package:tsavaari/features/authentication/controllers/login_controller.dart';
import 'package:tsavaari/features/authentication/screens/login/widgets/form_divider.dart';
import 'package:tsavaari/features/authentication/screens/login/widgets/redirect_to_signup.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';

import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      body: SizedBox(
        height: TDeviceUtils.getScreenHeight(),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SafeArea(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: TSizes.tabletSize),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: TSizes.appBarHeight,
                        left: TSizes.defaultSpace,
                        right: TSizes.defaultSpace,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // -- Logo
                          const Image(
                            width: 100,
                            image: AssetImage(TImages.appLogo),
                          ),

                          const SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),
                          //--Heading

                          Text(
                            TTexts.loginTitle,
                            style: Theme.of(context).textTheme.headlineLarge,
                            textScaler: TextScaler.linear(
                                ScaleSize.textScaleFactor(context)),
                          ),

                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),

                          Text(
                            TTexts.loginSubTitle,
                            style: Theme.of(context).textTheme.bodyMedium,
                            textScaler: TextScaler.linear(
                                ScaleSize.textScaleFactor(context)),
                          ),

                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          //--Login Form

                          TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: TTexts.phoneNo,
                              prefixIcon: Icon(
                                Icons.call,
                                color: TColors.primary,
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.login(context);
                              },
                              child: Text(
                                TTexts.signIn,
                                textScaler: TextScaler.linear(
                                    ScaleSize.textScaleFactor(context)),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: TColors.white,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),

                          const FormDivider(dividerText: TTexts.dividerText),

                          //Sign Up Redirect
                          const RedirectToSignUp(),
                        ],
                      ),
                    ),
                    const RoundedCornerImage(
                      isNetworkImage: false,
                      imageUrl: TImages.loginBanner,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
