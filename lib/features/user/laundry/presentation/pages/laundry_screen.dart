// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/Locale/cubit/locale_cubit.dart';
import 'package:sheek_bazar/features/user/cart/presentation/pages/check_out.dart';
import 'package:sheek_bazar/features/user/laundry/presentation/cubit/laundry_cubit.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../widgets/laundry_widgets.dart';

class LaundryScreen extends StatefulWidget {
  const LaundryScreen({super.key});

  @override
  State<LaundryScreen> createState() => _LaundryScreenState();
}

class _LaundryScreenState extends State<LaundryScreen> {
  String? userId;

  Future<void> fetchData() async {
    setState(() {
      userId = CacheHelper.getData(key: "USER_ID");
    });
    if (userId != null) {
      context.read<CartCubit>().getMyAdress(context);
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<LaundryCubit>().getLundry(context);

    fetchData();
  }

  @override
  void deactivate() {
    super.deactivate();
    context.read<LaundryCubit>().clearData();
  }

  @override
  Widget build(BuildContext context) {
    // showAddSection() {
    //   showModalBottomSheet(
    //     shape: const RoundedRectangleBorder(
    //       borderRadius: BorderRadius.only(
    //         topLeft: Radius.circular(20),
    //         topRight: Radius.circular(20),
    //       ),
    //     ),
    //     context: context,
    //     builder: (context) => BlocBuilder<LaundryCubit, LaundryState>(
    //       builder: (context, state) {
    //         return const CustomBottomSheet();
    //       },
    //     ),
    //   );
    // }

    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc(Match match) => '${match[1]},';
    return BlocBuilder<LocaleCubit, ChangeLocaleState>(
      builder: (context, state) {
        return Scaffold(
            // floatingActionButton: InkWell(
            //     onTap: () {
            //       showAddSection();
            //     },
            //     child: Container(
            //       decoration: BoxDecoration(
            //         border: Border.all(
            //             color: Colors.white,
            //             width: 2), // Adjust width as needed
            //         shape: BoxShape.circle,
            //       ),
            //       child: CircleAvatar(
            //         backgroundColor: AppColors.primaryColor,
            //         radius: 100.sp,
            //         child: Icon(
            //           Icons.add,
            //           color: AppColors.whiteColor,
            //           size: 100.sp,
            //         ),
            //       ),
            //     )),
            drawer: AppConstant.customDrawer(context,
                isGuest: userId == null ? true : false),
            appBar: AppConstant.customAppbar(
                context,
                Text(
                  "laundry".tr(context),
                  style:
                      TextStyle(fontSize: 50.0.sp, fontWeight: FontWeight.bold),
                ),
                [],
                false),
            body: SingleChildScrollView(
              child: BlocBuilder<LaundryCubit, LaundryState>(
                builder: (context, state) {
                  return state.response == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 0.5.sh,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            )
                          ],
                        )
                      : BlocBuilder<LaundryCubit, LaundryState>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                const CustomBottomSheet(),
                                state.orders == null
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            "assets/images/empty.png",
                                            height: 0.45.sh,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 200.h),
                                            child: Center(
                                              child: Text(
                                                "add_order".tr(context),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          // Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.end,
                                          //   children: [
                                          //     BlocBuilder<LocaleCubit,
                                          //         ChangeLocaleState>(
                                          //       builder: (context, value) {
                                          //         return Transform(
                                          //           alignment: Alignment.center,
                                          //           transform: Matrix4
                                          //               .identity()
                                          //             ..rotateZ(value.locale
                                          //                         .languageCode ==
                                          //                     "en"
                                          //                 ? -90 / 180
                                          //                 : 90 /
                                          //                     180), // Convert degrees to radians
                                          //           child: Lottie.asset(
                                          //             'assets/icons/animation_arrow.json',
                                          //             width: 0.6.sw,
                                          //             height:
                                          //                 MediaQuery.of(context)
                                          //                             .size
                                          //                             .height >
                                          //                         680
                                          //                     ? 0.3.sh
                                          //                     : 0.2.sh,
                                          //           ),
                                          //         );
                                          //       },
                                          //     ),
                                          //   ],
                                          // ),
                                        ],
                                      )
                                    : state.orders!.isEmpty
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                                Image.asset(
                                                  "assets/images/empty.png",
                                                  height: 0.45.sh,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 200.h),
                                                  child: Center(
                                                    child: Text(
                                                      "add_order".tr(context),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                // Row(
                                                //   mainAxisAlignment:
                                                //       MainAxisAlignment.end,
                                                //   children: [
                                                //     BlocBuilder<LocaleCubit,
                                                //         ChangeLocaleState>(
                                                //       builder:
                                                //           (context, value) {
                                                //         return Transform(
                                                //           alignment:
                                                //               Alignment.center,
                                                //           transform: Matrix4
                                                //               .identity()
                                                //             ..rotateZ(value
                                                //                         .locale
                                                //                         .languageCode ==
                                                //                     "en"
                                                //                 ? -90 / 180
                                                //                 : 90 /
                                                //                     180), // Convert degrees to radians
                                                //           child: Lottie.asset(
                                                //             'assets/icons/animation_arrow.json',
                                                //             width: 0.6.sw,
                                                //             height: MediaQuery.of(
                                                //                             context)
                                                //                         .size
                                                //                         .height >
                                                //                     680
                                                //                 ? 0.3.sh
                                                //                 : 0.2.sh,
                                                //           ),
                                                //         );
                                                //       },
                                                //     ),
                                                //   ],
                                                // ),
                                              ])
                                        : Column(
                                            children: [
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: state.orders == null
                                                    ? 0
                                                    : state.orders!.length,
                                                itemBuilder: (context, index) {
                                                  return LaundryCard(
                                                      order:
                                                          state.orders![index]);
                                                },
                                              ),
                                              AppConstant.customSizedBox(0, 30),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "total".tr(context),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 50.sp),
                                                  ),
                                                  Text(
                                                    "${state.total!.toString().replaceAllMapped(reg, mathFunc)} د.ع",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 50.sp),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(75.sp),
                                                child: AppConstant
                                                    .customElvatedButton(
                                                        context, "confirm",
                                                        () async {
                                                  if (userId == null) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        backgroundColor:
                                                            AppColors
                                                                .primaryColor,
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 150.h,
                                                                top: 50.h,
                                                                left: 50.w,
                                                                right: 50.w),
                                                        content: Text(
                                                            'log_in_to_enjoy_these_benefits'
                                                                .tr(context)),
                                                        duration: const Duration(
                                                            seconds:
                                                                2), // Optional duration
                                                      ),
                                                    );
                                                  } else {
                                                    await context
                                                        .read<CartCubit>()
                                                        .getLaundrIndo(
                                                            state.categoryArray,
                                                            state.servicesArray,
                                                            state.quantityArray,
                                                            int.parse(
                                                                state.total!),
                                                            state.pricesArray);
                                                    AppConstant.customNavigation(
                                                        context,
                                                        const CheckOutScreen(
                                                            fromLaundry: true),
                                                        0,
                                                        -1);
                                                  }
                                                }),
                                              ),
                                              AppConstant.customSizedBox(
                                                  0, 250),
                                            ],
                                          ),
                              ],
                            );
                          },
                        );
                },
              ),
            ));
      },
    );
  }
}
