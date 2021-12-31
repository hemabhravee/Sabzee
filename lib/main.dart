import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

import 'package:flex_color_scheme/flex_color_scheme.dart';

var flexScheme = FlexScheme.blue;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyCTYDfR3CbX1UeFbz156HODM4fPIoZGLJM",
    appId: "1:92509623539:android:0c204b1141415771f85386",
    messagingSenderId: "92509623539",
    projectId: "sabzi-8394b",
  ));
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
