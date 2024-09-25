// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';

import '../../../../../Locale/cubit/locale_cubit.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_constants.dart';
import '../cubit/laundry_cubit.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaundryCubit, LaundryState>(
      builder: (context, state) {
        return Container(
          height: 0.5.sh,
          padding: EdgeInsets.all(30.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${"choose_service".tr(context)} : ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
                  ),
                  AppConstant.customSizedBox(30, 0),
                  BlocBuilder<LocaleCubit, ChangeLocaleState>(
                    builder: (context, value) {
                      return BlocBuilder<LocaleCubit, ChangeLocaleState>(
                        builder: (context, value) {
                          // print(state.response!.services![0].serviceNameKu);
                          return value.locale.languageCode == "en"
                              ? DropdownButton<String>(
                                  value: state.serviceId,
                                  items: state.response!.services!
                                      .map<DropdownMenuItem<String>>(
                                          (var variable) {
                                    return DropdownMenuItem<String>(
                                      value: variable.serviceId,
                                      child: Text(variable.serviceNameEn ?? ""),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    context
                                        .read<LaundryCubit>()
                                        .changeinitalValueForService(
                                            newValue!, "en");
                                  },
                                )
                              : value.locale.languageCode == "ar"
                                  ? DropdownButton<String>(
                                      value: state.serviceId,
                                      items: state.response!.services!
                                          .map<DropdownMenuItem<String>>(
                                              (var value) {
                                        return DropdownMenuItem<String>(
                                          value: value.serviceId,
                                          child:
                                              Text(value.serviceNameAr ?? ""),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        context
                                            .read<LaundryCubit>()
                                            .changeinitalValueForService(
                                                newValue!, "ar");
                                      },
                                    )
                                  : DropdownButton<String>(
                                      value: state.serviceId,
                                      items: state.response!.services!
                                          .map<DropdownMenuItem<String>>(
                                              (var value) {
                                        return DropdownMenuItem<String>(
                                          value: value.serviceId,
                                          child:
                                              Text(value.serviceNameKu ?? ""),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        context
                                            .read<LaundryCubit>()
                                            .changeinitalValueForService(
                                                newValue!, "ku");
                                      },
                                    );
                        },
                      );
                    },
                  ),
                ],
              ),

              ///////////////////////////////////////////////////////
              const Divider(),
              ///////////////////////////////////////////////////////

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${"choose_category".tr(context)} : ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
                  ),
                  AppConstant.customSizedBox(30, 0),
                  BlocBuilder<LocaleCubit, ChangeLocaleState>(
                    builder: (context, value) {
                      return BlocBuilder<LocaleCubit, ChangeLocaleState>(
                        builder: (context, value) {
                          return value.locale.languageCode == "en"
                              ? DropdownButton<String>(
                                  value: state.categoryId,
                                  items: state.response!.clothesType!
                                      .map<DropdownMenuItem<String>>(
                                          (var value) {
                                    return DropdownMenuItem<String>(
                                      value: value.categoryId,
                                      child: Text(value.categoryNameEn ?? ""),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    context
                                        .read<LaundryCubit>()
                                        .changeinitalValueForClothesType(
                                            newValue!, "en");
                                  },
                                )
                              : value.locale.languageCode == "ar"
                                  ? DropdownButton<String>(
                                      value: state.categoryId,
                                      items: state.response!.clothesType!
                                          .map<DropdownMenuItem<String>>(
                                              (var value) {
                                        return DropdownMenuItem<String>(
                                          value: value.categoryId,
                                          child:
                                              Text(value.categoryNameAr ?? ""),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        context
                                            .read<LaundryCubit>()
                                            .changeinitalValueForClothesType(
                                                newValue!, "ar");
                                      },
                                    )
                                  : DropdownButton<String>(
                                      value: state.categoryId,
                                      items: state.response!.clothesType!
                                          .map<DropdownMenuItem<String>>(
                                              (var value) {
                                        return DropdownMenuItem<String>(
                                          value: value.categoryId,
                                          child:
                                              Text(value.categoryNameKu ?? ""),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        context
                                            .read<LaundryCubit>()
                                            .changeinitalValueForClothesType(
                                                newValue!, "ku");
                                      },
                                    );
                        },
                      );
                    },
                  ),
                ],
              ),
              ///////////////////////////////////////////////////////
              const Divider(),
              ///////////////////////////////////////////////////////
              Column(
                children: [
                  Text(
                    "choose_quantity".tr(context),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
                  ),
                  AppConstant.customSizedBox(0, 30),
                  BlocBuilder<ThemesCubit, ThemesState>(
                    builder: (context, theme) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              context.read<LaundryCubit>().increaseQuantity();
                            },
                            child: CircleAvatar(
                              backgroundColor: theme.mode == "dark"
                                  ? AppColors.whiteColor
                                  : AppColors.primaryColor,
                              radius: 50.sp,
                              child: Icon(
                                Icons.add,
                                size: 50.sp,
                              ),
                            ),
                          ),
                          AppConstant.customSizedBox(20, 0),
                          Text(
                            state.quantity.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 50.sp),
                          ),
                          AppConstant.customSizedBox(20, 0),
                          InkWell(
                            onTap: () {
                              context.read<LaundryCubit>().decraseQuantity();
                            },
                            child: CircleAvatar(
                                backgroundColor: theme.mode == "dark"
                                    ? AppColors.whiteColor
                                    : AppColors.primaryColor,
                                radius: 50.sp,
                                child: Icon(
                                  Icons.remove,
                                  size: 50.sp,
                                )),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              AppConstant.customSizedBox(0, 30),

              AppConstant.customElvatedButton(context, "add_order", () {
                context.read<LaundryCubit>().addToOrder(context);
              }),
              const Divider(),
            ],
          ),
        );
      },
    );
  }
}

class LaundryCard extends StatelessWidget {
  var order;
  LaundryCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc(Match match) => '${match[1]},';
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 50.h, horizontal: 30.w),
        child: Slidable(
          endActionPane: ActionPane(
            extentRatio: 20 / 95,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                flex: 2,
                onPressed: (context) {
                  context.read<LaundryCubit>().deleteOrder(order);
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'delete'.tr(context),
              ),
            ],
          ),
          child: BlocBuilder<LocaleCubit, ChangeLocaleState>(
            builder: (context, state) {
              return Row(
                children: [
                  Expanded(
                    flex: 9,
                    child: BlocBuilder<ThemesCubit, ThemesState>(
                      builder: (context, value) {
                        return Container(
                            padding: EdgeInsets.all(75.sp),
                            decoration: BoxDecoration(
                              color: value.mode == "dark"
                                  ? AppColors.primaryColor
                                  : AppColors.whiteColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.5), // Shadow color
                                  blurRadius: 5, // Blur intensity
                                  spreadRadius: 2, // Spread of shadow
                                  offset: const Offset(
                                      2, 2), // Offset from container
                                )
                              ],
                              borderRadius: state.locale.languageCode == 'en'
                                  ? const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      topLeft: Radius.circular(10))
                                  : const BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                      topRight: Radius.circular(
                                          10)), // Rounded corners
                            ),
                            child: BlocBuilder<LocaleCubit, ChangeLocaleState>(
                              builder: (context, value) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          order['service'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 50.sp),
                                        ),
                                        AppConstant.customSizedBox(0, 30),
                                        Text(
                                          order['category'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 50.sp),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          order['quantity'].toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        AppConstant.customSizedBox(0, 50),
                                        Row(
                                          children: [
                                            Text(
                                              "${"price".tr(context)} : ",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                                "${order['price'].toString().replaceAllMapped(reg, mathFunc)} د.ع",
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ));
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 325.h,
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Shadow color
                            blurRadius: 5, // Blur intensity
                            spreadRadius: 2, // Spread of shadow
                            offset: const Offset(2, 2), // Offset from container
                          )
                        ],
                        borderRadius: state.locale.languageCode == 'en'
                            ? const BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10))
                            : const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft:
                                    Radius.circular(10)), // Rounded corners
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            color: AppColors.whiteColor,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
