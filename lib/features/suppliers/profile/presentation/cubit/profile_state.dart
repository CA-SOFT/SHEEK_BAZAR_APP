// ignore_for_file: must_be_immutable, unnecessary_this

part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  ProfileState(
      {this.canEdite = false,
      this.bannerItems,
      this.newProductAttachments,
      this.lengthOfBannerItems,
      this.lengthNewOfBannerItems,
      this.productNameAR,
      this.productNameEn,
      this.productNameKU,
      this.productDescriptionAR,
      this.productDescriptionEN,
      this.productDescriptionKU,
      this.productParagraphAR,
      this.productParagraphEN,
      this.productParagraphKU,
      this.isUsed,
      this.isVisible,
      this.isOutOfStock,
      this.productPrice,
      this.productDiscount,
      this.subCategories,
      this.updateProduct = false,
      this.productFinalPrice,
      this.colorList,
      this.sizesList,
      this.productMainCategoriesList,
      this.productSubCategoriesList,
      this.removedAttachment,
      this.imagesAttachments,
      this.videosAttachments,
      this.loadedeAttachment});
  bool? canEdite;
  bool? updateProduct;
  List<Widget>? bannerItems;
  List<ProductAttachments>? newProductAttachments;
  List<List<SubCategory>?>? subCategories;
  String? lengthOfBannerItems;
  String? lengthNewOfBannerItems;
  String? productNameAR;
  String? productNameEn;
  String? productNameKU;
  String? productDescriptionAR;
  String? productDescriptionEN;
  String? productDescriptionKU;
  String? productParagraphAR;
  String? productParagraphEN;
  String? productParagraphKU;
  String? isUsed;
  String? isVisible;
  String? isOutOfStock;
  String? productPrice;
  String? productDiscount;
  String? productFinalPrice;
  List<dynamic>? colorList;
  List<dynamic>? sizesList;
  List<dynamic>? productMainCategoriesList;
  List<dynamic>? productSubCategoriesList;
  List<dynamic>? removedAttachment;
  List<File>? imagesAttachments;
  List<File>? videosAttachments;
  List<Widget>? loadedeAttachment;
  @override
  List<Object?> get props => [
        canEdite,
        bannerItems,
        lengthOfBannerItems,
        loadedeAttachment,
        productNameAR,
        subCategories,
        productNameEn,
        productNameKU,
        updateProduct,
        productDescriptionAR,
        productDescriptionEN,
        productDescriptionKU,
        productParagraphAR,
        productParagraphEN,
        productParagraphKU,
        isUsed,
        isVisible,
        isOutOfStock,
        productPrice,
        productDiscount,
        productFinalPrice,
        colorList,
        sizesList,
        productMainCategoriesList,
        productSubCategoriesList,
        imagesAttachments,
        removedAttachment,
        lengthNewOfBannerItems,
        videosAttachments,
        newProductAttachments,
      ];
  ProfileState copyWith(
          {bool? canEdite,
          bool? updateProduct,
          List<Widget>? bannerItems,
          List<ProductAttachments>? newProductAttachments,
          List<Widget>? loadedeAttachment,
          String? lengthOfBannerItems,
          String? productNameAR,
          String? productNameEn,
          String? productNameKU,
          String? productDescriptionAR,
          List<List<SubCategory>?>? subCategories,
          String? productDescriptionEN,
          String? productDescriptionKU,
          String? productParagraphAR,
          String? productParagraphEN,
          String? productParagraphKU,
          String? isUsed,
          String? isVisible,
          String? isOutOfStock,
          String? productPrice,
          String? productDiscount,
          String? productFinalPrice,
          List<dynamic>? colorList,
          List<dynamic>? sizesList,
          List<dynamic>? productMainCategoriesList,
          List<dynamic>? productSubCategoriesList,
          List<dynamic>? removedAttachment,
          List<File>? imagesAttachments,
          List<File>? videosAttachments,
          String? lengthNewOfBannerItems}) =>
      ProfileState(
        canEdite: canEdite ?? this.canEdite,
        updateProduct: updateProduct ?? this.updateProduct,
        productNameAR: productNameAR ?? this.productNameAR,
        productNameEn: productNameEn ?? this.productNameEn,
        productNameKU: productNameKU ?? this.productNameKU,
        subCategories: subCategories ?? this.subCategories,
        productDescriptionAR: productDescriptionAR ?? this.productDescriptionAR,
        productDescriptionEN: productDescriptionEN ?? this.productDescriptionEN,
        productDescriptionKU: productDescriptionKU ?? this.productDescriptionKU,
        productParagraphAR: productParagraphAR ?? this.productParagraphAR,
        productParagraphEN: productParagraphEN ?? this.productParagraphEN,
        productParagraphKU: productParagraphKU ?? this.productParagraphKU,
        isUsed: isUsed ?? this.isUsed,
        isVisible: isVisible ?? this.isVisible,
        isOutOfStock: isOutOfStock ?? this.isOutOfStock,
        productPrice: productPrice ?? this.productPrice,
        productDiscount: productDiscount ?? this.productDiscount,
        productFinalPrice: productFinalPrice ?? this.productFinalPrice,
        colorList: colorList ?? this.colorList,
        sizesList: sizesList ?? this.sizesList,
        productMainCategoriesList:
            productMainCategoriesList ?? this.productMainCategoriesList,
        productSubCategoriesList:
            productSubCategoriesList ?? this.productSubCategoriesList,
        imagesAttachments: imagesAttachments ?? this.imagesAttachments,
        lengthNewOfBannerItems:
            lengthNewOfBannerItems ?? this.lengthNewOfBannerItems,
        removedAttachment: removedAttachment ?? this.removedAttachment,
        videosAttachments: videosAttachments ?? this.videosAttachments,
        newProductAttachments:
            newProductAttachments ?? this.newProductAttachments,
        loadedeAttachment: loadedeAttachment ?? this.loadedeAttachment,
        bannerItems: bannerItems ?? this.bannerItems,
        lengthOfBannerItems: lengthOfBannerItems ?? this.lengthOfBannerItems,
      );
}

class ProfileInitial extends ProfileState {}
