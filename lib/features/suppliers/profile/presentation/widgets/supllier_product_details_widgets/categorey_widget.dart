// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/cubit/locale_cubit.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/suppliers/profile/presentation/cubit/profile_cubit.dart';
import 'package:sheek_bazar/features/user/categories/data/models/categories_model.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/features/user/categories/presentation/cubit/categories_cubit.dart';
import 'package:sheek_bazar/features/user/home/data/models/productDetails_model.dart';
// import 'package:sheek_bazar/features/user/profile/presentation/cubit/profile_cubit.dart';

class CategoriesScreen extends StatefulWidget {
  List<ProductMainCategories>? productMainCategories;
  List<ProductSubCategories>? productSubCategories;
  CategoriesScreen(
      {super.key,
      required this.productMainCategories,
      required this.productSubCategories});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int doFun = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        return state.Categories == null
            ? const CircularProgressIndicator()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "determine_the_target_group".tr(context),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
                  ),
                  AppConstant.customSizedBox(0, 20),
                  BlocBuilder<CategoriesCubit, CategoriesState>(
                    builder: (context, state) {
                      return CategorySelectionForEdite(
                          productMainCategories: widget.productMainCategories,
                          categories: state.Categories!.categories);
                    },
                  ),
                  //////////////////////////////////////////////////////////////////////////////////////////////
                  AppConstant.customSizedBox(0, 50),
                  const Divider(),
                  AppConstant.customSizedBox(0, 50),
                  //////////////////////////////////////////////////////////////////////////////////////////////
                  Text(
                    "select_the_product_category".tr(context),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
                  ),
                  AppConstant.customSizedBox(0, 20),
                  BlocBuilder<CategoriesCubit, CategoriesState>(
                    builder: (context, state) {
                      // if (doFun == 0) {
                      context
                          .read<SupplierProfileCubit>()
                          .changeSubCategoriesForSelection(
                              state.Categories!.subcategories,
                              state.Categories!.categories);
                      // doFun = doFun + 1;
                      // }
                      return BlocBuilder<SupplierProfileCubit, ProfileState>(
                        builder: (context, value) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: value.subCategories!.length,
                            itemBuilder: (context, index) {
                              return BlocBuilder<LocaleCubit,
                                  ChangeLocaleState>(
                                builder: (context, locale) {
                                  return SubCategorySelectionForEdite(
                                    mainCategoreyName:
                                        locale.locale.languageCode == "en"
                                            ? state
                                                    .Categories!
                                                    .categories![index]!
                                                    .categorynameen ??
                                                ""
                                            : locale.locale.languageCode == "ar"
                                                ? state
                                                        .Categories!
                                                        .categories![index]!
                                                        .categorynamear ??
                                                    ""
                                                : state
                                                        .Categories!
                                                        .categories![index]!
                                                        .categorynameku ??
                                                    "",
                                    productSubCategories:
                                        widget.productSubCategories,
                                    subcategories: value.subCategories?[index],
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  )
                ],
              );
      },
    );
  }
}

class CategorySelectionForEdite extends StatefulWidget {
  List<Category?>? categories;
  List<ProductMainCategories>? productMainCategories;
  CategorySelectionForEdite(
      {super.key,
      required this.categories,
      required this.productMainCategories});

  @override
  State<CategorySelectionForEdite> createState() =>
      _CategorySelectionForEditeState();
}

class _CategorySelectionForEditeState extends State<CategorySelectionForEdite> {
  var isSelected = [];
  @override
  void initState() {
    super.initState();
    insertoldValue();
  }

  insertoldValue() {
    for (int i = 0; i < widget.productMainCategories!.length; i++) {
      setState(() {
        isSelected.add(widget.productMainCategories![i].categoryId);
      });
    }
  }

  void handleCheckboxChange(var option) {
    if (isSelected.any((item) => item == option)) {
      setState(() {
        isSelected.removeWhere((item) => item == option);
      });
    } else {
      setState(() {
        isSelected.add(option);
      });
    }
    context
        .read<SupplierProfileCubit>()
        .changeproductMainCategoriesList(isSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100.h,
          width: 1.sw,
          child: BlocBuilder<SupplierProfileCubit, ProfileState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: widget.categories!.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          child: Row(
                            children: [
                              Checkbox(
                                value: isSelected.any((item) =>
                                        item ==
                                        widget.categories![index]!.categoryid)
                                    ? true
                                    : false,
                                onChanged: state.canEdite!
                                    ? (value) => handleCheckboxChange(
                                        widget.categories![index]!.categoryid)
                                    : (value) {},
                              ),
                              BlocBuilder<LocaleCubit, ChangeLocaleState>(
                                builder: (context, state) {
                                  return Text(state.locale.languageCode == "en"
                                      ? widget
                                          .categories![index]!.categorynameen!
                                      : state.locale.languageCode == "ar"
                                          ? widget.categories![index]!
                                              .categorynamear!
                                          : widget.categories![index]!
                                              .categorynameku!);
                                },
                              ),
                              AppConstant.customSizedBox(100, 0)
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class SubCategorySelectionForEdite extends StatefulWidget {
  List<SubCategory?>? subcategories;
  List<ProductSubCategories>? productSubCategories;
  String mainCategoreyName;

  SubCategorySelectionForEdite({
    super.key,
    required this.subcategories,
    required this.mainCategoreyName,
    required this.productSubCategories,
  });

  @override
  State<SubCategorySelectionForEdite> createState() =>
      _SubCategorySelectionForEditeState();
}

class _SubCategorySelectionForEditeState
    extends State<SubCategorySelectionForEdite> {
  var isSelected = [];

  @override
  void initState() {
    super.initState();
    insertoldValue();
  }

  insertoldValue() {
    for (int i = 0; i < widget.productSubCategories!.length; i++) {
      setState(() {
        isSelected.add(widget.productSubCategories![i].categoryId);
      });
    }
  }

  void handleCheckboxChange(var option) {
    if (isSelected.any((item) => item == option)) {
      setState(() {
        isSelected.removeWhere((item) => item == option);
      });
    } else {
      setState(() {
        isSelected.add(option);
      });
    }
    context
        .read<SupplierProfileCubit>()
        .changeproductSubCategoriesList(isSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100.h,
          width: 1.sw,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: 230.w, child: Text("${widget.mainCategoreyName} :")),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: widget.subcategories!.length,
                  itemBuilder: (context, index) {
                    return BlocBuilder<SupplierProfileCubit, ProfileState>(
                      builder: (context, state) {
                        return SizedBox(
                          child: Row(
                            children: [
                              Checkbox(
                                value: isSelected.any((item) =>
                                        item ==
                                        widget
                                            .subcategories![index]!.categoryid)
                                    ? true
                                    : false,
                                onChanged: state.canEdite!
                                    ? (value) => handleCheckboxChange(widget
                                        .subcategories![index]!.categoryid)
                                    : (value) {},
                              ),
                              BlocBuilder<LocaleCubit, ChangeLocaleState>(
                                builder: (context, state) {
                                  return Text(state.locale.languageCode == "en"
                                      ? widget.subcategories![index]!
                                          .categorynameen!
                                      : state.locale.languageCode == "ar"
                                          ? widget.subcategories![index]!
                                              .categorynamear!
                                          : widget.subcategories![index]!
                                              .categorynameku!);
                                },
                              ),
                              AppConstant.customSizedBox(100, 0)
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
