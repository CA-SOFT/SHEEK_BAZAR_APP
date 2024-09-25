// ignore_for_file: prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/core/extentions/colors_to_hex.dart';
import 'package:sheek_bazar/core/utils/app_colors.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/core/utils/app_logger.dart';
import 'package:sheek_bazar/core/utils/cache_helper.dart';
import 'package:sheek_bazar/features/suppliers/profile/data/models/delete_product_model.dart';
import 'package:sheek_bazar/features/suppliers/profile/data/models/update_product_model.dart';
import 'package:sheek_bazar/features/suppliers/profile/data/repositories/delete_product_repo.dart';
import 'package:sheek_bazar/features/suppliers/profile/data/repositories/update_product_repo.dart';
import 'package:sheek_bazar/features/user/categories/data/models/categories_model.dart';
import 'package:sheek_bazar/features/user/home/data/models/productDetails_model.dart';
import 'package:sheek_bazar/features/user/home/presentation/cubit/home_cubit.dart';
import 'package:sheek_bazar/features/user/home/presentation/widgets/home_widgets.dart';
import 'package:sheek_bazar/features/user/shops/presentation/cubit/shops_cubit.dart';

part 'profile_state.dart';

class SupplierProfileCubit extends Cubit<ProfileState> {
  UpdateProductRepo updateProductRepo;
  DeleteProductRepo deleteProductRepo;
  SupplierProfileCubit(
      {required this.updateProductRepo, required this.deleteProductRepo})
      : super(ProfileInitial());

  Future<void> changeCanEditeValue(bool value) async {
    emit(state.copyWith(canEdite: value));
  }

