// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/user/categories/presentation/widgets/categoryDetails_widgets.dart';
import 'package:sheek_bazar/features/user/shops/data/models/products_model.dart';
import 'package:sheek_bazar/features/user/shops/presentation/cubit/shops_cubit.dart';
import 'package:sheek_bazar/features/user/shops/presentation/widgets/shopDetails_widgets.dart';

class ShopProductsWidget extends StatelessWidget {
  ProductsModel? products;
  bool fromSupllier;
  ShopProductsWidget(
      {super.key, required this.products, this.fromSupllier = false});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppConstant.customSizedBox(0, 50),
          products!.supplierInfo![0].supplierDescription == null
              ? const SizedBox()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      Text(
                        "description".tr(context),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50.sp,
                        ),
                      ),
                      Text(
                        products!.supplierInfo![0].supplierDescription!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40.sp,
                        ),
                      ),
                    ],
                  ),
                ),
          const Divider(),
          const SearchBox(),
          products!.products!.isEmpty
              ? SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/empty.png"),
                      Center(
                        child: Text(
                          "no_products".tr(context),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )
              : BlocBuilder<ShopsCubit, ShopsState>(
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: 25.h, right: 40.0.w, left: 40.0.w),
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: (250 / 400),
                        mainAxisSpacing: 20,
                        children: List.generate(
                          products!.products!.length,
                          (index) {
                            return productCard(
                              fromSupllier: fromSupllier,
                              product: products!.products![index],
                            )
                                .animate()
                                .fade(duration: 500.ms)
                                .scale(delay: 500.ms);
                          },
                        ),
                      ),
                    );
                  },
                ),
          AppConstant.customSizedBox(0, 50)
        ],
      ),
    );
  }
}
