import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
import 'package:sheek_bazar/core/utils/app_colors.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';

import 'config/internet/cubit/internet_cubit.dart';
import 'features/user/cart/presentation/pages/cart_screen.dart';
import 'features/user/home/presentation/pages/home_screen.dart';
import 'features/user/laundry/presentation/pages/laundry_screen.dart';
import 'features/user/profile/presentation/pages/profile.dart';
import 'features/user/shops/presentation/pages/shops_screen.dart';

class SectionsScreen extends StatefulWidget {
  final int number;
  const SectionsScreen({super.key, this.number = 0});

  @override
  State<SectionsScreen> createState() => _SectionsScreenState();
}

final controller = ScrollController();

class _SectionsScreenState extends State<SectionsScreen> {
  late int index;

  @override
  void initState() {
    super.initState();
    // context.read<InternetCubit>().whenOpenApp(context);
    setState(() {
      index = widget.number;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: index == 2
          ? null
          : BlocBuilder<ThemesCubit, ThemesState>(
              builder: (context, state) {
                return ConvexAppBar(
                  height: 200.h,
                  initialActiveIndex: index,
                  items: [
                    const TabItem(icon: Icons.home),
                    TabItem(
                        icon: ClipRRect(
                          child: Image.asset(
                            "assets/icons/categorise_icon.png",
                          ),
                        ),
                        activeIcon: ClipRRect(
                          child: Image.asset(
                            "assets/icons/categorise_icon.png",
                            color: state.mode == "dark"
                                ? AppColors.whiteColor
                                : AppColors.primaryColor,
                          ),
                        )),
                    TabItem(
                      icon: InkWell(
                        onTap: () {
                          AppConstant.customNavigation(
                              context, const CartScreen(), 0, 1);
                        },
                        child: CircleAvatar(
                          backgroundColor: state.mode == "dark"
                              ? AppColors.whiteColor
                              : AppColors.primaryColor,
                          radius: 50.sp,
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: state.mode == "dark"
                                ? AppColors.primaryColor
                                : AppColors.whiteColor,
                          ),
                        ),
                        // child: ClipOval(
                        //   child: Container(
                        //     color: state.mode == "dark"
                        //         ? AppColors.whiteColor
                        //         : AppColors.primaryColor,
                        //     child: Icon(
                        //       Icons.shopping_cart_outlined,
                        //       color: state.mode == "dark"
                        //           ? AppColors.primaryColor
                        //           : AppColors.whiteColor,
                        //     ),
                        //   ),
                        // ),
                      ),
                    ),
                    TabItem(
                      icon: ClipRRect(
                        child: Image.asset("assets/icons/collections_icon.png"),
                      ),
                      activeIcon: ClipRRect(
                        child: Image.asset(
                          "assets/icons/collections_icon.png",
                          color: state.mode == "dark"
                              ? AppColors.whiteColor
                              : AppColors.primaryColor,
                        ),
                      ),
                    ),
                    const TabItem(icon: Icons.person),
                  ],
                  activeColor: state.mode == "dark"
                      ? AppColors.whiteColor
                      : AppColors.primaryColor,
                  color: AppColors.greyColor,
                  backgroundColor: state.mode == "dark"
                      ? AppColors.primaryColor
                      : Colors.white,
                  style: TabStyle.fixedCircle,
                  onTap: (i) {
                    if (i == 0 && index == i) {
                      controller.animateTo(0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn);
                    }

                    setState(() {
                      index = i;
                    });
                  },
                );
              },
            ),
      body: Builder(
        builder: (BuildContext context) {
          switch (index) {
            case 0:
              return HomeScreen(
                controller: controller,
              );
            case 1:
              return const LaundryScreen();
            case 2:
              return HomeScreen(
                controller: controller,
              );
            case 3:
              return const ShopsScreen();
            case 4:
              return const ProfileScreen();
            default:
              return Container();
          }
        },
      ),
    );
  }
}
