import 'package:flutter/material.dart';
import '../../core/utils/app_colors.dart';

ThemeData appTheme(String languageCode) {
  return ThemeData(
    useMaterial3: false,
    dividerTheme: const DividerThemeData(
      color: Color.fromARGB(31, 0, 0, 0),
    ),
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: AppColors.whiteColor),
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: const Color.fromARGB(249, 0, 0, 0).asMaterialColor),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
    ),
    primaryColor: AppColors.primaryColor,
    hintColor: AppColors.primaryColor,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
    scaffoldBackgroundColor: AppColors.whiteColor,
    fontFamily: languageCode == "en" ? 'Source Sans 3' : 'Vazirmatn',
    appBarTheme: const AppBarTheme(
      color: AppColors.whiteColor,
      titleTextStyle:
          TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor),
      iconTheme: IconThemeData(color: AppColors.primaryColor),
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
      floatingLabelStyle: const TextStyle(color: AppColors.primaryColor),
      suffixIconColor: AppColors.primaryColor,
      prefixIconColor: AppColors.primaryColor,
      fillColor: AppColors.whiteColor,
      filled: true,
      isDense: true,
      labelStyle: TextStyle(
        fontFamily: languageCode == "en" ? 'Source Sans 3' : 'Vazirmatn',
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      enabledBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
    ),
  );
}

ThemeData darkTheme(String languageCode) {
  return ThemeData(
    useMaterial3: false,
    brightness: Brightness.dark,
    dividerTheme: const DividerThemeData(
      color: AppColors.whiteColor,
    ),
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: AppColors.primaryColor),
    colorScheme: const ColorScheme.dark(
        secondary: AppColors.whiteColor,

        //////////////
        surface: Colors.white,
        primary: Colors.white),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
    ),
    primaryColor: AppColors.whiteColor,
    hintColor: AppColors.whiteColor,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
    fontFamily: languageCode == "en" ? 'Source Sans 3' : 'Vazirmatn',
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade900,
      // color: Colors.grey.shade900,
      iconTheme: const IconThemeData(color: AppColors.whiteColor),
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
      floatingLabelStyle: const TextStyle(color: Colors.white),
      suffixIconColor: AppColors.whiteColor,
      prefixIconColor: AppColors.whiteColor,
      fillColor: Colors.black,
      filled: true,
      isDense: true,
      labelStyle: TextStyle(
          fontFamily: languageCode == "en" ? 'Source Sans 3' : 'Vazirmatn',
          color: Colors.white),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}
