// ignore_for_file: must_be_immutable, file_names, dead_code

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/Locale/cubit/locale_cubit.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
import 'package:sheek_bazar/core/utils/app_colors.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/suppliers/supplier_order/presentation/bloc/supplier_order_bloc.dart';

class OrderDetailsForSupplier extends StatefulWidget {
  String orderId;
  OrderDetailsForSupplier({super.key, required this.orderId});

  @override
  State<OrderDetailsForSupplier> createState() =>
      _OrderDetailsForSupplierState();
}

class _OrderDetailsForSupplierState extends State<OrderDetailsForSupplier> {
  @override
  void initState() {
    super.initState();
    // context.read<SupplierOrderCubit>().getOrderDetails(context, widget.orderId);
  }

  @override
  void deactivate() {
    super.deactivate();
    context.read<SupplierOrderCubit>().clearOrdersDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppConstant.customAppbar(
            context,
            Text(
              "order_details".tr(context),
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.primaryColor),
            ),
            [],
            true),
        body: BlocBuilder<SupplierOrderCubit, SupplierOrderState>(
          builder: (context, state) {
            return state.loadingOrders
                ? const Center(child: CircularProgressIndicator())
                : state.ordersDetails == null
                    ? const SizedBox()
                    : ListView.builder(
                        itemCount: state.ordersDetails!.length,
                        itemBuilder: (context, index) {
                          return BlocBuilder<ThemesCubit, ThemesState>(
                            builder: (context, theme) {
                              return Padding(
                                padding: EdgeInsets.all(35.sp),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: theme.mode == "dark"
                                        ? AppColors.primaryColor
                                        : AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: AppColors.greyColor,
                                        offset: Offset(4, 4),
                                        blurRadius: 10.0,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(35.0.sp),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 350.h,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30.r),
                                            child:
                                                AppConstant.customNetworkImage(
                                              width: 0.35.sw,
                                              fit: BoxFit.contain,
                                              imagePath: state
                                                      .ordersDetails![index]
                                                      .productImg ??
                                                  "",
                                              imageError:
                                                  "assets/images/placeholder.png",
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.all(25.sp),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                BlocBuilder<LocaleCubit,
                                                    ChangeLocaleState>(
                                                  builder: (context, value) {
                                                    return Text(
                                                      value.locale.languageCode ==
                                                              "en"
                                                          ? state
                                                                  .ordersDetails![
                                                                      index]
                                                                  .productNameEn ??
                                                              ""
                                                          : value.locale
                                                                      .languageCode ==
                                                                  "at"
                                                              ? state
                                                                      .ordersDetails![
                                                                          index]
                                                                      .productNameAr ??
                                                                  ""
                                                              : state
                                                                      .ordersDetails![
                                                                          index]
                                                                      .productNameKu ??
                                                                  "",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 40.sp),
                                                    );
                                                  },
                                                ),
                                                const Divider(),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    state.ordersDetails![index]
                                                                .productColor ==
                                                            null
                                                        ? const SizedBox()
                                                        : state
                                                                    .ordersDetails![
                                                                        index]
                                                                    .productColor ==
                                                                "-"
                                                            ? const SizedBox()
                                                            : Row(
                                                                children: [
                                                                  Text(
                                                                    "color".tr(
                                                                        context),
                                                                    style:
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  AppConstant
                                                                      .customSizedBox(
                                                                          10,
                                                                          0),
                                                                  CircleAvatar(
                                                                    radius:
                                                                        40.sp,
                                                                    backgroundColor:
                                                                        AppConstant.getColorFromHex(state.ordersDetails![index].productColor ??
                                                                            ""),
                                                                  ),
                                                                ],
                                                              ),
                                                    state.ordersDetails![index]
                                                                .productSize ==
                                                            null
                                                        ? const SizedBox()
                                                        : state
                                                                    .ordersDetails![
                                                                        index]
                                                                    .productSize ==
                                                                "-"
                                                            ? const SizedBox()
                                                            : Row(
                                                                children: [
                                                                  Text(
                                                                    "size".tr(
                                                                        context),
                                                                    style:
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  AppConstant
                                                                      .customSizedBox(
                                                                          20,
                                                                          0),
                                                                  Text(
                                                                    state.ordersDetails![index]
                                                                            .productSize ??
                                                                        "",
                                                                    style: TextStyle(
                                                                        fontSize: 50
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )
                                                                ],
                                                              )
                                                  ],
                                                ),
                                                AppConstant.customSizedBox(
                                                    0, 40),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${"quantity".tr(context)} : ${state.ordersDetails![index].productQuantity ?? ""} ",
                                                      style: TextStyle(
                                                          fontSize: 45.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                AppConstant.customSizedBox(
                                                    0, 40),
                                                state.ordersDetails![index]
                                                            .productDiscountValue ==
                                                        null
                                                    ? Text(
                                                        "${"total".tr(context)}  ${state.ordersDetails![index].productTotalBeforeDiscount ?? ""} د.ع",
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .primaryColor,
                                                            fontSize: 35.0.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    : state
                                                                .ordersDetails![
                                                                    index]
                                                                .productDiscountValue ==
                                                            "0"
                                                        ? Text(
                                                            "${"total".tr(context)}  ${state.ordersDetails![index].productTotalBeforeDiscount ?? ""} د.ع",
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .primaryColor,
                                                                fontSize:
                                                                    35.0.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        : Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "${"before_discount".tr(context)} : ${state.ordersDetails![index].productTotalBeforeDiscount ?? ""} د.ع",
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .primaryColor,
                                                                    fontSize:
                                                                        35.0.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Text(
                                                                "${"after_discount".tr(context)} : ${state.ordersDetails![index].productTotalAfterDiscount ?? ""} د.ع",
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .primaryColor,
                                                                    fontSize:
                                                                        35.0.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            ],
                                                          ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                              .animate()
                              .fade(duration: 500.ms)
                              .scale(delay: 500.ms);
                        },
                      );
          },
        ));
  }
}
