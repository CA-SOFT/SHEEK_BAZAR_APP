// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, unrelated_type_equality_checks, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
import 'package:sheek_bazar/core/utils/app_colors.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/user/home/presentation/widgets/home_widgets.dart';
import 'package:sheek_bazar/features/user/profile/presentation/cubit/profile_cubit.dart';

import '../../../../../Locale/cubit/locale_cubit.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../../data/models/home_model.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class HomeScreen extends StatefulWidget {
  ScrollController controller;
  HomeScreen({super.key, required this.controller});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int index = 0;

class _HomeScreenState extends State<HomeScreen> {
  String? userId;
  Future<void> fetchData() async {
    setState(() {
      userId = CacheHelper.getData(key: "USER_ID");
    });
    if (userId != null) {
      context.read<ProfileCubit>().getMyFavorite(context);
    }
  }

  Future refresh() async {
    setState(() {
      refreshData = true;
    });
    await context.read<HomeCubit>().clearData();
    await context.read<HomeCubit>().getProducts(context);
    setState(() {
      refreshData = false;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getProducts(context);

    fetchData();
    widget.controller.addListener(() {
      if (widget.controller.position.maxScrollExtent ==
          widget.controller.position.pixels) {
        context.read<HomeCubit>().getProducts(context);
        context.read<HomeCubit>().changeFetchDataStauts();
      }
    });
  }

  @override
  void dispose() {
    // widget.controller.dispose();
    super.dispose();
  }

  bool showSearchField = false;
  bool refreshData = false;
  List<Products> newProducts = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, ChangeLocaleState>(
      builder: (context, state) {
        return BlocBuilder<ThemesCubit, ThemesState>(
          builder: (context, theme) {
            return Scaffold(
                drawer: AppConstant.customDrawer(context,
                    isGuest: userId == null ? true : false),
                appBar: showSearchField == true
                    ? AppConstant.customAppbar(context,
                        BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          return BlocBuilder<LocaleCubit, ChangeLocaleState>(
                            builder: (context, value) {
                              return TextFormField(
                                onChanged: (searchTerm) {
                                  if (value.locale.languageCode == 'en') {
                                    newProducts =
                                        value.locale.languageCode == "en"
                                            ? state.orginalProoducts!
                                                .where(
                                                  (Product) =>
                                                      Product.productNameEn!
                                                          .toLowerCase()
                                                          .contains(searchTerm
                                                              .toLowerCase()) ||
                                                      Product
                                                          .productParagraphEn!
                                                          .toLowerCase()
                                                          .contains(searchTerm
                                                              .toLowerCase()),
                                                )
                                                .toList()
                                            : value.locale.languageCode == "ar"
                                                ? state.orginalProoducts!
                                                    .where(
                                                      (Product) =>
                                                          Product.productNameAr!
                                                              .toLowerCase()
                                                              .contains(searchTerm
                                                                  .toLowerCase()) ||
                                                          Product
                                                              .productParagraphAr!
                                                              .toLowerCase()
                                                              .contains(searchTerm
                                                                  .toLowerCase()),
                                                    )
                                                    .toList()
                                                : state.orginalProoducts!
                                                    .where(
                                                      (Product) =>
                                                          Product.productNameKu!
                                                              .toLowerCase()
                                                              .contains(searchTerm
                                                                  .toLowerCase()) ||
                                                          Product
                                                              .productParagraphKu!
                                                              .toLowerCase()
                                                              .contains(searchTerm
                                                                  .toLowerCase()),
                                                    )
                                                    .toList();
                                  } else {
                                    newProducts = [];

                                    for (int i = 0;
                                        i < state.orginalProoducts!.length;
                                        i++) {
                                      String SearchAfterTirm = "";
                                      String OrginalAfterTirm = "";
                                      String OrginalPargraphAfterTirm = "";

                                      for (int i = 0;
                                          i < searchTerm.length;
                                          i++) {
                                        if (searchTerm.codeUnits[i] == 1610 ||
                                            searchTerm.codeUnits[i] == 1740) {
                                          continue;
                                        } else {
                                          SearchAfterTirm =
                                              SearchAfterTirm + searchTerm[i];
                                        }
                                      }

                                      for (int j = 0;
                                          j <
                                              state.orginalProoducts![i]
                                                  .productNameAr!.length;
                                          j++) {
                                        if (state
                                                    .orginalProoducts![i]
                                                    .productNameAr!
                                                    .codeUnits[j] ==
                                                1740 ||
                                            state
                                                    .orginalProoducts![i]
                                                    .productNameAr!
                                                    .codeUnits[j] ==
                                                1610) {
                                          continue;
                                        } else {
                                          OrginalAfterTirm = OrginalAfterTirm +
                                              state.orginalProoducts![i]
                                                  .productNameAr![j];
                                        }
                                      }
                                      for (int j = 0;
                                          j <
                                              state.orginalProoducts![i]
                                                  .productParagraphAr!.length;
                                          j++) {
                                        if (state
                                                .orginalProoducts![i]
                                                .productParagraphAr!
                                                .codeUnits[j] ==
                                            1740) {
                                          continue;
                                        } else {
                                          OrginalPargraphAfterTirm =
                                              OrginalPargraphAfterTirm +
                                                  state.orginalProoducts![i]
                                                      .productParagraphAr![j];
                                        }
                                      }

                                      if (OrginalAfterTirm.toLowerCase()
                                              .contains(SearchAfterTirm
                                                  .toLowerCase()) ||
                                          OrginalPargraphAfterTirm.toLowerCase()
                                              .contains(SearchAfterTirm
                                                  .toLowerCase())) {
                                        newProducts
                                            .add(state.orginalProoducts![i]);
                                      }
                                    }
                                  }
                                  context
                                      .read<HomeCubit>()
                                      .searchProducts(newProducts);
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors
                                          .grey, // Set your desired color here
                                    ),
                                  ),
                                  hintText: 'Search'.tr(context),
                                ),
                              );
                            },
                          );
                        },
                      ), [
                        BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      showSearchField = false;
                                    });
                                    context
                                        .read<HomeCubit>()
                                        .searchProducts(state.orginalProoducts);
                                  },
                                  child: const Icon(Icons.close)),
                            );
                          },
                        )
                      ], false)
                    : AppConstant.customAppbar(
                        context,
                        ClipRRect(
                          child: Image.asset(
                            "assets/images/icon.png",
                            width: 100.w,
                            height: 100.w,
                            color: theme.mode == "dark" ? Colors.white : null,
                          ),
                        ),
                        [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  showSearchField = true;
                                });
                              },
                              child: Icon(
                                Icons.search_rounded,
                                color: theme.mode == "dark"
                                    ? AppColors.whiteColor
                                    : AppColors.primaryColor,
                                size: 75.sp,
                              ),
                            ),
                          )
                        ],
                        false),
                body: SizedBox(
                  height: 1.sh,
                  width: 1.sw,
                  child: RefreshIndicator(
                    onRefresh: refresh,
                    backgroundColor: AppColors.whiteColor,
                    color: AppColors.primaryColor,
                    child: SingleChildScrollView(
                      key: const PageStorageKey("Home"),
                      controller: showSearchField ? null : widget.controller,
                      child: Column(
                        children: [
                          const HomeBanners()
                              .animate()
                              .fade(duration: 500.ms)
                              .scale(delay: 500.ms),
                          AppConstant.customSizedBox(0, 50),
                          const CategoriesWidget()
                              .animate()
                              .fade(duration: 500.ms)
                              .scale(delay: 500.ms),
                          refreshData
                              ? const SizedBox()
                              : PopularItemsWidget(
                                      showSearchField: showSearchField)
                                  .animate()
                                  .fade(duration: 500.ms)
                                  .scale(delay: 500.ms),
                        ],
                      ),
                    ),
                  ),
                ));
          },
        );
      },
    );
  }
}
