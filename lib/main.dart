import 'package:recipes/app/modules/front/front_page.dart';
import 'package:recipes/app/routes/app_pages.dart';
import 'package:recipes/app/theme/theme.dart';
import 'package:recipes/app/utils/sizer/responsive_sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]).then(
    (_) {
      runApp(
        ResponsiveSizer(
          builder: (context, orientation, deviceType) {
            return GetMaterialApp(
              title: "Recipes",
              getPages: AppPages.pages,
              home: FrontPage(),
              theme: lightTheme,
              themeMode: ThemeMode.light,
              locale: Get.deviceLocale,
            );
          },
        ),
      );
    },
  );
}
