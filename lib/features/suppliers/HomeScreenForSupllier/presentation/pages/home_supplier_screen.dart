// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/Locale/cubit/locale_cubit.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
import 'package:sheek_bazar/core/utils/app_colors.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/core/utils/cache_helper.dart';
import 'package:sheek_bazar/features/auth/presentation/pages/sign_in.dart';
import 'package:sheek_bazar/features/contact_us/contactUs_screen.dart';
import 'package:sheek_bazar/features/contact_us/privacy.dart';
import 'package:sheek_bazar/features/contact_us/term.dart';
import 'package:sheek_bazar/features/suppliers/profile/presentation/pages/supplier_profile_screen.dart';
import 'package:sheek_bazar/features/suppliers/add_product/presentation/pages/add_product_screen.dart';
import 'package:sheek_bazar/features/suppliers/supplier_order/presentation/pages/supllier_order_screen.dart';

class HomeSupplier extends StatefulWidget {
  final int number;
  const HomeSupplier({super.key, this.number = 1});

  @override
  State<HomeSupplier> createState() => _HomeSupplierState();
}

class _HomeSupplierState extends State<HomeSupplier> {
  late int index;
  @override
  void initState() {
    super.initState();
    setState(() {
      index = widget.number;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BlocBuilder<LocaleCubit, ChangeLocaleState>(
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

                    const Divider(),
                    ListTile(
                      title: Text('log_out'.tr(context),
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
                        await CacheHelper.clearData(
                          key: "REFERRAL_CODE",
                        );

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
      ),
      appBar: AppBar(
        centerTitle: true,
        title: index == 0
            ? Text(
                "my_orders".tr(context),
                style: TextStyle(fontSize: 50.sp),
              )
            : index == 1
                ? Text(
                    "add_product".tr(context),
                    style: TextStyle(fontSize: 50.sp),
                  )
                : Text(
                    "profile".tr(context),
                    style: TextStyle(fontSize: 50.sp),
                  ),
      ),
      bottomNavigationBar: ConvexAppBar(
        height: 175.h,
        initialActiveIndex: index,
        items: [
          TabItem(
            title: "my_orders".tr(context),
            icon: Icons.pending_actions_rounded,
          ),
          TabItem(title: "my_orders".tr(context), icon: Icons.add_business),
          TabItem(title: "profile".tr(context), icon: Icons.person),
        ],
        activeColor: AppColors.primaryColor,
        color: AppColors.greyColor,
        backgroundColor: Colors.white,
        style: TabStyle.fixedCircle,
        onTap: (i) {
          setState(() {
            index = i;
          });
        },
      ),
      body: Builder(
        builder: (BuildContext context) {
          switch (index) {
            case 0:
              return const SupplierOrderScren();
            case 1:
              return const AddProductScreen();
            case 2:
              return const supllierProfileScreen();

            default:
              return Container();
          }
        },
      ),
    );
  }
}
