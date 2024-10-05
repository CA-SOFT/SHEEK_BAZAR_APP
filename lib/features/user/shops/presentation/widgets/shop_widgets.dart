// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
import 'package:sheek_bazar/core/utils/app_colors.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';

import '../pages/shopDetails_screen.dart';

class shopCard extends StatelessWidget {
  String supplierName, supplierDescription, supplierLogo, supplierId;
  shopCard(
      {super.key,
      required this.supplierName,
      required this.supplierLogo,
      required this.supplierId,
      required this.supplierDescription});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 40.0.h),
      child: InkWell(
        onTap: () {
          AppConstant.customNavigation(
              context,
              ShopDetailsScreen(
                supplierId: supplierId,
              ),
              -1,
              0);
        },
        child: BlocBuilder<ThemesCubit, ThemesState>(
          builder: (context, theme) {
            return Container(
              decoration: BoxDecoration(
                color: theme.mode == "dark"
                    ? AppColors.primaryColor
                    : AppColors.whiteColor,
                borderRadius: BorderRadius.circular(30.0.sp),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 10.0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0.sp),
                    bottomLeft: Radius.circular(30.0.sp),
                  ),
                  child: AppConstant.customNetworkImage(
                    fit: BoxFit.contain,
                    width: 400.w,
                    height: 350.h,
                    imagePath: supplierLogo,
                    imageError: "assets/images/placeholder.png",
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(30.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          supplierName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 50.0.sp),
                        ),
                        AppConstant.customSizedBox(0, 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 50.sp,
                            ),
                            Expanded(
                              child: Text(
                                supplierDescription,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ]),
            );
          },
        ),
      ),
    );
  }
}
