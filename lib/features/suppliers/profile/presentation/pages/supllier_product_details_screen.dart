// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
import 'package:sheek_bazar/core/utils/app_colors.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/suppliers/profile/presentation/widgets/supllier_product_details_widgets/categorey_widget.dart';
import 'package:sheek_bazar/features/suppliers/profile/presentation/widgets/supllier_product_details_widgets/color_picker_widget.dart';
import 'package:sheek_bazar/features/suppliers/profile/presentation/widgets/supllier_product_details_widgets/custom_check_box_widget.dart';
import 'package:sheek_bazar/features/suppliers/profile/presentation/widgets/supllier_product_details_widgets/custom_text_form_field_widget.dart';
import 'package:sheek_bazar/features/suppliers/profile/presentation/widgets/supllier_product_details_widgets/edite_buttons_widget.dart';
import 'package:sheek_bazar/features/suppliers/profile/presentation/widgets/supllier_product_details_widgets/product_attachments_widget.dart';
import 'package:sheek_bazar/features/user/categories/presentation/cubit/categories_cubit.dart';
import 'package:sheek_bazar/features/user/home/presentation/cubit/home_cubit.dart';
import 'package:sheek_bazar/features/user/home/presentation/cubit/home_state.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/supllier_product_details_widgets/sizes_widget.dart';

class supllierProductDetailsScreen extends StatefulWidget {
  String productId;
  supllierProductDetailsScreen({super.key, required this.productId});

  @override
  State<supllierProductDetailsScreen> createState() =>
      _supllierProductDetailsScreenState();
}

