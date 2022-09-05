import 'package:biome/core/app_colors.dart';
import 'package:biome/splash/splash_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Biome",
      home: SplashPage(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: MaterialColor(AppColors.primaryGreen.value, {
          50: AppColors.primaryGreen,
          100: AppColors.primaryGreen,
          200: AppColors.primaryGreen,
          300: AppColors.primaryGreen,
          400: AppColors.primaryGreen,
          500: AppColors.primaryGreen,
          600: AppColors.primaryGreen,
          700: AppColors.primaryGreen,
          800: AppColors.primaryGreen,
          900: AppColors.primaryGreen,
        }),
      ),
    );
  }
}
