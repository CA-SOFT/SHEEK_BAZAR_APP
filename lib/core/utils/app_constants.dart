// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/Locale/cubit/locale_cubit.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
import 'package:sheek_bazar/core/utils/cache_helper.dart';
import 'package:sheek_bazar/features/auth/presentation/pages/sign_in.dart';
import 'package:sheek_bazar/features/contact_us/how_to_use_app_screen.dart';
import 'package:sheek_bazar/features/user/cart/presentation/pages/my_address.dart';
import 'package:sheek_bazar/features/user/profile/presentation/cubit/profile_cubit.dart';
import 'package:sheek_bazar/features/user/profile/presentation/pages/my_orders_screen.dart';
import '../../features/contact_us/contactUs_screen.dart';
import '../../features/contact_us/privacy.dart';
import '../../sections_screen.dart';
import '../../features/contact_us/term.dart';
import 'app_colors.dart';

class AppConstant {
  static customNavigation(
      BuildContext context, Widget screen, double x, double y) async {
    await Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(x, y),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return screen;
        },
      ),
    );
  }

  static customElvatedButton(
      BuildContext context, String title, Function onpress) {
    return SizedBox(
      height: 175.h,
      width: double.infinity,
      child: BlocBuilder<ThemesCubit, ThemesState>(
        builder: (context, theme) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(75.r),
            child: ElevatedButton(
                onPressed: () {
                  onpress();
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    theme.mode == "dark"
                        ? AppColors.whiteColor
                        : AppColors.primaryColor,
                  ),
                ),
                child: Text(
                  title.tr(context),
                  style: TextStyle(
                      color: theme.mode == "dark"
                          ? AppColors.primaryColor
                          : AppColors.whiteColor,
                      fontSize: 50.sp),
                )),
          );
        },
      ),
    );
  }

  static customLoadingElvatedButton(BuildContext context) {
    return SizedBox(
      height: 175.h,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(75.r),
        child: ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                AppColors.primaryColor,
              ),
            ),
            child: const CircularProgressIndicator(
              color: AppColors.whiteColor,
            )),
      ),
    );
  }

  static customSizedBox(double width, double height) {
    return SizedBox(
      width: width.w,
      height: height.h,
    );
  }

  static customDrawer(BuildContext context, {bool isGuest = false}) {
    return BlocBuilder<LocaleCubit, ChangeLocaleState>(
      builder: (context, state) {
        return BlocBuilder<ThemesCubit, ThemesState>(
          builder: (context, theme) {
            return Drawer(
              backgroundColor: theme.mode == "dark"
                  ? AppColors.primaryColor
                  : AppColors.whiteColor,
              surfaceTintColor: theme.mode == "dark"
                  ? AppColors.primaryColor
                  : AppColors.whiteColor,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  // Drawer header with logo
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: theme.mode == "dark"
                          ? AppColors.primaryColor
                          : Colors.white,
                    ),
                    child: Center(
                        child: Image.asset('assets/images/icon.png',
                            width: 100,
                            height: 100,
                            color: theme.mode == "dark"
                                ? AppColors.whiteColor
                                : null)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "change_language".tr(context),
                          style: TextStyle(
                            fontSize: 35.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        BlocBuilder<LocaleCubit, ChangeLocaleState>(
                          builder: (context, state) {
                            return DropdownButton<String>(
                                dropdownColor: theme.mode == "dark"
                                    ? AppColors.primaryColor
                                    : AppColors.whiteColor,
                                value: state.locale.languageCode,
                                items: ['ar', 'en', 'ku'].map((String items) {
                                  return DropdownMenuItem<String>(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    context
                                        .read<LocaleCubit>()
                                        .changeLanguage(newValue);
                                  }
                                });
                          },
                        )
                      ],
                    ),
                  ),
                  BlocBuilder<ThemesCubit, ThemesState>(
                    builder: (context, state) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "dark_mode".tr(context),
                              style: TextStyle(
                                fontSize: 35.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Switch(
                              activeColor: AppColors.whiteColor,
                              inactiveThumbColor: Colors.red,
                              value: theme.mode == "dark" ? true : false,
                              onChanged: (value) {
                                if (value == false) {
                                  context
                                      .read<ThemesCubit>()
                                      .changeMode("light");
                                } else {
                                  context
                                      .read<ThemesCubit>()
                                      .changeMode("dark");
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const Divider(),
                  ListTile(
                    title: Text(
                      'Home'.tr(context),
                      style: TextStyle(
                        fontSize: 35.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const SectionsScreen(),
                        ),
                      );
                      // AppConstant.customNavigation(
                      //     context, const SectionsScreen(), -1, 0);
                    },
                  ),
                  ListTile(
                    title: Text('my_orders'.tr(context),
                        style: TextStyle(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.bold,
                        )),
                    onTap: () {
                      Navigator.pop(context);
                      AppConstant.customNavigation(
                          context, const MyOrdersScreen(), -1, 0);
                    },
                  ),
                  ListTile(
                    title: Text('Shipping_address'.tr(context),
                        style: TextStyle(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.bold,
                        )),
                    onTap: () {
                      Navigator.pop(context);
                      AppConstant.customNavigation(
                          context,
                          MyAddressScreen(
                            fromProfile: true,
                          ),
                          -1,
                          0);
                    },
                  ),
                  ListTile(
                    title: Text('contact_us'.tr(context),
                        style: TextStyle(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.bold,
                        )),
                    onTap: () {
                      Navigator.pop(context);
                      AppConstant.customNavigation(
                          context, const ContactUsScreen(), -1, 0);
                    },
                  ),
                  ListTile(
                    title: Text('privacy'.tr(context),
                        style: TextStyle(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.bold,
                        )),
                    onTap: () {
                      Navigator.pop(context);
                      AppConstant.customNavigation(
                          context, const PrivactScreen(), -1, 0);
                    },
                  ),
                  ListTile(
                    title: Text('terms'.tr(context),
                        style: TextStyle(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.bold,
                        )),
                    onTap: () {
                      Navigator.pop(context);
                      AppConstant.customNavigation(
                          context, const TermsScreen(), -1, 0);
                    },
                  ),
                  ListTile(
                    title: Text('how_to_use'.tr(context),
                        style: TextStyle(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.bold,
                        )),
                    onTap: () {
                      Navigator.pop(context);
                      AppConstant.customNavigation(
                          context, const HowToUseAppScreen(), -1, 0);
                    },
                  ),

                  const Divider(),
                  ListTile(
                    title: Text(
                        isGuest ? 'log_in'.tr(context) : 'log_out'.tr(context),
                        style: TextStyle(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.bold,
                        )),
                    onTap: () async {
                      await CacheHelper.clearData(
                        key: "USER_NAME",
                      );
                      await CacheHelper.clearData(
                        key: "USER_ID",
                      );
                      await CacheHelper.clearData(
                        key: "CUSTOMER_ID",
                      );
                      await CacheHelper.clearData(
                        key: "REFERRAL_CODE",
                      );
                      await CacheHelper.clearData(
                        key: "SUPPLIER_ID",
                      );
                      await CacheHelper.clearData(
                        key: "USER_PASSWORD",
                      );
                      await CacheHelper.clearData(
                        key: "USER_PHONENUMBER",
                      );
                      await CacheHelper.clearData(
                        key: "ADDRESS_ID",
                      );
                      await CacheHelper.clearData(
                        key: "USER_TYPE",
                      );
                      context.read<ProfileCubit>().clearMyFavorite();

                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const SigninScreen()),
                        (Route route) => false,
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static customAppbar(
      BuildContext context, Widget title, List<Widget> actions, bool canBack) {
    return AppBar(
      iconTheme: IconThemeData(size: 75.sp),
      elevation: 5,
      toolbarHeight: 175.h,
      // surfaceTintColor: AppColors.whiteColor,
      // backgroundColor: AppColors.whiteColor,
      actions: actions,

      leading: canBack
          ? IconButton(
              icon: BlocBuilder<ThemesCubit, ThemesState>(
                builder: (context, state) {
                  return Icon(Icons.arrow_back,
                      size: 75.sp,
                      color:
                          state.mode == "dark" ? Colors.white : Colors.black);
                },
              ),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      centerTitle: true,
      title: title,
    );
  }

  Future<void> showOneSecondAlert(BuildContext context, String message) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        Timer(const Duration(seconds: 1), () => Navigator.pop(context));
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
            margin: EdgeInsets.only(top: 0.75.sh),
            decoration: BoxDecoration(
              color: Colors.red[400],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                message.tr(context),
                style: const TextStyle(color: AppColors.whiteColor),
              ),
            ),
          ),
        );
      },
    );
  }

  static customAlert(BuildContext context, String message,
      {bool withTranslate = true, bool witherror = true, int second = 1}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        Timer(Duration(seconds: second), () => Navigator.pop(context));
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.only(top: 0.75.sh),
              decoration: BoxDecoration(
                color: witherror ? Colors.red[400] : Colors.green,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  withTranslate ? message.tr(context) : message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.whiteColor),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static customNetworkImage({
    required String imagePath,
    String placeholder = "assets/images/placeholder.png",
    String imageError = "assets/images/placeholder.png",
    double? height,
    double? width,
    BoxFit? fit = BoxFit.fill,
  }) {
    return FadeInImage.assetNetwork(
      image: imagePath,
      fit: fit,
      height: height,
      width: width,
      placeholder: placeholder,
      imageErrorBuilder: (BuildContext context, x, u) =>
          customAssetImage(imagePath: imageError, width: width, height: height),
    );
  }

  static customAssetImage({
    required String imagePath,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    height,
    width,
    Color? color,
    BoxFit? fit = BoxFit.cover,
  }) {
    return Padding(
      padding: padding,
      child: Image.asset(
        imagePath,
        height: height?.toDouble(),
        color: color,
        width: width?.toDouble(),
        fit: fit,
      ),
    );
  }

  static Color getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  static customAddFavoriteIcon(
      {bool? fromFav, String? productId, String? userId}) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (userId != null) {
          if (fromFav!) {
            return const SizedBox();
            // const Icon(
            //   Icons.favorite,
            //   color: Colors.red,
            // );
          } else {
            if (state.myFavorite != null) {
              bool isFav = false;
              String favID = "";
              for (int i = 0;
                  i < state.myFavorite!.wishlistItems!.length;
                  i++) {
                if (state.myFavorite!.wishlistItems![i].productId ==
                    productId) {
                  isFav = true;
                  favID = state.myFavorite!.wishlistItems![i].id!;
                }
              }
              if (isFav) {
                return InkWell(
                  onTap: () {
                    context
                        .read<ProfileCubit>()
                        .deleteFromMyFavorite(context, favID);
                  },
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                );
              } else {
                return InkWell(
                  onTap: fromFav
                      ? () {}
                      : () {
                          context
                              .read<ProfileCubit>()
                              .insertToMyFavorite(context, productId!);
                        },
                  child: const Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                );
              }
            } else {
              return InkWell(
                onTap: productId == null
                    ? () {}
                    : () {
                        context
                            .read<ProfileCubit>()
                            .insertToMyFavorite(context, productId);
                      },
                child: const Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                ),
              );
            }
          }
        } else {
          return InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.only(
                      bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
                  content: Text( 
                        'log_in_to_enjoy_these_benefits'.tr(context), 
                        style: TextStyle(color: Colors.white), 
                      ),
                  duration: const Duration(seconds: 2), // Option

                ),
              );
            },
            child: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          );
        }
      },
    );
  }
}
