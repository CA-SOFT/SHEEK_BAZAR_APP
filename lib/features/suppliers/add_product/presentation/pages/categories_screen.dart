import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/features/suppliers/add_product/presentation/cubit/add_product_cubit.dart';
import 'package:sheek_bazar/features/user/categories/presentation/cubit/categories_cubit.dart';

import '../../../../../core/utils/app_constants.dart';
import '../widgets/categories_widgets.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int i = 0;

  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductCubit, AddProductState>(
      builder: (context, state) {
        return BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, value) {
            context.read<AddProductCubit>().changeCategories(value.Categories);

            return state.categories == null
                ? const CircularProgressIndicator()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "determine_the_target_group".tr(context),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 50.sp),
                      ),
                      AppConstant.customSizedBox(0, 20),
                      CategorySelection(
                          categories: state.categories!.categories),
                      //////////////////////////////////////////////////////////////////////////////////////////////
                      AppConstant.customSizedBox(0, 50),
                      const Divider(),
                      AppConstant.customSizedBox(0, 50),
                      //////////////////////////////////////////////////////////////////////////////////////////////
                      state.subcategories == null
                          ? const SizedBox()
                          : state.subcategories!.isEmpty
                              ? const SizedBox()
                              : Text(
                                  "select_the_product_category".tr(context),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 50.sp),
                                ),
                      AppConstant.customSizedBox(0, 20),
                      SubCategorySelection(
                        subcategories: state.subcategories ?? [],
                      ),
                    ],
                  );
          },
        );
      },
    );
  }
}
