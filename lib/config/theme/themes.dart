import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../style/app_colors.dart';
import '../style/text_style.dart';

final ValueNotifier<ThemeMode> themeMode = ValueNotifier<ThemeMode>(ThemeMode.system);
changeTheme(ThemeMode newThemeMode){
  themeMode.value=newThemeMode;
}
class AppThemes {
  static ThemeData main({bool isDark = false}) {
    return ThemeData(
      useMaterial3: false,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor:Colors.white.withOpacity(.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        )
      ),

      primaryColor: AppColors.primary,
      primarySwatch: AppColors.primaryMaterialColor,
      brightness: isDark ? Brightness.dark : Brightness.light,
      fontFamily: AppTextStyles.fontFamily,
      scaffoldBackgroundColor: isDark ? Colors.black: Colors.white,
      appBarTheme: AppBarTheme(
        systemOverlayStyle:  SystemUiOverlayStyle(
          statusBarColor:isDark?Colors.black: Colors.white,
          statusBarIconBrightness:isDark?Brightness.light: Brightness.dark,
          // For Android (dark icons)
          statusBarBrightness:isDark?Brightness.dark: Brightness.light, // For iOS (dark icons)
        ),
        backgroundColor: isDark ? Colors.black: Colors.transparent,
        elevation: 0,
      ),

      shadowColor: isDark
          ? AppColors.white
          : AppColors.black.withOpacity(0.2),
      cardColor: isDark ? AppColors.blackLight : AppColors.white,

      textTheme: TextTheme(


        headline1: AppTextStyles.h1.copyWith(
          color: isDark ? AppColors.white : AppColors.black,
        ),
        headline2: AppTextStyles.h2.copyWith(
          color: isDark ? AppColors.white : AppColors.black,
        ),
        headline3: AppTextStyles.h3.copyWith(
          color: isDark ? AppColors.white : AppColors.black,
        ),
        headline4: AppTextStyles.h4.copyWith(
          color: isDark ? AppColors.white : AppColors.black,
        ),
        headline5: AppTextStyles.h5.copyWith(
          color: isDark ? AppColors.white : AppColors.black,
        ),
        bodyText1: AppTextStyles.bodyLg.copyWith(
          color: isDark ? AppColors.white : AppColors.black,
        ),
        bodyText2: AppTextStyles.body.copyWith(
          color: isDark ? AppColors.white : AppColors.black,
        ),
        subtitle1: AppTextStyles.bodySm.copyWith(
          color: isDark ? AppColors.white : AppColors.black,
        ),
      ),
    );
  }
}