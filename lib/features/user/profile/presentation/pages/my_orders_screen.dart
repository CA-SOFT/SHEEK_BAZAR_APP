import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
import 'package:sheek_bazar/core/utils/app_colors.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/user/profile/presentation/cubit/profile_cubit.dart';
import 'package:sheek_bazar/features/user/profile/presentation/widgets/my_order_widget.dart';

import '../../../../../core/utils/cache_helper.dart';
import '../../../../auth/presentation/pages/sign_in.dart';

class MyOrdersScreen extends StatefulWidget {
  final int initalIndex;
  const MyOrdersScreen({super.key, this.initalIndex = 0});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  String? userId;
  Future<void> fetchData() async {
    setState(() {
      userId = CacheHelper.getData(key: "USER_ID");
    });
    if (userId != null) {
      context.read<ProfileCubit>().getOrders(context);
      context.read<ProfileCubit>().getLaundryOrders(context);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "my_orders".tr(context),
          style: TextStyle(fontSize: 50.sp, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: userId == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/join_with_us.png"),
                  Text(
                    "log_in_to_enjoy_these_benefits".tr(context),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  AppConstant.customSizedBox(0, 50),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.w),
                    child:
                        AppConstant.customElvatedButton(context, "sign_in", () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const SigninScreen()),
                        (Route route) => false,
                      );
                    }),
                  )
                ],
              ),
            )
          : DefaultTabController(
              initialIndex: widget.initalIndex,
              length: 2,
              child: BlocBuilder<ThemesCubit, ThemesState>(
                builder: (context, theme) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 150.h,
                        child: TabBar(
                          labelColor: theme.mode == "dark"
                              ? AppColors.whiteColor
                              : AppColors.primaryColor,
                          indicatorColor: theme.mode == "dark"
                              ? AppColors.whiteColor
                              : AppColors.primaryColor,
                          tabs: [
                            Tab(text: "clothes_orders".tr(context)),
                            Tab(
                              text: "laundry_orders".tr(context),
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          return Expanded(
                              child: TabBarView(
                            children: [
                              // Clothes Orders first tab
                              state.loadingOrders
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.primaryColor,
                                      ),
                                    )
                                  : state.clothesOrders == null
                                      ? const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                                child:
                                                    CircularProgressIndicator(
                                              color: AppColors.primaryColor,
                                            )),
                                          ],
                                        )
                                      : state.clothesOrders!.orders!.isEmpty
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                    "assets/images/empty.png"),
                                                Center(
                                                  child: Text(
                                                    "no_orders".tr(context),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                AppConstant.customSizedBox(
                                                    0, 50),
                                                Expanded(
                                                  child: ListView.builder(
                                                    itemCount: state
                                                                .clothesOrders ==
                                                            null
                                                        ? 0
                                                        : state.clothesOrders!
                                                                .orders!.isEmpty
                                                            ? 0
                                                            : state
                                                                .clothesOrders!
                                                                .orders!
                                                                .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Column(
                                                        children: [
                                                          OrderCard(
                                                              myPoints: state
                                                                  .clothesOrders!
                                                                  .myPoints!,
                                                              order: state
                                                                  .clothesOrders!
                                                                  .orders![index]),
                                                          const Divider(),
                                                        ],
                                                      )
                                                          .animate()
                                                          .fade(
                                                              duration: 500.ms)
                                                          .scale(delay: 500.ms);
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),

                              // Laundry Orders second tab
                              state.loadingOrders
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.primaryColor,
                                      ),
                                    )
                                  : state.laundryOrders == null
                                      ? const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                                child:
                                                    CircularProgressIndicator(
                                              color: AppColors.primaryColor,
                                            )),
                                          ],
                                        )
                                      : state.laundryOrders!.orders!.isEmpty
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                    "assets/images/empty.png"),
                                                Center(
                                                  child: Text(
                                                    "no_orders".tr(context),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                AppConstant.customSizedBox(
                                                    0, 50),
                                                Expanded(
                                                  child: ListView.builder(
                                                    itemCount: state
                                                                .laundryOrders ==
                                                            null
                                                        ? 0
                                                        : state.laundryOrders!
                                                                .orders!.isEmpty
                                                            ? 0
                                                            : state
                                                                .laundryOrders!
                                                                .orders!
                                                                .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Column(
                                                        children: [
                                                          OrderCard(
                                                              fromLaundry: true,
                                                              myPoints: state
                                                                  .laundryOrders!
                                                                  .myPoints,
                                                              order: state
                                                                  .laundryOrders!
                                                                  .orders![index]),
                                                          const Divider(),
                                                        ],
                                                      )
                                                          .animate()
                                                          .fade(
                                                              duration: 500.ms)
                                                          .scale(delay: 500.ms);
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                            ],
                          ));
                        },
                      )
                    ],
                  );
                },
              ),
            ),
    );
  }
}
