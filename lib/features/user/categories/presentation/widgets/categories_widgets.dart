// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/Locale/cubit/locale_cubit.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
import 'package:sheek_bazar/core/utils/app_colors.dart';
import 'package:sheek_bazar/features/user/categories/presentation/pages/category_details.dart';
import 'package:sheek_bazar/features/user/shops/presentation/cubit/shops_cubit.dart';

import '../../../../../core/utils/app_constants.dart';
import '../../data/models/categories_model.dart';

class CategoriesSection extends StatefulWidget {
  List<SubCategory?> subCategory;
  String? categoryId;
  CategoriesSection(
      {super.key, required this.subCategory, required this.categoryId});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  List<SubCategory?> subCategory = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.subCategory.length; i++) {
      if (widget.subCategory[i]!.categoryParent == widget.categoryId) {
        subCategory.add(widget.subCategory[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50.0.h),
      child: GridView.count(
        crossAxisCount: 2, // Display two items per row
        childAspectRatio: 1.5, // Adjust aspect ratio to fit items nicely
        crossAxisSpacing: 10, // Add spacing between items horizontally
        mainAxisSpacing: 40, // Add spacing between items vertically
        children: List.generate(
          subCategory.length,
          (index) {
            return BlocBuilder<LocaleCubit, ChangeLocaleState>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  child: InkWell(
                    onTap: () {
                      AppConstant.customNavigation(
                          context,
                          CategoryDetailsScreen(
                            supplierId: "-1",
                            categoryId: widget.categoryId!,
                            subCategoryId: subCategory[index]!.categoryid!,
                            title: state.locale.languageCode == "en"
                                ? subCategory[index]!.categorynameen!
                                : state.locale.languageCode == "ar"
                                    ? subCategory[index]!.categorynamear!
                                    : subCategory[index]!.categorynameku!,
                          ),
                          -1,
                          0);
                    },
                    child: Column(
                      children: [
                        ClipOval(
                          child: Container(
                              width: 250.w,
                              height: 250.w,
                              color: Colors.black,
                              child: ClipOval(
                                child: AppConstant.customNetworkImage(
                                  fit: BoxFit.cover,
                                  imagePath:
                                      subCategory[index]!.categoryimg ?? '',
                                  imageError: "assets/images/placeholder.png",
                                ),
                              )),
                        ),
                        AppConstant.customSizedBox(0, 10),
                        Text(
                          state.locale.languageCode == "en"
                              ? subCategory[index]!.categorynameen!
                              : state.locale.languageCode == "ar"
                                  ? subCategory[index]!.categorynamear!
                                  : subCategory[index]!.categorynameku!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40.0.sp),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

double _currentPriceStart = 0;
double _currentPriceEnd = 50000;

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  bool isSelected = false;
  late RangeValues _currentPriceRange =
      RangeValues(_currentPriceStart, _currentPriceEnd);
  String? radioValue;
  void _handleGenderChange(value) {
    if (value == "from cheapest") {
      setState(() {
        radioValue = "from cheapest";
      });
    } else if (value == "from expansive") {
      setState(() {
        radioValue = "from expansive";
      });
    } else if (value == "new") {
      setState(() {
        radioValue = "new";
      });
    } else if (value == "old") {
      setState(() {
        radioValue = "old";
      });
    } else if (value == "from newest") {
      setState(() {
        radioValue = "from newest";
      });
    } else if (value == "from oldest") {
      setState(() {
        radioValue = "from oldest";
      });
    } else if (value == "with discount") {
      setState(() {
        radioValue = "with discount";
      });
    } else if (value == "without discount") {
      setState(() {
        radioValue = "without discount";
      });
    } else if (value == "all products") {
      setState(() {
        radioValue = "all products";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.6.sh,
      child: SingleChildScrollView(
        child: BlocBuilder<ThemesCubit, ThemesState>(
          builder: (context, theme) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Filter".tr(context),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                const Divider(),
                AppConstant.customSizedBox(0, 10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      Text(
                        "price".tr(context),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      )
                    ],
                  ),
                ),
                RangeSlider(
                  activeColor: theme.mode == "dark"
                      ? AppColors.whiteColor
                      : AppColors.primaryColor,
                  values: _currentPriceRange,
                  min: 0,
                  max: 100000, // Adjust max value as needed
                  divisions: 200, // Number of divisions between min and max
                  labels: RangeLabels(
                    _currentPriceRange.start.toStringAsFixed(2),
                    _currentPriceRange.end.toStringAsFixed(2),
                  ),
                  onChanged: (RangeValues newValues) {
                    setState(() {
                      _currentPriceRange = newValues;
                    });
                  },
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("0 د.ع"), Text("100000 د.ع")],
                ),
                AppConstant.customSizedBox(0, 30.0),
                const Divider(),
                ListTile(
                  title: Text('from_expinsive'.tr(context)),
                  leading: Radio(
                    activeColor: theme.mode == "dark"
                        ? AppColors.whiteColor
                        : AppColors.primaryColor,
                    value: "from expansive",
                    groupValue: radioValue,
                    onChanged: _handleGenderChange,
                  ),
                ),
                ListTile(
                  title: Text('from_cheapest'.tr(context)),
                  leading: Radio(
                    activeColor: theme.mode == "dark"
                        ? AppColors.whiteColor
                        : AppColors.primaryColor,
                    value: "from cheapest",
                    groupValue: radioValue,
                    onChanged: _handleGenderChange,
                  ),
                ),
                const Divider(),
                ListTile(
                  title: Text('from_newest'.tr(context)),
                  leading: Radio(
                    activeColor: theme.mode == "dark"
                        ? AppColors.whiteColor
                        : AppColors.primaryColor,
                    value: "from newest",
                    groupValue: radioValue,
                    onChanged: _handleGenderChange,
                  ),
                ),
                ListTile(
                  title: Text('from_oldest'.tr(context)),
                  leading: Radio(
                    activeColor: theme.mode == "dark"
                        ? AppColors.whiteColor
                        : AppColors.primaryColor,
                    value: "from oldest",
                    groupValue: radioValue,
                    onChanged: _handleGenderChange,
                  ),
                ),
                const Divider(),
                ListTile(
                  title: Text('with_discount'.tr(context)),
                  leading: Radio(
                    activeColor: theme.mode == "dark"
                        ? AppColors.whiteColor
                        : AppColors.primaryColor,
                    value: "with discount",
                    groupValue: radioValue,
                    onChanged: _handleGenderChange,
                  ),
                ),
                ListTile(
                  title: Text('without_discount'.tr(context)),
                  leading: Radio(
                    activeColor: theme.mode == "dark"
                        ? AppColors.whiteColor
                        : AppColors.primaryColor,
                    value: "without discount",
                    groupValue: radioValue,
                    onChanged: _handleGenderChange,
                  ),
                ),
                const Divider(),
                ListTile(
                  title: Text('new_clothes'.tr(context)),
                  leading: Radio(
                    activeColor: theme.mode == "dark"
                        ? AppColors.whiteColor
                        : AppColors.primaryColor,
                    value: "new",
                    groupValue: radioValue,
                    onChanged: _handleGenderChange,
                  ),
                ),
                ListTile(
                  title: Text('used_clothes'.tr(context)),
                  leading: Radio(
                    activeColor: theme.mode == "dark"
                        ? AppColors.whiteColor
                        : AppColors.primaryColor,
                    value: "old",
                    groupValue: radioValue,
                    onChanged: _handleGenderChange,
                  ),
                ),
                const Divider(),
                ListTile(
                  title: Text('all_products'.tr(context)),
                  leading: Radio(
                    activeColor: theme.mode == "dark"
                        ? AppColors.whiteColor
                        : AppColors.primaryColor,
                    value: "all products",
                    groupValue: radioValue,
                    onChanged: _handleGenderChange,
                  ),
                ),
                const Divider(),
                AppConstant.customSizedBox(0, 20),
                AppConstant.customElvatedButton(context, "apply_filter", () {
                  context.read<ShopsCubit>().filterProducts(
                      context,
                      _currentPriceRange.start,
                      _currentPriceRange.end,
                      radioValue);
                })
              ]),
            );
          },
        ),
      ),
    );
  }
}
