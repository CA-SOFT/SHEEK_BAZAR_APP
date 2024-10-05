// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/Locale/cubit/locale_cubit.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/user/categories/presentation/cubit/categories_cubit.dart';

import '../../../../../core/utils/app_colors.dart';
import '../widgets/categories_widgets.dart';

class CategoriesScreen extends StatefulWidget {
  int initialIndex;
  CategoriesScreen({super.key, this.initialIndex = 0});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoriesCubit>().getCategories(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, ChangeLocaleState>(
      builder: (context, state) {
        return Scaffold(
          // drawer: AppConstant.customDrawer(context),
          appBar: AppConstant.customAppbar(
              context,
              Text(
                "Categories".tr(context),
                style:
                    TextStyle(fontSize: 50.0.sp, fontWeight: FontWeight.bold),
              ),
              [],
              true),
          body: BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              return state.loadingCat
                  ? const Center(child: CircularProgressIndicator())
                  : state.Categories == null
                      ? const SizedBox()
                      : BlocBuilder<ThemesCubit, ThemesState>(
                          builder: (context, theme) {
                            return DefaultTabController(
                              initialIndex: widget.initialIndex,
                              length: state.Categories!.categories!.length,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 150.h,
                                    child: TabBar(
                                      labelColor: theme.mode == "dark"
                                          ? AppColors.whiteColor
                                          : AppColors.primaryColor,
                                      indicatorColor: theme.mode == "dark"
                                          ? AppColors.whiteColor
                                          : AppColors.primaryColor,
                                      tabs: [
                                        for (int i = 0;
                                            i <
                                                state.Categories!.categories!
                                                    .length;
                                            i++)
                                          BlocBuilder<LocaleCubit,
                                              ChangeLocaleState>(
                                            builder: (context, value) {
                                              return Tab(
                                                text: value.locale
                                                            .languageCode ==
                                                        "en"
                                                    ? state
                                                        .Categories!
                                                        .categories![i]
                                                        ?.categorynameen
                                                    : value.locale
                                                                .languageCode ==
                                                            "ar"
                                                        ? state
                                                            .Categories!
                                                            .categories![i]
                                                            ?.categorynamear
                                                        : state
                                                            .Categories!
                                                            .categories![i]
                                                            ?.categorynameku,
                                              );
                                            },
                                          ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                      children: [
                                        for (int i = 0;
                                            i <
                                                state.Categories!.categories!
                                                    .length;
                                            i++)
                                          CategoriesSection(
                                              categoryId: state.Categories!
                                                  .categories![i]?.categoryid,
                                              subCategory: state
                                                  .Categories!.subcategories!),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
            },
          ),
        );
      },
    );
  }
}
