import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

import 'package:flex_color_scheme/flex_color_scheme.dart';

var flexScheme = FlexScheme.blue;
void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      theme: FlexColorScheme.light(
        scheme: flexScheme,
        // Use comfortable on desktops instead of compact, devices use default.
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        //fontFamily: AppFonts.mainFont,
        typography: Typography.material2018(),
      ).toTheme,
      darkTheme: FlexColorScheme.dark(
        scheme: flexScheme,
        // Use comfortable on desktops instead of compact, devices use default.
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        //fontFamily: AppFonts.mainFont,
      ).toTheme,
      themeMode: ThemeMode.light,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
