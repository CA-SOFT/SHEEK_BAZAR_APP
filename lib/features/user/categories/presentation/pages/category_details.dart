// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/Locale/cubit/locale_cubit.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/user/categories/presentation/widgets/categories_widgets.dart';
import 'package:sheek_bazar/features/user/categories/presentation/widgets/categoryDetails_widgets.dart';
import 'package:sheek_bazar/features/user/shops/presentation/cubit/shops_cubit.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../shops/data/models/products_model.dart';

class CategoryDetailsScreen extends StatefulWidget {
  String title, categoryId, subCategoryId, supplierId;
  CategoryDetailsScreen(
      {super.key,
      required this.title,
      required this.categoryId,
      required this.supplierId,
      required this.subCategoryId});

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.supplierId == "-1") {
      context
          .read<ShopsCubit>()
          .getProducts(context, "-1", widget.categoryId, widget.subCategoryId);
    } else {
      context
          .read<ShopsCubit>()
          .getProducts(context, widget.supplierId, "-1", "-1");
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    context.read<ShopsCubit>().clearproducts();
  }

  @override
  Widget build(BuildContext context) {
    List<Products> newProducts;
    return Scaffold(
      appBar: AppConstant.customAppbar(
          context,
          Text(
            widget.title,
            style: TextStyle(fontSize: 50.sp, fontWeight: FontWeight.bold),
          ),
          [],
          true),
      body: BlocBuilder<ShopsCubit, ShopsState>(
        builder: (context, state) {
          return state.loadingProducts
              ? const Center(
                  child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ))
              : Padding(
                  padding: EdgeInsets.all(50.0.sp),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: BlocBuilder<ShopsCubit, ShopsState>(
                              builder: (context, state) {
                                return BlocBuilder<LocaleCubit,
                                    ChangeLocaleState>(
                                  builder: (context, value) {
                                    return TextFormField(
                                      onChanged: (searchTerm) {
                                        newProducts = value
                                                    .locale.languageCode ==
                                                "en"
                                            ? state.defaultproducts!.products!
                                                .where(
                                                  (Product) => Product
                                                      .productNameEn!
                                                      .toLowerCase()
                                                      .contains(searchTerm
                                                          .toLowerCase()),
                                                )
                                                .toList()
                                            : value.locale.languageCode == "ar"
                                                ? state
                                                    .defaultproducts!.products!
                                                    .where(
                                                      (Product) => Product
                                                          .productNameAr!
                                                          .toLowerCase()
                                                          .contains(searchTerm
                                                              .toLowerCase()),
                                                    )
                                                    .toList()
                                                : state
                                                    .defaultproducts!.products!
                                                    .where(
                                                      (Product) => Product
                                                          .productNameKu!
                                                          .toLowerCase()
                                                          .contains(searchTerm
                                                              .toLowerCase()),
                                                    )
                                                    .toList();
                                        context
                                            .read<ShopsCubit>()
                                            .changeSearch(newProducts);
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Search'.tr(context),
                                        border: const OutlineInputBorder(),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.filter_list),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => const FilterBottomSheet(),
                              );
                            },
                          ),
                        ],
                      ),
                      Expanded(
                        child: state.products!.products!.isEmpty
                            ? SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/empty.png"),
                                    Center(
                                      child: Text(
                                        "no_products".tr(context),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : BlocBuilder<ShopsCubit, ShopsState>(
                                builder: (context, state) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 35.0.h),
                                    child: GridView.count(
                                      crossAxisCount: 2,
                                      childAspectRatio: (250 / 400),
                                      mainAxisSpacing: 20,
                                      children: List.generate(
                                        state.products == null
                                            ? 0
                                            : state.products!.products!.length,
                                        (index) {
                                          return productCard(
                                            product: state
                                                .products!.products![index],
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
