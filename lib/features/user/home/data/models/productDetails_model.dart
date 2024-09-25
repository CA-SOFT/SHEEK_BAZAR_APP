// ignore_for_file: file_names, prefer_typing_uninitialized_variables

class ProductDetailsModel {
  List<MainInfo>? mainInfo;
  List<ProductAttachments>? productAttachments;
  List<ProductColors>? productColors;
  List<ProductSizes>? productSizes;
  List<SimilarProducts>? similarProducts;
  List<ProductMainCategories>? productMainCategories;
  List<ProductSubCategories>? productSubCategories;

  ProductDetailsModel(
      {this.mainInfo,
      this.productAttachments,
      this.productColors,
      this.productSizes,
      this.productMainCategories,
      this.productSubCategories,
      this.similarProducts});

  ProductDetailsModel.fromJson(Map<String, dynamic>? json) {
    if (json?['main_info'] != null) {
      mainInfo = <MainInfo>[];
      json?['main_info'].forEach((v) {
        mainInfo!.add(MainInfo.fromJson(v));
      });
    }
    if (json?['product_attachments'] != null) {
      productAttachments = <ProductAttachments>[];
      json?['product_attachments'].forEach((v) {
        productAttachments!.add(ProductAttachments.fromJson(v));
      });
    }
    if (json?['product_colors'] != null) {
      productColors = <ProductColors>[];
      json?['product_colors'].forEach((v) {
        productColors!.add(ProductColors.fromJson(v));
      });
    }
    if (json?['product_sizes'] != null) {
      productSizes = <ProductSizes>[];
      json?['product_sizes'].forEach((v) {
        productSizes!.add(ProductSizes.fromJson(v));
      });
    }
    if (json?['similar_products'] != null) {
      similarProducts = <SimilarProducts>[];
      json?['similar_products'].forEach((v) {
        similarProducts!.add(SimilarProducts.fromJson(v));
      });
    }
    if (json?['product_main_categories'] != null) {
      productMainCategories = <ProductMainCategories>[];
      json?['product_main_categories'].forEach((v) {
        productMainCategories!.add(ProductMainCategories.fromJson(v));
      });
    }
    if (json?['product_sub_categories'] != null) {
      productSubCategories = <ProductSubCategories>[];
      json?['product_sub_categories'].forEach((v) {
        productSubCategories!.add(ProductSubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mainInfo != null) {
      data['main_info'] = mainInfo!.map((v) => v.toJson()).toList();
    }
    if (productAttachments != null) {
      data['product_attachments'] =
          productAttachments!.map((v) => v.toJson()).toList();
    }
    if (productColors != null) {
      data['product_colors'] = productColors!.map((v) => v.toJson()).toList();
    }
    if (productSizes != null) {
      data['product_sizes'] = productSizes!.map((v) => v.toJson()).toList();
    }
    if (similarProducts != null) {
      data['similar_products'] =
          similarProducts!.map((v) => v.toJson()).toList();
    }
    if (productMainCategories != null) {
      data['product_main_categories'] =
          productMainCategories!.map((v) => v.toJson()).toList();
    }
    if (productSubCategories != null) {
      data['product_sub_categories'] =
          productSubCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductSubCategories {
  String? categoryId;
  String? categoryType;
  String? categoryNameAr;
  String? categoryNameEn;
  String? categoryNameKu;
  String? categoryImg;
  var categoryParent;
  String? viewInLaundry;
  String? id;
  String? productId;

  ProductSubCategories(
      {this.categoryId,
      this.categoryType,
      this.categoryNameAr,
      this.categoryNameEn,
      this.categoryNameKu,
      this.categoryImg,
      this.categoryParent,
      this.viewInLaundry,
      this.id,
      this.productId});

  ProductSubCategories.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryType = json['category_type'];
    categoryNameAr = json['category_name_ar'];
    categoryNameEn = json['category_name_en'];
    categoryNameKu = json['category_name_ku'];
    categoryImg = json['category_img'];
    categoryParent = json['category_parent'];
    viewInLaundry = json['view_in_laundry'];
    id = json['id'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['category_type'] = categoryType;
    data['category_name_ar'] = categoryNameAr;
    data['category_name_en'] = categoryNameEn;
    data['category_name_ku'] = categoryNameKu;
    data['category_img'] = categoryImg;
    data['category_parent'] = categoryParent;
    data['view_in_laundry'] = viewInLaundry;
    data['id'] = id;
    data['product_id'] = productId;
    return data;
  }
}

class ProductMainCategories {
  String? categoryId;
  String? categoryType;
  String? categoryNameAr;
  String? categoryNameEn;
  String? categoryNameKu;
  String? categoryImg;
  var categoryParent;
  String? viewInLaundry;
  String? id;
  String? productId;

  ProductMainCategories(
      {this.categoryId,
      this.categoryType,
      this.categoryNameAr,
      this.categoryNameEn,
      this.categoryNameKu,
      this.categoryImg,
      this.categoryParent,
      this.viewInLaundry,
      this.id,
      this.productId});

  ProductMainCategories.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryType = json['category_type'];
    categoryNameAr = json['category_name_ar'];
    categoryNameEn = json['category_name_en'];
    categoryNameKu = json['category_name_ku'];
    categoryImg = json['category_img'];
    categoryParent = json['category_parent'];
    viewInLaundry = json['view_in_laundry'];
    id = json['id'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['category_type'] = categoryType;
    data['category_name_ar'] = categoryNameAr;
    data['category_name_en'] = categoryNameEn;
    data['category_name_ku'] = categoryNameKu;
    data['category_img'] = categoryImg;
    data['category_parent'] = categoryParent;
    data['view_in_laundry'] = viewInLaundry;
    data['id'] = id;
    data['product_id'] = productId;
    return data;
  }
}

class MainInfo {
  String? productId;
  String? productNameAr;
  String? productNameEn;
  String? productNameKu;
  String? productParagraphAr;
  String? productParagraphEn;
  String? productParagraphKu;
  String? productDescriptionAr;
  String? productDescriptionEn;
  String? productDescriptionKu;
  String? supplierId;
  String? supplierName;
  String? isUsed;
  String? isVisible;
  String? isOutOfStock;
  String? productPrice;
  String? productDiscount;
  String? productFinalPrice;
  String? productPoints;
  String? supplierPhone;

  MainInfo(
      {this.productId,
      this.productNameAr,
      this.productNameEn,
      this.productNameKu,
      this.productParagraphAr,
      this.productParagraphEn,
      this.productParagraphKu,
      this.productDescriptionAr,
      this.productDescriptionEn,
      this.productDescriptionKu,
      this.supplierId,
      this.supplierName,
      this.isUsed,
      this.isVisible,
      this.isOutOfStock,
      this.productPrice,
      this.productDiscount,
      this.productFinalPrice,
      this.productPoints,
      this.supplierPhone});

  MainInfo.fromJson(Map<String, dynamic>? json) {
    productId = json?['product_id'];
    productNameAr = json?['product_name_ar'];
    productNameEn = json?['product_name_en'];
    productNameKu = json?['product_name_ku'];
    productParagraphAr = json?['product_paragraph_ar'];
    productParagraphEn = json?['product_paragraph_en'];
    productParagraphKu = json?['product_paragraph_ku'];
    productDescriptionAr = json?['product_description_ar'];
    productDescriptionEn = json?['product_description_en'];
    productDescriptionKu = json?['product_description_ku'];
    supplierId = json?['supplier_id'];
    supplierName = json?['supplier_name'];
    isUsed = json?['is_used'];
    isVisible = json?['is_visible'];
    isOutOfStock = json?['is_out_of_stock'];
    productPrice = json?['product_price'];
    productDiscount = json?['product_discount'];
    productFinalPrice = json?['product_final_price'];
    productPoints = json?['product_points'];
    supplierPhone = json?['supplier_phone'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_name_ar'] = productNameAr;
    data['product_name_en'] = productNameEn;
    data['product_name_ku'] = productNameKu;
    data['product_paragraph_ar'] = productParagraphAr;
    data['product_paragraph_en'] = productParagraphEn;
    data['product_paragraph_ku'] = productParagraphKu;
    data['product_description_ar'] = productDescriptionAr;
    data['product_description_en'] = productDescriptionEn;
    data['product_description_ku'] = productDescriptionKu;
    data['supplier_id'] = supplierId;
    data['supplier_name'] = supplierName;
    data['is_used'] = isUsed;
    data['is_visible'] = isVisible;
    data['is_out_of_stock'] = isOutOfStock;
    data['product_price'] = productPrice;
    data['product_discount'] = productDiscount;
    data['product_final_price'] = productFinalPrice;
    data['product_points'] = productPoints;
    data['supplier_phone'] = supplierPhone;
    return data;
  }
}

class ProductAttachments {
  String? attachmentId;
  String? attachmentType;
  String? attachmentName;

  ProductAttachments(
      {this.attachmentId, this.attachmentType, this.attachmentName});

  ProductAttachments.fromJson(Map<String, dynamic>? json) {
    attachmentId = json?['attachment_id'];
    attachmentType = json?['attachment_type'];
    attachmentName = json?['attachment_name'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attachment_id'] = attachmentId;
    data['attachment_type'] = attachmentType;
    data['attachment_name'] = attachmentName;
    return data;
  }
}

class ProductColors {
  String? colorId;
  String? colorHex;

  ProductColors({this.colorId, this.colorHex});

  ProductColors.fromJson(Map<String, dynamic>? json) {
    colorId = json?['color_id'];
    colorHex = json?['color_hex'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['color_id'] = colorId;
    data['color_hex'] = colorHex;
    return data;
  }
}

class ProductSizes {
  String? sizeId;
  String? sizeName;

  ProductSizes({this.sizeId, this.sizeName});

  ProductSizes.fromJson(Map<String, dynamic>? json) {
    sizeId = json?['size_id'];
    sizeName = json?['size_name'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['size_id'] = sizeId;
    data['size_name'] = sizeName;
    return data;
  }
}

class SimilarProducts {
  String? productId;
  String? supplierId;
  String? supplierName;
  String? supplierLogo;
  String? productNameAr;
  String? productNameEn;
  String? productNameKu;
  String? productParagraphAr;
  String? productParagraphEn;
  String? productParagraphKu;
  String? productImg;
  String? productPrice;
  String? productDiscount;
  String? productFinalPrice;
  String? categoriesId;
  String? isUsed;
  String? createdAt;

  SimilarProducts(
      {this.productId,
      this.supplierId,
      this.supplierName,
      this.supplierLogo,
      this.productNameAr,
      this.productNameEn,
      this.productNameKu,
      this.productParagraphAr,
      this.productParagraphEn,
      this.productParagraphKu,
      this.productImg,
      this.productPrice,
      this.productDiscount,
      this.productFinalPrice,
      this.categoriesId,
      this.isUsed,
      this.createdAt});

  SimilarProducts.fromJson(Map<String, dynamic>? json) {
    productId = json?['product_id'];
    supplierId = json?['supplier_id'];
    supplierName = json?['supplier_name'];
    supplierLogo = json?['supplier_logo'];
    productNameAr = json?['product_name_ar'];
    productNameEn = json?['product_name_en'];
    productNameKu = json?['product_name_ku'];
    productParagraphAr = json?['product_paragraph_ar'];
    productParagraphEn = json?['product_paragraph_en'];
    productParagraphKu = json?['product_paragraph_ku'];
    productImg = json?['product_img'];
    productPrice = json?['product_price'];
    productDiscount = json?['product_discount'];
    productFinalPrice = json?['product_final_price'];
    categoriesId = json?['categories_id'];
    isUsed = json?['is_used'];
    createdAt = json?['created_at'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['supplier_id'] = supplierId;
    data['supplier_name'] = supplierName;
    data['supplier_logo'] = supplierLogo;
    data['product_name_ar'] = productNameAr;
    data['product_name_en'] = productNameEn;
    data['product_name_ku'] = productNameKu;
    data['product_paragraph_ar'] = productParagraphAr;
    data['product_paragraph_en'] = productParagraphEn;
    data['product_paragraph_ku'] = productParagraphKu;
    data['product_img'] = productImg;
    data['product_price'] = productPrice;
    data['product_discount'] = productDiscount;
    data['product_final_price'] = productFinalPrice;
    data['categories_id'] = categoriesId;
    data['is_used'] = isUsed;
    data['created_at'] = createdAt;
    return data;
  }
}
