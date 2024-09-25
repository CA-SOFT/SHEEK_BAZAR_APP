// ignore_for_file: must_be_immutable

part of 'add_product_cubit.dart';

class AddProductState extends Equatable {
  AddProductState({
    this.productNameAr,
    this.productNameKu,
    this.productNameEn,
    this.productParagraphEn,
    this.productParagraphAr,
    this.productDescriptionAr,
    this.productParagraphKu,
    this.isUsed,
    this.productDescriptionEn,
    this.productPrice = "0",
    this.isVisible,
    this.sizeName = const [],
    this.colorHex = const [],
    this.categoryId = const [],
    this.subCategoryId = const [],
    this.attachmentType,
    this.productFinalPrice = "0",
    this.isOutOfStock,
    this.sendProduct = false,
    this.productDescriptionKu,
    this.productDiscount = "0",
    this.attachment,
    this.subcategories,
    this.categories,
  });
  bool? sendProduct;
  String? productNameAr,
      productNameKu,
      productNameEn,
      productParagraphAr,
      productDescriptionKu,
      productPrice,
      isUsed,
      productDiscount,
      isOutOfStock,
      productFinalPrice,
      isVisible,
      productParagraphEn,
      productDescriptionEn,
      productDescriptionAr,
      productParagraphKu;
  List<File>? attachment;
  List<dynamic>? sizeName;
  List<dynamic>? colorHex;
  List<dynamic>? categoryId;
  List<dynamic>? subCategoryId;
  List<String>? attachmentType;
  CategoriesModel? categories;
  List<SubCategory?>? subcategories;

  @override
  List<Object?> get props => [
        productNameAr,
        productParagraphAr,
        productDiscount,
        isOutOfStock,
        sizeName,
        sendProduct,
        productNameEn,
        attachmentType,
        productParagraphKu,
        productFinalPrice,
        productDescriptionKu,
        productPrice,
        categoryId,
        categories,
        subCategoryId,
        isUsed,
        productDescriptionEn,
        isVisible,
        colorHex,
        productDescriptionAr,
        productNameKu,
        attachment,
        subcategories,
        productParagraphEn
      ];
  AddProductState copyWith(
          {String? productNameAr,
          String? productParagraphKu,
          String? productNameEn,
          bool? sendProduct,
          String? productFinalPrice,
          String? productDiscount,
          String? isOutOfStock,
          String? productDescriptionAr,
          String? productPrice,
          String? isUsed,
          String? productDescriptionEn,
          String? isVisible,
          String? productDescriptionKu,
          String? productNameKu,
          String? productParagraphEn,
          String? productParagraphAr,
          List<File>? attachment,
          List<dynamic>? sizeName,
          List<dynamic>? colorHex,
          List<SubCategory?>? subcategories,
          List<dynamic>? subCategoryId,
          CategoriesModel? categories,
          List<dynamic>? categoryId,
          List<String>? attachmentType}) =>
      AddProductState(
          productNameAr: productNameAr ?? this.productNameAr,
          categories: categories ?? this.categories,
          attachmentType: attachmentType ?? this.attachmentType,
          productNameEn: productNameEn ?? this.productNameEn,
          categoryId: categoryId ?? this.categoryId,
          colorHex: colorHex ?? this.colorHex,
          productPrice: productPrice ?? this.productPrice,
          isOutOfStock: isOutOfStock ?? this.isOutOfStock,
          subcategories: subcategories ?? this.subcategories,
          subCategoryId: subCategoryId ?? this.subCategoryId,
          sizeName: sizeName ?? this.sizeName,
          productDiscount: productDiscount ?? this.productDiscount,
          productFinalPrice: productFinalPrice ?? this.productFinalPrice,
          isVisible: isVisible ?? this.isVisible,
          sendProduct: sendProduct ?? this.sendProduct,
          isUsed: isUsed ?? this.isUsed,
          productDescriptionKu:
              productDescriptionKu ?? this.productDescriptionKu,
          productDescriptionAr:
              productDescriptionAr ?? this.productDescriptionAr,
          productParagraphKu: productParagraphKu ?? this.productParagraphKu,
          productDescriptionEn:
              productDescriptionEn ?? this.productDescriptionEn,
          productParagraphEn: productParagraphEn ?? this.productParagraphEn,
          productParagraphAr: productParagraphAr ?? this.productParagraphAr,
          productNameKu: productNameKu ?? this.productNameKu,
          attachment: attachment ?? this.attachment);
}

class AddProductInitial extends AddProductState {}
