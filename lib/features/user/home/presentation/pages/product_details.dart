// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/Locale/cubit/locale_cubit.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/user/cart/presentation/cubit/cart_cubit.dart';
import 'package:sheek_bazar/features/user/home/presentation/widgets/product_details_widgets.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class ProductDetailsScreen extends StatefulWidget {
  String productId;
  ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String? userId;
  bool isNotGuest = false;
  Future<void> fetchData() async {
    setState(() {
      userId = CacheHelper.getData(key: "USER_ID");
    });
    if (userId != null) {
      setState(() {
        isNotGuest = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    context
        .read<ProductDetailsCubit>()
        .getProductDetails(context, widget.productId);
    context.read<CartCubit>().changeproductId(widget.productId);
  }

  @override
  void deactivate() {
    super.deactivate();
    context.read<ProductDetailsCubit>().clearProductDetails();
    context.read<CartCubit>().clearInsertVariables();
  }

  @override
  Widget build(BuildContext context) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc(Match match) => '${match[1]},';
    return Scaffold(
        bottomNavigationBar:
            CustomBottomNavigation(isNotGuest: isNotGuest, newContext: context),
        appBar: AppConstant.customAppbar(
            context,
            const Text(""),
            [
              AppConstant.customAddFavoriteIcon(
                  fromFav: false, productId: widget.productId, userId: userId)
            ],
            true),
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            return state.productDetails == null
                ? const Center(
                    child: CircularProgressIndicator(
                        color: AppColors.primaryColor),
                  )
                : state.productDetails!.mainInfo!.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.primaryColor),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            state.productDetails!.productAttachments == null
                                ? const SizedBox()
                                : state.productDetails!.productAttachments!
                                        .isEmpty
                                    ? const SizedBox()
                                    : SizedBox(
                                        width: 1.sh,
                                        child: Stack(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                BannersForProductImage(
                                                  items: state.productDetails!
                                                      .productAttachments!,
                                                )
                                              ],
                                            ),
                                            state.productDetails!.mainInfo![0]
                                                        .isOutOfStock ==
                                                    "0"
                                                ? const SizedBox()
                                                : Row(
                                                    children: [
                                                      BlocBuilder<LocaleCubit,
                                                          ChangeLocaleState>(
                                                        builder:
                                                            (context, state) {
                                                          return Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    35.0.sp),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .red[200],
                                                              borderRadius: state
                                                                          .locale
                                                                          .languageCode ==
                                                                      "en"
                                                                  ? const BorderRadius
                                                                      .only(
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              16),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              16))
                                                                  : const BorderRadius
                                                                      .only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              16),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              16)),
                                                            ),
                                                            child: Text(
                                                              'not_available'
                                                                  .tr(context),
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    30.0.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  )
                                          ],
                                        ),
                                      ),
                            const Divider(),
                            Padding(
                              padding: EdgeInsets.all(50.0.sp),
                              child:
                                  BlocBuilder<LocaleCubit, ChangeLocaleState>(
                                builder: (context, value) {
                                  return Column(
                                    children: [
                                      Text(
                                        value.locale.languageCode == "en"
                                            ? state.productDetails!.mainInfo![0]
                                                .productNameEn!
                                            : value.locale.languageCode == "ar"
                                                ? state.productDetails!
                                                    .mainInfo![0].productNameAr!
                                                : state
                                                    .productDetails!
                                                    .mainInfo![0]
                                                    .productNameKu!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 40.sp),
                                      ),
                                      AppConstant.customSizedBox(0, 30),
                                      Text(
                                        value.locale.languageCode == "en"
                                            ? state.productDetails!.mainInfo![0]
                                                .productDescriptionEn!
                                            : value.locale.languageCode == "ar"
                                                ? state
                                                    .productDetails!
                                                    .mainInfo![0]
                                                    .productDescriptionAr!
                                                : state
                                                    .productDetails!
                                                    .mainInfo![0]
                                                    .productDescriptionKu!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 40.sp),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            const Divider(),
                            Padding(
                              padding: EdgeInsets.all(50.0.sp),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${"price".tr(context)} : ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 50.sp),
                                  ),
                                  state.productDetails!.mainInfo![0]
                                              .productDiscount ==
                                          "0"
                                      ? const SizedBox()
                                      : Text(
                                          "${state.productDetails!.mainInfo![0].productPrice.toString().replaceAllMapped(reg, mathFunc)} د.ع",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 50.sp,
                                            color: Colors.red,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationColor: Colors.red,
                                          ),
                                        ),
                                  AppConstant.customSizedBox(20, 0),
                                  Text(
                                    "${state.productDetails!.mainInfo![0].productFinalPrice.toString().replaceAllMapped(reg, mathFunc)} د.ع",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 50.sp),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(50.sp),
                              child: Row(
                                children: [
                                  Text(
                                    "+ ${state.productDetails!.mainInfo![0].productPoints}",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 50.sp),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            state.productDetails!.productColors == null
                                ? const SizedBox()
                                : ColorsSections(),
                            const Divider(),
                            state.productDetails!.productSizes == null
                                ? const SizedBox()
                                : SizesSections(),
                            const Divider(),
                            SuggestionProduct(
                                similarProducts:
                                    state.productDetails!.similarProducts),
                          ],
                        ),
                      );
          },
        ));
  }
}