  Future<void> addItemsToBanners(List<ProductAttachments>? productAttachments,
      BuildContext context) async {
    List items = [];
    emit(state.copyWith(
        lengthOfBannerItems: productAttachments!.length.toString()));

    for (int i = 0; i < productAttachments.length; i++) {
      items.add(productAttachments[i].attachmentType == "img"
          ? Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.r),
                    child: AppConstant.customNetworkImage(
                      imagePath: productAttachments[i].attachmentName!,
                    ),
                  ),
                ),
                state.canEdite == true
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          context
                              .read<ProductDetailsCubit>()
                              .deleteFromProductDetailsAttachment(
                                  productAttachments[i].attachmentId!, context);
                          changeremovedAttachment(
                              productAttachments[i].attachmentId!);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("delete".tr(context)),
                            const Icon(Icons.delete)
                          ],
                        ))
                    : const SizedBox()
              ],
            )
          : SizedBox(
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: VideoPlayerWidgetForPost(
                          videoUrl: productAttachments[i].attachmentName!,
                          uniqueNumber: i.toString()),
                    ),
                    state.canEdite == true
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              context
                                  .read<ProductDetailsCubit>()
                                  .deleteFromProductDetailsAttachment(
                                      productAttachments[i].attachmentId!,
                                      context);
                              changeremovedAttachment(
                                  productAttachments[i].attachmentId!);
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text("Delete"), Icon(Icons.delete)],
                            ))
                        : const SizedBox()
                  ],
                ),
              ),
            ));
    }
    List<Widget> widgets = items.cast<Widget>();

    widgets = items.cast<Widget>();
    emit(state.copyWith(bannerItems: []));
    emit(state.copyWith(bannerItems: widgets));
  }

  Future<void> addItemsToNewBanners(
      List<ProductAttachments>? productAttachments,
      BuildContext context) async {
    List items = [];
    emit(state.copyWith(
        lengthNewOfBannerItems: productAttachments!.length.toString()));

    for (int i = 0; i < productAttachments.length; i++) {
      items.add(productAttachments[i].attachmentType == "img"
          ? Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.r),
                    child: Image.file(
                      File(productAttachments[i].attachmentName!),
                    ),
                  ),
                ),
                state.canEdite == true
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          deleteFromNewAttachment(
                              productAttachments[i].attachmentName!, context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("delete".tr(context)),
                            const Icon(Icons.delete)
                          ],
                        ))
                    : const SizedBox()
              ],
            )
          : SizedBox(
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: VideoPlayerWidgetForPost(
                          videoUrl: productAttachments[i].attachmentName!,
                          uniqueNumber: i.toString()),
                    ),
                    state.canEdite == true
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              deleteFromNewAttachment(
                                  productAttachments[i].attachmentName!,
                                  context);
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text("Delete"), Icon(Icons.delete)],
                            ))
                        : const SizedBox()
                  ],
                ),
              ),
            ));
    }
    List<Widget> widgets = items.cast<Widget>();

    widgets = items.cast<Widget>();
    emit(state.copyWith(loadedeAttachment: []));
    emit(state.copyWith(loadedeAttachment: widgets));
  }

  Future addAttachmentToList(
      File attachment, String type, BuildContext context) async {
    List<ProductAttachments>? newList = [];
    newList.add(ProductAttachments(
        attachmentId: "1",
        attachmentName: attachment.path,
        attachmentType: type == "img" ? "img" : "video"));
    if (state.newProductAttachments != null) {
      for (int i = 0; i < state.newProductAttachments!.length; i++) {
        newList.add(state.newProductAttachments![i]);
      }
    }

    emit(state.copyWith(newProductAttachments: newList));
    addItemsToNewBanners(state.newProductAttachments, context);
    ////////////////////////////////////////////////////////
    if (type == "img") {
      List<File>? newAttachments = state.imagesAttachments ?? [];
      newAttachments.add(attachment);
      emit(state.copyWith(imagesAttachments: newAttachments));
    } else {
      List<File>? newAttachments = state.videosAttachments ?? [];
      newAttachments.add(attachment);
      emit(state.copyWith(videosAttachments: newAttachments));
    }
  }

  Future deleteFromNewAttachment(
      String attachment, BuildContext context) async {
    List<ProductAttachments>? newList = [];
    for (int i = 0; i < state.newProductAttachments!.length; i++) {
      if (state.newProductAttachments![i].attachmentName == attachment) {
        continue;
      } else {
        newList.add(state.newProductAttachments![i]);
      }
    }
    emit(state.copyWith(newProductAttachments: newList));
    addItemsToNewBanners(state.newProductAttachments, context);
    //////////////////////////////////////////////////////////
    List<File>? newImagesAttacments = [];
    List<File>? newVideosAttacments = [];
    for (int i = 0; i < state.newProductAttachments!.length; i++) {
      if (state.newProductAttachments![i].attachmentType == "img") {
        newImagesAttacments
            .add(File(state.newProductAttachments![i].attachmentName!));
      } else {
        newVideosAttacments
            .add(File(state.newProductAttachments![i].attachmentName!));
      }
    }
    emit(state.copyWith(imagesAttachments: newImagesAttacments));
    emit(state.copyWith(videosAttachments: newVideosAttacments));
  }

  Future<void> changeProductNameAr(String value) async {
    emit(state.copyWith(productNameAR: value));
  }

  Future<void> changeProductNameEN(String value) async {
    emit(state.copyWith(productNameEn: value));
  }

  Future<void> changeProductNameKU(String value) async {
    emit(state.copyWith(productNameKU: value));
  }

  Future<void> changeproductDescriptionAR(String value) async {
    emit(state.copyWith(productDescriptionAR: value));
  }

  Future<void> changeproductDescriptionEN(String value) async {
    emit(state.copyWith(productDescriptionEN: value));
  }

  Future<void> changeproductDescriptionKU(String value) async {
    emit(state.copyWith(productDescriptionKU: value));
  }

  Future<void> changeproductParagraphAR(String value) async {
    emit(state.copyWith(productParagraphAR: value));
  }

  Future<void> changeproductParagraphEN(String value) async {
    emit(state.copyWith(productParagraphEN: value));
  }

  Future<void> changeproductParagraphKU(String value) async {
    emit(state.copyWith(productParagraphKU: value));
  }

  Future<void> changeIsused(String value) async {
    emit(state.copyWith(isUsed: value));
  }

  Future<void> changeoutOfStock(String value) async {
    emit(state.copyWith(isOutOfStock: value));
  }

  Future<void> changeIsVisible(String value) async {
    emit(state.copyWith(isVisible: value));
  }

  Future<void> changeproductPrice(String value) async {
    emit(state.copyWith(productPrice: value));
  }

  Future<void> changeproductDiscount(String value) async {
    emit(state.copyWith(productDiscount: value));
  }

  Future<void> changeproductFinalPrice(String value) async {
    emit(state.copyWith(productFinalPrice: value));
  }

  Future<void> changecolorList(List<dynamic> value) async {
    emit(state.copyWith(colorList: value));
  }

  Future<void> changesizesList(List<dynamic> value) async {
    emit(state.copyWith(sizesList: value));
  }

  Future<void> changeSubCategoriesForSelection(
      List<SubCategory?>? productSubCategories,
      List<Category?>? productMainCategories) async {
    // print(productSubCategories);
    // print(productMainCategories);
    List<List<SubCategory>?> newSubList = [];
    for (int i = 0; i < productMainCategories!.length; i++) {
      List<SubCategory>? newList = [];
      for (int j = 0; j < productSubCategories!.length; j++) {
        if (productMainCategories[i]!.categoryid ==
            productSubCategories[j]!.categoryParent) {
          newList.add(productSubCategories[j]!);
        }
      }
      newSubList.add(newList);
    }
    emit(state.copyWith(subCategories: newSubList));
    // print(state.subCategories);
  }

  Future<void> changeproductMainCategoriesList(List<dynamic> value) async {
    emit(state.copyWith(productMainCategoriesList: value));
  }

  Future<void> changeproductSubCategoriesList(List<dynamic> value) async {
    emit(state.copyWith(productSubCategoriesList: value));
  }

  Future<void> changeremovedAttachment(String value) async {
    List<dynamic>? newList = state.removedAttachment ?? [];
    newList.add(value);
    emit(state.copyWith(removedAttachment: newList));
  }

  Future<void> updateProduct(BuildContext context, String productID,
      ProductDetailsModel productDetails) async {
    try {
      if (state.productNameAR == null) {
        await changeProductNameAr(productDetails.mainInfo![0].productNameAr!);
      } else {
        if (state.productNameAR!.isEmpty) {
          changeProductNameAr(productDetails.mainInfo![0].productNameAr!);
        }
      }
      //////////////////////////////////////////////////////
      if (state.productNameEn == null) {
        await changeProductNameEN(productDetails.mainInfo![0].productNameEn!);
      } else {
        if (state.productNameEn!.isEmpty) {
          changeProductNameEN(productDetails.mainInfo![0].productNameEn!);
        }
      }
      //////////////////////////////////////////////////////
      if (state.productNameKU == null) {
        await changeProductNameKU(productDetails.mainInfo![0].productNameKu!);
      } else {
        if (state.productNameKU!.isEmpty) {
          changeProductNameKU(productDetails.mainInfo![0].productNameKu!);
        }
      }
      //////////////////////////////////////////////////////
      if (state.productDescriptionAR == null) {
        await changeproductDescriptionAR(
            productDetails.mainInfo![0].productDescriptionAr!);
      } else {
        if (state.productDescriptionAR!.isEmpty) {
          await changeproductDescriptionAR(
              productDetails.mainInfo![0].productDescriptionAr!);
        }
      }
      //////////////////////////////////////////////////////
      if (state.productDescriptionEN == null) {
        await changeproductDescriptionEN(
            productDetails.mainInfo![0].productDescriptionEn!);
      } else {
        if (state.productDescriptionEN!.isEmpty) {
          await changeproductDescriptionEN(
              productDetails.mainInfo![0].productDescriptionEn!);
        }
      }
      //////////////////////////////////////////////////////
      if (state.productDescriptionKU == null) {
        await changeproductDescriptionKU(
            productDetails.mainInfo![0].productDescriptionKu!);
      } else {
        if (state.productDescriptionKU!.isEmpty) {
          await changeproductDescriptionKU(
              productDetails.mainInfo![0].productDescriptionKu!);
        }
      }
      //////////////////////////////////////////////////////
      if (state.productParagraphAR == null) {
        await changeproductParagraphAR(
            productDetails.mainInfo![0].productParagraphAr!);
      } else {
        if (state.productParagraphAR!.isEmpty) {
          await changeproductParagraphAR(
              productDetails.mainInfo![0].productParagraphAr!);
        }
      }
      //////////////////////////////////////////////////////
      if (state.productParagraphEN == null) {
        await changeproductParagraphEN(
            productDetails.mainInfo![0].productParagraphEn!);
      } else {
        if (state.productParagraphEN!.isEmpty) {
          await changeproductParagraphEN(
              productDetails.mainInfo![0].productParagraphEn!);
        }
      }
      //////////////////////////////////////////////////////
      if (state.productParagraphKU == null) {
        await changeproductParagraphKU(
            productDetails.mainInfo![0].productParagraphKu!);
      } else {
        if (state.productParagraphKU!.isEmpty) {
          await changeproductParagraphKU(
              productDetails.mainInfo![0].productParagraphKu!);
        }
      }
      //////////////////////////////////////////////////////
      if (state.isUsed == null) {
        await changeIsused(productDetails.mainInfo![0].isUsed!);
      } else {
        if (state.isUsed!.isEmpty) {
          changeIsused(productDetails.mainInfo![0].isUsed!);
        }
      }
      //////////////////////////////////////////////////////
      if (state.isVisible == null) {
        await changeIsVisible(productDetails.mainInfo![0].isVisible!);
      } else {
        if (state.isVisible!.isEmpty) {
          changeIsVisible(productDetails.mainInfo![0].isVisible!);
        }
      }
      //////////////////////////////////////////////////////
      if (state.isOutOfStock == null) {
        await changeoutOfStock(productDetails.mainInfo![0].isOutOfStock!);
      } else {
        if (state.isOutOfStock!.isEmpty) {
          changeoutOfStock(productDetails.mainInfo![0].isOutOfStock!);
        }
      }
      //////////////////////////////////////////////////////
      if (state.productPrice == null) {
        await changeproductPrice(productDetails.mainInfo![0].productPrice!);
      } else {
        if (state.productPrice!.isEmpty) {
          changeproductPrice(productDetails.mainInfo![0].productPrice!);
        }
      }
      //////////////////////////////////////////////////////
      if (state.productDiscount == null) {
        await changeproductDiscount(
            productDetails.mainInfo![0].productDiscount!);
      } else {
        if (state.productDiscount!.isEmpty) {
          await changeproductDiscount(
              productDetails.mainInfo![0].productDiscount!);
        }
      }
      //////////////////////////////////////////////////////
      if (state.productFinalPrice == null) {
        await changeproductFinalPrice(
            productDetails.mainInfo![0].productFinalPrice!);
      } else {
        if (state.productFinalPrice!.isEmpty) {
          await changeproductFinalPrice(
              productDetails.mainInfo![0].productFinalPrice!);
        }
      }
      //////////////////////////////////////////////////////
      if (state.sizesList == null) {
        List<dynamic> newList = [];
        for (int i = 0; i < productDetails.productSizes!.length; i++) {
          newList.add(productDetails.productSizes![i].sizeName);
        }
        await changesizesList(newList);
      } else {
        if (state.sizesList!.isEmpty) {
          List<dynamic> newList = [];

          for (int i = 0; i < productDetails.productSizes!.length; i++) {
            newList.add(productDetails.productSizes![i].sizeName);
          }
          await changesizesList(newList);
        }
      }
      //////////////////////////////////////////////////////
      if (state.productMainCategoriesList == null) {
        List<dynamic> newList = [];
        for (int i = 0; i < productDetails.productMainCategories!.length; i++) {
          newList.add(productDetails.productMainCategories![i].categoryId);
        }
        await changeproductMainCategoriesList(newList);
      } else {
        if (state.productMainCategoriesList!.isEmpty) {
          List<dynamic> newList = [];
          for (int i = 0;
              i < productDetails.productMainCategories!.length;
              i++) {
            newList.add(productDetails.productMainCategories![i].categoryId);
          }
          changeproductMainCategoriesList(newList);
        }
      }
      //////////////////////////////////////////////////////
      if (state.productSubCategoriesList == null) {
        List<dynamic> newList = [];
        for (int i = 0; i < productDetails.productSubCategories!.length; i++) {
          newList.add(productDetails.productSubCategories![i].categoryId);
        }
        await changeproductSubCategoriesList(newList);
      } else {
        if (state.productSubCategoriesList!.isEmpty) {
          List<dynamic> newList = [];
          for (int i = 0;
              i < productDetails.productSubCategories!.length;
              i++) {
            newList.add(productDetails.productSubCategories![i].categoryId);
          }
          changeproductSubCategoriesList(newList);
        }
      }
      //////////////////////////////////////////////////////
      if (state.colorList == null) {
        List<dynamic> newList = [];
        for (int i = 0; i < productDetails.productColors!.length; i++) {
          newList.add(
              HexColor.fromHex(productDetails.productColors![i].colorHex!));
        }
        await changecolorList(newList);
      } else {
        if (state.colorList!.isEmpty) {
          List<dynamic> newList = [];
          for (int i = 0; i < productDetails.productColors!.length; i++) {
            newList.add(
                HexColor.fromHex(productDetails.productColors![i].colorHex!));
          }
          await changecolorList(newList);
        }
      }
      //////////////////////////////////////////////////////
      emit(state.copyWith(updateProduct: true));
      var supllierId = CacheHelper.getData(key: "SUPPLIER_ID");
      var collorArray = [];
      for (int i = 0; i < state.colorList!.length; i++) {
        String hexColor =
            '#' + state.colorList![i].value.toRadixString(16).padLeft(8, '0');
        collorArray.add(hexColor);
      }
      var combinedList = [];
      for (int i = 0; i < state.productMainCategoriesList!.length; i++) {
        combinedList.add(state.productMainCategoriesList![i]);
      }
      for (int i = 0; i < state.productSubCategoriesList!.length; i++) {
        combinedList.add(state.productSubCategoriesList![i]);
      }
      bool continureUpdating = true;
      var imageList = state.imagesAttachments ?? [];
      var videosList = state.videosAttachments ?? [];
      var removedList = productDetails.productAttachments ?? [];

      if (imageList.isEmpty && videosList.isEmpty && removedList.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            padding: EdgeInsets.only(
                bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
            content: Text(
              'you_must_upload_at_least_one_photo'.tr(context),
              style: const TextStyle(color: AppColors.whiteColor),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
        continureUpdating = false;
      }

      if (continureUpdating) {
        Map<String, String> body = {};
        body['update_product'] = "1";
        body['product_id'] = productID;
        body['product_name_ar'] = state.productNameAR ?? "";
        body['product_name_en'] = state.productNameEn ?? "";
        body['product_name_ku'] = state.productNameKU ?? "";
        body['product_paragraph_ar'] = state.productParagraphAR ?? "";
        body['product_paragraph_en'] = state.productParagraphEN ?? "";
        body['product_paragraph_ku'] = state.productParagraphKU ?? "";
        body['product_description_ar'] = state.productDescriptionAR ?? "";
        body['product_description_en'] = state.productDescriptionEN ?? "";
        body['product_description_ku'] = state.productDescriptionKU ?? "";
        body['supplier_id'] = "$supllierId";
        body['is_used'] = state.isUsed ?? "";
        body['is_visible'] = state.isVisible ?? "";
        body['is_out_of_stock'] = state.isOutOfStock ?? "";
        body['product_price'] = state.productPrice ?? "";
        body['product_discount'] = state.productDiscount ?? "";
        body['product_final_price'] = state.productFinalPrice ?? "";

        for (int i = 0; i < state.sizesList!.length; i++) {
          body['size_name[$i]'] = state.sizesList![i];
        }

        for (int i = 0; i < collorArray.length; i++) {
          body['color_hex[$i]'] = collorArray[i];
        }
        for (int i = 0; i < combinedList.length; i++) {
          body['category_id[$i]'] = combinedList[i];
        }
        if (state.removedAttachment != null) {
          for (int i = 0; i < state.removedAttachment!.length; i++) {
            body['removed_attachments[$i]'] = state.removedAttachment![i];
          }
        }

        UpdateProductModel data = await updateProductRepo.AddProduct(
            body, state.imagesAttachments, state.videosAttachments);
        if (data.status == 1) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              padding: EdgeInsets.only(
                  bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
              content: Text(
                'update_product'.tr(context),
                style: const TextStyle(color: AppColors.whiteColor),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
          Navigator.pop(context);
          context
              .read<ShopsCubit>()
              .getProducts(context, supllierId, "-1", "-1");
          emit(state.copyWith(
              bannerItems: [],
              canEdite: false,
              colorList: [],
              imagesAttachments: [],
              isOutOfStock: "",
              isUsed: "",
              isVisible: "",
              lengthNewOfBannerItems: "",
              lengthOfBannerItems: "",
              loadedeAttachment: [],
              newProductAttachments: [],
              productDescriptionAR: "",
              productDescriptionEN: "",
              productDescriptionKU: "",
              productDiscount: "",
              productFinalPrice: "",
              productMainCategoriesList: [],
              productNameAR: "",
              productNameEn: "",
              productNameKU: "",
              productParagraphAR: "",
              productParagraphEN: "",
              productParagraphKU: "",
              productPrice: "",
              productSubCategoriesList: [],
              removedAttachment: [],
              sizesList: [],
              videosAttachments: []));
        }
      }
      emit(state.copyWith(updateProduct: false));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(updateProduct: false));

      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  Future<void> deleteProduct(BuildContext context, String productId) async {
    try {
      var supllierId = CacheHelper.getData(key: "SUPPLIER_ID");

      Map<String, String> body = {};
      body['delete_product'] = "1";
      body['product_id'] = productId;

      DeleteProductModel data = await deleteProductRepo.deleteProduct(body);
      if (data.message == "Product deleted successfully.") {
        await AppConstant.customAlert(context, "Product_deleted_successfully",
            witherror: false, withTranslate: true);
        Navigator.pop(context);
        context.read<ShopsCubit>().getProducts(context, supllierId, "-1", "-1");
      } else if (data.message ==
          "Product is associated with pending orders and cannot be deleted.") {
        await AppConstant.customAlert(context, "The_order_cannot_be_deleted",
            witherror: true, withTranslate: true, second: 3);
      }
    } catch (e) {
      logger.e(e);

      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }
}
