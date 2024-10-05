// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
import 'package:sheek_bazar/core/utils/app_colors.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/suppliers/supplier_order/data/models/supplier_orders_model.dart';
import 'package:sheek_bazar/features/suppliers/supplier_order/presentation/bloc/supplier_order_bloc.dart';
import 'package:sheek_bazar/features/suppliers/supplier_order/presentation/pages/order_details_screen.dart';

class OrderSupplierCard extends StatelessWidget {
  OneOrder order;
  OrderSupplierCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20),
      child: BlocBuilder<ThemesCubit, ThemesState>(
        builder: (context, theme) {
          return Container(
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
              padding: EdgeInsets.all(50.0.sp),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${"invoice_number".tr(context)} : # ${order.invoiceNumber}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 40.sp),
                            ),
                            AppConstant.customSizedBox(0, 35),
                            Text(
                              "${"final_amount".tr(context)} : ${order.finalAmount}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 40.sp),
                            ),
                            AppConstant.customSizedBox(0, 35),
                            Text(
                              "${"order_status".tr(context)} : ${order.orderStatus}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 40.sp),
                            ),
                            AppConstant.customSizedBox(0, 35),
                            Text(
                              "${"order_date".tr(context)} : ${order.createdAt}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 40.sp),
                            ),
                          ],
                        ),
                      ),
                      AppConstant.customSizedBox(40, 0),
                      Icon(
                        Icons.checklist_rounded,
                        size: 150.sp,
                        color: Colors.black,
                      )
                    ],
                  ),
                  AppConstant.customSizedBox(0, 40),
                  SizedBox(
                    width: 1.sw,
                    child: ElevatedButton(
                        child: Text("order_details".tr(context)),
                        onPressed: () {
                          AppConstant.customNavigation(
                              context,
                              OrderDetailsForSupplier(
                                  orderId: "${order.orderId}"),
                              -1,
                              1);
                        }),
                  ),
                  AppConstant.customSizedBox(0, 30),
                  SizedBox(
                    width: 1.sw,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                            Colors.green,
                          ),
                        ),
                        onPressed: () {
                          context
                              .read<SupplierOrderCubit>()
                              .confirmOrder(context, order.orderId!);
                        },
                        child: Text(
                          "confirm".tr(context),
                          style: const TextStyle(color: Colors.white),
                        )),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
