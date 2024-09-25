// ignore_for_file: use_build_context_synchronously, prefer_interpolation_to_compose_strings, non_constant_identifier_names, unused_local_variable

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/core/utils/app_colors.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/core/utils/app_logger.dart';
import 'package:sheek_bazar/core/utils/cache_helper.dart';
import 'package:sheek_bazar/features/suppliers/HomeScreenForSupllier/presentation/pages/home_supplier_screen.dart';
import 'package:sheek_bazar/features/suppliers/add_product/data/models/add_product_model.dart';
import 'package:sheek_bazar/features/suppliers/add_product/data/repositories/add_product_repo.dart';
import 'package:sheek_bazar/features/user/categories/data/models/categories_model.dart';
import 'package:sheek_bazar/features/user/shops/presentation/pages/shopDetails_screen.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductRepo addProductRepo;
  AddProductCubit({required this.addProductRepo}) : super(AddProductInitial());

  Future<void> changeProductNameAr(String? productNameAr) async {
    emit(state.copyWith(productNameAr: productNameAr));
  }

  Future<void> changeProductNameEn(String? productNameEn) async {
    emit(state.copyWith(productNameEn: productNameEn));
  }

  Future<void> changeProductNameKu(String? productNameKu) async {
    emit(state.copyWith(productNameKu: productNameKu));
  }

  Future<void> changeproductDescriptionAr(String? productDescriptionAr) async {
    emit(state.copyWith(productDescriptionAr: productDescriptionAr));
  }

  Future<void> changeproductDescriptionEn(String? productDescriptionEn) async {
    emit(state.copyWith(productDescriptionEn: productDescriptionEn));
  }

  Future<void> changeproductDescriptionKu(String? productDescriptionKu) async {
    emit(state.copyWith(productDescriptionKu: productDescriptionKu));
  }

  Future<void> changeproductParagraphAr(String? productParagraphAr) async {
    emit(state.copyWith(productParagraphAr: productParagraphAr));
  }

  Future<void> changeproductParagraphEn(String? productParagraphEn) async {
    emit(state.copyWith(productParagraphEn: productParagraphEn));
  }

  Future<void> changeproductParagraphKu(String? productParagraphKu) async {
    emit(state.copyWith(productParagraphKu: productParagraphKu));
  }

  // Future<void> changeproductPoints(String? productPoints) async {
  //   emit(state.copyWith(productPoints: productPoints));
  // }

  Future<void> changeisUsed(String? isUsed) async {
    emit(state.copyWith(isUsed: isUsed));
  }

  Future<void> changeisVisible(String? isVisible) async {
    emit(state.copyWith(isVisible: isVisible));
  }

  Future<void> changeisOutOfStock(String? isOutOfStock) async {
    emit(state.copyWith(isOutOfStock: isOutOfStock));
  }

  Future<void> changeproductPrice(String? productPrice) async {
    emit(state.copyWith(productPrice: productPrice));
  }

  Future<void> changeproductDiscount(String? productDiscount) async {
    emit(state.copyWith(productDiscount: productDiscount));
  }

  Future<void> changeproductFinalPrice() async {
    double per = double.parse(state.productDiscount!);
    double beforedes = double.parse(state.productPrice!);

    double percentvalue = per * beforedes / 100;

    int value = (beforedes - percentvalue).toInt();

    emit(state.copyWith(productFinalPrice: value.toString()));
  }

  Future<void> changeCategories(CategoriesModel? cat) async {
    emit(state.copyWith(categories: cat));
  }

  Future<void> changecategoryId(List<dynamic> categoryId) async {
    emit(state.copyWith(categoryId: categoryId));
  }

  Future<void> changeSubGategorey(var index) async {
    List<SubCategory?>? newList = [];
    for (int i = 0; i < state.categories!.subcategories!.length; i++) {
      if (state.categories!.subcategories![i]!.categoryParent == index) {
        newList.add(state.categories!.subcategories![i]!);
      }
    }
    emit(state.copyWith(subcategories: []));
    emit(state.copyWith(subcategories: newList));
  }

  Future<void> changesubCategoryId(List<dynamic> subCategoryId) async {
    emit(state.copyWith(subCategoryId: subCategoryId));
  }

  Future<void> changesizeName(List<dynamic> sizeName) async {
    emit(state.copyWith(sizeName: sizeName));
    // print(state.sizeName);
  }

  Future<void> changecolorHex(var colorHex) async {
    emit(state.copyWith(colorHex: colorHex));
  }

  Future<void> cleanattachment(List<File>? newAttachment) async {
    emit(state.copyWith(attachment: newAttachment));
  }

  Future<void> changeattachment(File newattachment) async {
    List<File>? newArray = state.attachment ?? [];
    newArray.add(newattachment);
    emit(state.copyWith(attachment: newArray));
  }

  Future<void> changeattachmentType(String newattachmentType) async {
    List<String>? newArray = state.attachmentType ?? [];
    newArray.add(newattachmentType);
    emit(state.copyWith(attachmentType: newArray));
  }

  Future<void> AddProduct(BuildContext context) async {
    try {
      emit(state.copyWith(sendProduct: true));
      var supllierId = CacheHelper.getData(key: "SUPPLIER_ID");
      var collorArray = [];
      for (int i = 0; i < state.colorHex!.length; i++) {
        String hexColor =
            '#' + state.colorHex![i].value.toRadixString(16).padLeft(8, '0');
        collorArray.add(hexColor);
      }
      var combinedList = [];
      for (int i = 0; i < state.categoryId!.length; i++) {
        combinedList.add(state.categoryId![i]);
      }
      for (int i = 0; i < state.subCategoryId!.length; i++) {
        combinedList.add(state.subCategoryId![i]);
      }
      Map<String, String> body = {};
      body['insert_product'] = "1";
      body['product_name_ar'] = state.productNameAr ?? "";
      // body['product_points'] = state.productPoints ?? "";
      body['product_name_en'] = state.productNameEn ?? "";
      body['product_name_ku'] = state.productNameKu ?? "";
      body['product_paragraph_ar'] = state.productParagraphAr ?? "";
      body['product_paragraph_en'] = state.productParagraphEn ?? "";
      body['product_paragraph_ku'] = state.productParagraphKu ?? "";
      body['product_description_ar'] = state.productDescriptionAr ?? "";
      body['product_description_en'] = state.productDescriptionEn ?? "";
      body['product_description_ku'] = state.productDescriptionKu ?? "";
      body['supplier_id'] = "$supllierId";
      body['is_used'] = state.isUsed ?? "";
      body['is_visible'] = state.isVisible ?? "";
      body['is_out_of_stock'] = state.isOutOfStock ?? "";
      body['product_price'] = state.productPrice ?? "";
      body['product_discount'] = state.productDiscount ?? "";
      body['product_final_price'] = state.productFinalPrice ?? "";
      for (int i = 0; i < state.attachmentType!.length; i++) {
        body['attachment_type[$i]'] = state.attachmentType![i];
      }
      for (int i = 0; i < state.sizeName!.length; i++) {
        body['size_name[$i]'] = state.sizeName![i];
      }

      for (int i = 0; i < collorArray.length; i++) {
        body['color_hex[$i]'] = collorArray[i];
      }
      for (int i = 0; i < combinedList.length; i++) {
        body['category_id[$i]'] = combinedList[i];
      }

      AddProductModel data =
          await addProductRepo.AddProduct(body, state.attachment);
      if (data.status == 1) {
        emit(state.copyWith(
            subCategoryId: [],
            productNameAr: "",
            productNameEn: "",
            productNameKu: "",
            productParagraphAr: "",
            productParagraphEn: "",
            productParagraphKu: "",
            isVisible: "",
            isUsed: "",
            productDescriptionAr: "",
            productDescriptionEn: "",
            productDescriptionKu: "",
            categoryId: [],
            colorHex: [],
            sizeName: [],
            attachmentType: [],
            attachment: [],
            productFinalPrice: "",
            productDiscount: "",
            productPrice: "",
            isOutOfStock: ""));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            padding: EdgeInsets.only(
                bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
            content: Text(
              "insert_product_successfully".tr(context),
              style: const TextStyle(color: AppColors.whiteColor),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
        String supplierId = CacheHelper.getData(key: "SUPPLIER_ID");
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomeSupplier(
              number: 1,
            ),
          ),
          (Route route) => false,
        );
        AppConstant.customNavigation(
            context,
            ShopDetailsScreen(
              fromSupllier: true,
              supplierId: supplierId,
            ),
            0,
            -1);
      }
      emit(state.copyWith(sendProduct: false));
    } catch (e) {
      emit(state.copyWith(sendProduct: false));

      logger.e(e);
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////

  ValidateForOnevariable(BuildContext context, var value) {
    if (value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.only(
              bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
          content: Text(
            'Insert all Fields'.tr(context),
            style: const TextStyle(color: Colors.red),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      return false;
    }
    if (value != null) {
      if (value!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.primaryColor,
            padding: EdgeInsets.only(
                bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
            content: Text(
              'Insert all Fields'.tr(context),
              style: const TextStyle(color: Colors.red),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
        return false;
      }
    }
    return true;
  }

  fieldsValidationForOneStep(BuildContext context) {
    bool isused = true, outofstock = true, isvisible = true;
    if (state.isUsed == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.only(
              bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
          content: const Text(
            'insert if is used or not',
            style: TextStyle(color: Colors.red),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      isused = false;
    }
    ////////////////////////////////////////////
    if (state.isVisible == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.only(
              bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
          content: const Text(
            'insert if is visible or not',
            style: TextStyle(color: Colors.red),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      isvisible = false;
    }
    ////////////////////////////////////////////
    if (state.isOutOfStock == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.only(
              bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
          content: const Text(
            'insert if is out of stock or not',
            style: TextStyle(color: Colors.red),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      outofstock = false;
    }
    if (ValidateForOnevariable(context, state.productNameAr) == true &&
        ValidateForOnevariable(context, state.productNameEn) == true &&
        ValidateForOnevariable(context, state.productNameKu) == true &&
        // ValidateForOnevariable(context, state.productDescriptionAr) == true &&
        // ValidateForOnevariable(context, state.productDescriptionEn) == true &&
        // ValidateForOnevariable(context, state.productDescriptionKu) == true &&
        // ValidateForOnevariable(context, state.productParagraphAr) == true &&
        // ValidateForOnevariable(context, state.productParagraphEn) == true &&
        // ValidateForOnevariable(context, state.productParagraphKu) == true &&
        ValidateForOnevariable(context, state.productPrice) == true &&
        ValidateForOnevariable(context, state.productDiscount) == true &&
        ValidateForOnevariable(context, state.productFinalPrice) == true &&
        // ValidateForOnevariable(context, state.productPoints) == true &&
        isvisible &&
        outofstock &&
        isvisible) {
      return true;
    }

    return false;
  }

  fieldsValidationForSecondStep(BuildContext context) {
    if (ValidateForOnevariable(context, state.categoryId) == true &&
        ValidateForOnevariable(context, state.subCategoryId) == true) {
      return true;
    }

    return false;
  }

  fieldsValidationForThirdStep(BuildContext context) {
    // if (ValidateForOnevariable(context, state.sizeName) == true &&
    //     ValidateForOnevariable(context, state.colorHex) == true) {
    //   return true;
    // }

    return true;
  }

  fieldsValidationForFourthStep(BuildContext context) {
    if (ValidateForOnevariable(context, state.attachmentType) == true &&
        ValidateForOnevariable(context, state.attachment) == true) {
      return true;
    }

    return false;
  }
}
