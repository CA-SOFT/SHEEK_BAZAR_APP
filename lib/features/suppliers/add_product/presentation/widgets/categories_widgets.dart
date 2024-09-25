// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/cubit/locale_cubit.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/suppliers/add_product/presentation/cubit/add_product_cubit.dart';
import 'package:sheek_bazar/features/user/categories/data/models/categories_model.dart';

class CategorySelection extends StatefulWidget {
  List<Category?>? categories;
  CategorySelection({
    super.key,
    required this.categories,
  });

  @override
  State<CategorySelection> createState() => _CategorySelectionState();
}

class _CategorySelectionState extends State<CategorySelection> {
  var isSelected = [];
  @override
  void initState() {
    super.initState();
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
    context.read<AddProductCubit>().changecategoryId(isSelected);
    context.read<AddProductCubit>().changeSubGategorey(option);
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
                            onChanged: (value) => handleCheckboxChange(
                                widget.categories![index]!.categoryid),
                          ),
                          BlocBuilder<LocaleCubit, ChangeLocaleState>(
                            builder: (context, state) {
                              return Text(state.locale.languageCode == "en"
                                  ? widget.categories![index]!.categorynameen!
                                  : state.locale.languageCode == "ar"
                                      ? widget
                                          .categories![index]!.categorynamear!
                                      : widget
                                          .categories![index]!.categorynameku!);
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
          ),
        ),
      ],
    );
  }
}

class SubCategorySelection extends StatefulWidget {
  List<SubCategory?>? subcategories;
  SubCategorySelection({
    super.key,
    required this.subcategories,
  });

  @override
  State<SubCategorySelection> createState() => _SubCategorySelectionState();
}

class _SubCategorySelectionState extends State<SubCategorySelection> {
  var isSelected = [];
  @override
  void initState() {
    super.initState();
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
    context.read<AddProductCubit>().changesubCategoryId(isSelected);
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
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: widget.subcategories!.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      child: Row(
                        children: [
                          Checkbox(
                            value: isSelected.any((item) =>
                                    item ==
                                    widget.subcategories![index]!.categoryid)
                                ? true
                                : false,
                            onChanged: (value) => handleCheckboxChange(
                                widget.subcategories![index]!.categoryid),
                          ),
                          BlocBuilder<LocaleCubit, ChangeLocaleState>(
                            builder: (context, state) {
                              return Text(state.locale.languageCode == "en"
                                  ? widget
                                      .subcategories![index]!.categorynameen!
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
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
