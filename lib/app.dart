import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/bindings/general_bindings.dart';
import 'package:tsavaari/routes/app_routes.dart';
import 'package:tsavaari/utils/constants/api_constants.dart';
// import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindings(),
      getPages: AppRoutes.pages,

      //Show Loader or circular progress indicator meanwhile authentication service is
      //deciding to show releveant screen
      home: Scaffold(
        // backgroundColor: TColors.primary,
        body: Center(
          child: Image(
            fit: BoxFit.cover,
            image: NetworkImage(
              ApiEndPoint.splashImageUrl,
            ),
          ),
        ),
      ),
    );
  }
}
