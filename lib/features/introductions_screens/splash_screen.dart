import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
import 'package:sheek_bazar/core/utils/app_colors.dart';
import 'package:sheek_bazar/features/introductions_screens/on_boarding_screens.dart';
import 'package:sheek_bazar/features/suppliers/HomeScreenForSupllier/presentation/pages/home_supplier_screen.dart';
import 'package:sheek_bazar/sections_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemesCubit, ThemesState>(
      builder: (context, theme) {
        return AnimatedSplashScreen(
          splash: Column(
            children: [
              Image.asset(
                'assets/images/icon.png',
                width: 100,
                height: 100,
                color: theme.mode == "dark" ? AppColors.whiteColor : null,
              ),
              const Text(
                "Sheek Bazar",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              )
            ],
          ),
          nextScreen: FutureBuilder<SharedPreferences>(
            future: SharedPreferences.getInstance(),
            builder: (BuildContext context,
                AsyncSnapshot<SharedPreferences> snapshot) {
              if (snapshot.hasData) {
                var token = snapshot.data?.getString('USER_ID');
                var userType = snapshot.data?.getString('USER_TYPE');
                if (token != null) {
                  return userType == "customer"
                      ? const SectionsScreen()
                      : const HomeSupplier();
                } else {
                  return const Onbording();
                }
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          backgroundColor: theme.mode == "dark"
              ? AppColors.primaryColor
              : AppColors.whiteColor,
          splashIconSize: 250,
          duration: 500,
          pageTransitionType: PageTransitionType.leftToRightWithFade,
          splashTransition: SplashTransition.sizeTransition,
          animationDuration: const Duration(seconds: 2),
        );
      },
    );
  }
}
