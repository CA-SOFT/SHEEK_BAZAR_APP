// ignore_for_file: must_be_immutable, non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/core/utils/cache_helper.dart';
import 'package:sheek_bazar/features/user/shops/presentation/cubit/shops_cubit.dart';
import 'package:sheek_bazar/features/user/shops/presentation/widgets/shop_information_widget.dart';
import 'package:sheek_bazar/features/user/shops/presentation/widgets/shop_products_widget.dart';

import '../../../../../core/utils/app_colors.dart';
import '../widgets/shopDetails_widgets.dart';

class ShopDetailsScreen extends StatefulWidget {
  String supplierId;
  bool fromSupllier;
  ShopDetailsScreen({
    super.key,
    this.fromSupllier = false,
    required this.supplierId,
  });

  @override
  State<ShopDetailsScreen> createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen> {
  String? userId;
  Future<void> fetchData() async {
    setState(() {
      userId = CacheHelper.getData(key: "USER_ID");
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    context
        .read<ShopsCubit>()
        .getProducts(context, widget.supplierId, "-1", "-1");
  }

  @override
  void deactivate() {
    super.deactivate();
    context.read<ShopsCubit>().clearproducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopsCubit, ShopsState>(
      builder: (context, state) {
        return Scaffold(
            appBar: state.products == null
                ? null
                : state.products!.supplierInfo!.isEmpty
                    ? null
                    : state.products!.supplierAttachments == null
                        ? CustomAppBar(
                            state.products!.supplierInfo![0].supplierName!,
                            state.products!.supplierInfo![0].supplierLogo)
                        : state.products!.supplierAttachments!.isEmpty
                            ? CustomAppBar(
                                state.products!.supplierInfo![0].supplierName!,
                                state.products!.supplierInfo![0].supplierLogo)
                            : null,
            body: state.loadingProducts
                ? const Center(
                    child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ))
                : SingleChildScrollView(
                    child: SizedBox(
                      height: 1.sh,
                      child: Column(
                        children: [
                          state.products!.supplierAttachments == null
                              ? const SizedBox()
                              : state.products!.supplierAttachments!.isEmpty
                                  ? const SizedBox()
                                  : SizedBox(
                                      height: 1000.h,
                                      child: Stack(children: [
                                        Container(
                                          height: 800.h,
                                          width: 1.sw,
                                          color: AppColors.greyColor,
                                          child: BannersForCover(
                                            items: state
                                                .products!.supplierAttachments,
                                          ),
                                        ),
                                        ShopInfo(
                                            followersCount: state
                                                .products!
                                                .supplierInfo![0]
                                                .totalFollowers,
                                            title: state.products!
                                                .supplierInfo![0].supplierName!,
                                            logo: state.products!
                                                .supplierInfo![0].supplierLogo),
                                        const ArrowForBack(),
                                        widget.fromSupllier
                                            ? const SizedBox()
                                            : userId == null
                                                ? const SizedBox()
                                                : const FollowButton(),
                                      ]),
                                    ),
                          AppConstant.customSizedBox(0, 40),
                          BlocBuilder<ThemesCubit, ThemesState>(
                            builder: (context, theme) {
                              return Expanded(
                                child: DefaultTabController(
                                  length: 2,
                                  child: Column(
                                    children: [
                                      TabBar(
                                        indicatorColor: theme.mode == "dark"
                                            ? AppColors.whiteColor
                                            : AppColors.primaryColor,
                                        labelColor: theme.mode == "dark"
                                            ? AppColors.whiteColor
                                            : AppColors.primaryColor,
                                        labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 50.sp),
                                        unselectedLabelColor: Colors.grey,
                                        tabs: [
                                          Tab(
                                            text: "all_products".tr(context),
                                          ),
                                          Tab(
                                              text: "shop_information"
                                                  .tr(context)),
                                        ],
                                      ),
                                      Expanded(
                                        child: TabBarView(
                                          children: [
                                            ShopProductsWidget(
                                              fromSupllier: widget.fromSupllier,
                                              products: state.products,
                                            ),
                                            const ShopInformationWidget(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ));
      },
    );
  }
}