class _supllierProductDetailsScreenState
    extends State<supllierProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<ProductDetailsCubit>()
        .getProductDetails(context, widget.productId, fromSupplier: true);
    context.read<CategoriesCubit>().getCategories(context);
  }

  @override
  void deactivate() {
    super.deactivate();
    context.read<ProductDetailsCubit>().clearProductDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppConstant.customAppbar(
          context,
          Text(
            "product_details".tr(context),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
          ),
          [
            BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
              builder: (context, state) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 50.w,
                      left: 50.w,
                    ),
                    child: BlocBuilder<SupplierProfileCubit, ProfileState>(
                      builder: (context, profileState) {
                        return PopupMenuButton<String>(
                          child: BlocBuilder<ThemesCubit, ThemesState>(
                            builder: (context, theme) {
                              return Text(
                                "...",
                                style: TextStyle(
                                    color: theme.mode == "dark"
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 75.sp),
                              );
                            },
                          ),
                          onSelected: (value) {
                            if (value == "delete") {
                              context
                                  .read<SupplierProfileCubit>()
                                  .deleteProduct(
                                      context,
                                      state.productDetails!.mainInfo![0]
                                          .productId!);
                            } else {
                              if (profileState.canEdite!) {
                                context
                                    .read<SupplierProfileCubit>()
                                    .changeCanEditeValue(false);
                                context
                                    .read<SupplierProfileCubit>()
                                    .addItemsToBanners(
                                        state.productDetails!
                                            .productAttachments!,
                                        context);
                                context
                                    .read<ProductDetailsCubit>()
                                    .getProductDetails(
                                        context, widget.productId,
                                        fromSupplier: true);
                              } else {
                                context
                                    .read<SupplierProfileCubit>()
                                    .changeCanEditeValue(true);
                                context
                                    .read<SupplierProfileCubit>()
                                    .addItemsToBanners(
                                        state.productDetails!
                                            .productAttachments!,
                                        context);
                              }
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: "edit",
                              child: profileState.canEdite!
                                  ? Text(
                                      "${"cancel".tr(context)} ${"edit".tr(context)}")
                                  : Text("edit".tr(context)),
                            ),
                            PopupMenuItem(
                              value: "delete",
                              child: Text("delete".tr(context)),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
            )
          ],
          true),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          return state.loading
              ? const Center(
                  child:
                      CircularProgressIndicator(color: AppColors.primaryColor),
                )
              : state.productDetails == null
                  ? const Center(
                      child: CircularProgressIndicator(
                          color: AppColors.primaryColor),
                    )
                  : state.productDetails!.mainInfo!.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(
                              color: AppColors.primaryColor),
                        )
                      : BlocBuilder<SupplierProfileCubit, ProfileState>(
                          builder: (context, profileState) {
                            return SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.all(40.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    profileState.canEdite!
                                        ? EditeButtonsWidget(
                                            productId: widget.productId,
                                          )
                                        : const SizedBox(),
                                    Text(
                                      "add_product_name".tr(context),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 50.sp),
                                    ),
                                    AppConstant.customSizedBox(0, 20),
                                    CustomTextFormField(
                                      initalValue: state.productDetails!
                                          .mainInfo![0].productNameAr!,
                                      onChange: (value) {
                                        context
                                            .read<SupplierProfileCubit>()
                                            .changeProductNameAr(value);
                                      },
                                    ),
                                    AppConstant.customSizedBox(0, 20),
                                    CustomTextFormField(
                                      initalValue: state.productDetails!
                                          .mainInfo![0].productNameEn!,
                                      onChange: (value) {
                                        context
                                            .read<SupplierProfileCubit>()
                                            .changeProductNameEN(value);
                                      },
                                    ),
                                    AppConstant.customSizedBox(0, 20),
                                    CustomTextFormField(
                                      initalValue: state.productDetails!
                                          .mainInfo![0].productNameKu!,
                                      onChange: (value) {
                                        context
                                            .read<SupplierProfileCubit>()
                                            .changeProductNameKU(value);
                                      },
                                    ),
                                    //////////////////////////////////////////////////////////////////////////////////////////////
                                    AppConstant.customSizedBox(0, 50),
                                    const Divider(),
                                    AppConstant.customSizedBox(0, 50),
                                    //////////////////////////////////////////////////////////////////////////////////////////////
                                    Text(
                                      "add_product_description".tr(context),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 50.sp),
                                    ),
                                    AppConstant.customSizedBox(0, 20),
                                    CustomTextFormField(
                                      maxLines: true,
                                      initalValue: state.productDetails!
                                          .mainInfo![0].productDescriptionAr!,
                                      onChange: (value) {
                                        context
                                            .read<SupplierProfileCubit>()
                                            .changeproductDescriptionAR(value);
                                      },
                                    ),
                                    AppConstant.customSizedBox(0, 20),
                                    CustomTextFormField(
                                      maxLines: true,
                                      initalValue: state.productDetails!
                                          .mainInfo![0].productDescriptionEn!,
                                      onChange: (value) {
                                        context
                                            .read<SupplierProfileCubit>()
                                            .changeproductDescriptionEN(value);
                                      },
                                    ),
                                    AppConstant.customSizedBox(0, 20),
                                    CustomTextFormField(
                                      maxLines: true,
                                      initalValue: state.productDetails!
                                          .mainInfo![0].productDescriptionKu!,
                                      onChange: (value) {
                                        context
                                            .read<SupplierProfileCubit>()
                                            .changeproductDescriptionKU(value);
                                      },
                                    ),
                                    //////////////////////////////////////////////////////////////////////////////////////////////
                                    AppConstant.customSizedBox(0, 50),
                                    const Divider(),
                                    AppConstant.customSizedBox(0, 50),
                                    //////////////////////////////////////////////////////////////////////////////////////////////
                                    Text(
                                      "explanation_of_the_product".tr(context),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 50.sp),
                                    ),
                                    AppConstant.customSizedBox(0, 20),
                                    CustomTextFormField(
                                      maxLines: true,
                                      initalValue: state.productDetails!
                                          .mainInfo![0].productParagraphAr!,
                                      onChange: (value) {
                                        context
                                            .read<SupplierProfileCubit>()
                                            .changeproductParagraphAR(value);
                                      },
                                    ),
                                    AppConstant.customSizedBox(0, 20),
                                    CustomTextFormField(
                                      maxLines: true,
                                      initalValue: state.productDetails!
                                          .mainInfo![0].productParagraphEn!,
                                      onChange: (value) {
                                        context
                                            .read<SupplierProfileCubit>()
                                            .changeproductParagraphEN(value);
                                      },
                                    ),
                                    AppConstant.customSizedBox(0, 20),
                                    CustomTextFormField(
                                      maxLines: true,
                                      initalValue: state.productDetails!
                                          .mainInfo![0].productParagraphKu!,
                                      onChange: (value) {
                                        context
                                            .read<SupplierProfileCubit>()
                                            .changeproductParagraphKU(value);
                                      },
                                    ),
                                    //////////////////////////////////////////////////////////////////////////////////////////////
                                    AppConstant.customSizedBox(0, 50),
                                    const Divider(),
                                    AppConstant.customSizedBox(0, 50),
                                    //////////////////////////////////////////////////////////////////////////////////////////////
                                    Text(
                                      "select_product_type".tr(context),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 50.sp),
                                    ),
                                    AppConstant.customSizedBox(0, 20),
                                    CustomCheckBox(
                                        initalValue: state.productDetails!
                                            .mainInfo![0].isUsed!,
                                        valueForFirstRadio: "New",
                                        titleForFirstRadio: "new",
                                        valueForSecondRadio: "Old",
                                        titleForSecondRadio: "old"),
                                    //////////////////////////////////////////////////////////////////////////////////////////////
                                    AppConstant.customSizedBox(0, 50),
                                    const Divider(),
                                    AppConstant.customSizedBox(0, 50),
                                    //////////////////////////////////////////////////////////////////////////////////////////////
                                    Text(
                                      "Appearance_status".tr(context),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 50.sp),
                                    ),
                                    AppConstant.customSizedBox(0, 20),
                                    CustomCheckBox(
                                        initalValue: state.productDetails!
                                            .mainInfo![0].isVisible!,
                                        valueForSecondRadio: "visible",
                                        titleForSecondRadio: "visible",
                                        valueForFirstRadio: "Not Visible",
                                        titleForFirstRadio: "not_visible"),
                                    //////////////////////////////////////////////////////////////////////////////////////////////
                                    AppConstant.customSizedBox(0, 50),
                                    const Divider(),
                                    AppConstant.customSizedBox(0, 50),
                                    //////////////////////////////////////////////////////////////////////////////////////////////
                                    Text(
                                      "store_status".tr(context),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 50.sp),
                                    ),
                                    AppConstant.customSizedBox(0, 20),
                                    CustomCheckBox(
                                        initalValue: state.productDetails!
                                            .mainInfo![0].isOutOfStock!,
                                        valueForFirstRadio: "available",
                                        titleForFirstRadio: "available",
                                        valueForSecondRadio: "Not available",
                                        titleForSecondRadio: "not_available"),
                                    //////////////////////////////////////////////////////////////////////////////////////////////
                                    AppConstant.customSizedBox(0, 50),
                                    const Divider(),
                                    AppConstant.customSizedBox(0, 50),
                                    //////////////////////////////////////////////////////////////////////////////////////////////
                                    Text(
                                      "product_price".tr(context),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 50.sp),
                                    ),
                                    AppConstant.customSizedBox(0, 20),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 0.7.sw,
                                          child: CustomTextFormField(
                                            initalValue: state.productDetails!
                                                .mainInfo![0].productPrice!,
                                            onChange: (value) {
                                              context
                                                  .read<SupplierProfileCubit>()
                                                  .changeproductPrice(value);
                                            },
                                          ),
                                        ),
                                        AppConstant.customSizedBox(50, 0),
                                        Text(
                                          "د.ع",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 50.sp),
                                        )
                                      ],
                                    ),
                                    //////////////////////////////////////////////////////////////////////////////////////////////
                                    AppConstant.customSizedBox(0, 50),
                                    const Divider(),
                                    AppConstant.customSizedBox(0, 50),
                                    //////////////////////////////////////////////////////////////////////////////////////////////
                                    Text(
                                      "discount_percentage".tr(context),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 50.sp),
                                    ),
                                    AppConstant.customSizedBox(0, 20),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 0.7.sw,
                                          child: CustomTextFormField(
                                            initalValue: state.productDetails!
                                                .mainInfo![0].productDiscount!,
                                            onChange: (value) {
                                              context
                                                  .read<SupplierProfileCubit>()
                                                  .changeproductDiscount(value);
                                            },
                                          ),
                                        ),
                                        AppConstant.customSizedBox(50, 0),
                                        Text(
                                          "%",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 50.sp),
                                        )
                                      ],
                                    ),
                                    //////////////////////////////////////////////////////////////////////////////////////////////
                                    AppConstant.customSizedBox(0, 50),
                                    const Divider(),
                                    AppConstant.customSizedBox(0, 50),
                                    //////////////////////////////////////////////////////////////////////////////////////////////
                                    Text(
                                      "the_final_price".tr(context),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 50.sp),
                                    ),
                                    AppConstant.customSizedBox(0, 20),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 0.7.sw,
                                          child: CustomTextFormField(
                                            initalValue: state
                                                .productDetails!
                                                .mainInfo![0]
                                                .productFinalPrice!,
                                            onChange: (value) {
                                              context
                                                  .read<SupplierProfileCubit>()
                                                  .changeproductFinalPrice(
                                                      value);
                                            },
                                          ),
                                        ),
                                        AppConstant.customSizedBox(50, 0),
                                        Text(
                                          "د.ع",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 50.sp),
                                        )
                                      ],
                                    ),
                                    //////////////////////////////////////////////////////////////////////////////////////////////
                                    AppConstant.customSizedBox(0, 50),
                                    const Divider(),
                                    AppConstant.customSizedBox(0, 50),
                                    //////////////////////////////////////////////////////////////////////////////////////////////
                                    ColorPickerProductDetailsWidget(
                                        initialColorArray: state
                                            .productDetails!.productColors),
                                    //////////////////////////////////////////////////////////////////////////////////////////////
                                    AppConstant.customSizedBox(0, 50),
                                    const Divider(),
                                    AppConstant.customSizedBox(0, 50),
                                    //////////////////////////////////////////////////////////////////////////////////////////////
                                    CategoriesScreen(
                                        productMainCategories: state
                                            .productDetails!
                                            .productMainCategories,
                                        productSubCategories: state
                                            .productDetails!
                                            .productSubCategories),
                                    //////////////////////////////////////////////////////////////////////////////////////////////
                                    AppConstant.customSizedBox(0, 50),
                                    const Divider(),
                                    AppConstant.customSizedBox(0, 50),
                                    //////////////////////////////////////////////////////////////////////////////////////////////
                                    SizesWidgetForEdite(
                                      productSizes:
                                          state.productDetails!.productSizes,
                                    ),
                                    //////////////////////////////////////////////////////////////////////////////////////////////
                                    AppConstant.customSizedBox(0, 50),
                                    const Divider(),
                                    AppConstant.customSizedBox(0, 50),
                                    //////////////////////////////////////////////////////////////////////////////////////////////

                                    SupllierProductAttachments(
                                        productAttachments: state
                                                .productDetails!
                                                .productAttachments ??
                                            [])
                                  ],
                                ),
                              ),
                            );
                          },
                        );
        },
      ),
    );
  }
}
