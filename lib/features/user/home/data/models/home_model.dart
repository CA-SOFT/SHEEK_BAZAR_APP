class HomeModel {
  List<Banners>? banners;
  List<Categories>? categories;
  List<Products>? products;

  HomeModel({this.banners, this.categories, this.products});

  HomeModel.fromJson(Map<String, dynamic>? json) {
    if (json?['banners'] != null) {
      banners = <Banners>[];
      json?['banners'].forEach((v) {
        banners!.add(Banners.fromJson(v));
      });
    }
    if (json?['categories'] != null) {
      categories = <Categories>[];
      json?['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json?['products'] != null) {
      products = <Products>[];
      json?['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (banners != null) {
      data['banners'] = banners!.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  String? bannerId;
  String? bannerName;
  String? bannerImg;
  String? targetType;
  String? supplierId;
  String? productId;

  Banners(
      {this.bannerId,
      this.bannerName,
      this.bannerImg,
      this.targetType,
      this.supplierId,
      this.productId});

  Banners.fromJson(Map<String, dynamic>? json) {
    bannerId = json?['banner_id'];
    bannerName = json?['banner_name'];
    bannerImg = json?['banner_img'];
    targetType = json?['target_type'];
    supplierId = json?['supplier_id'];
    productId = json?['product_id'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['banner_id'] = bannerId;
    data['banner_name'] = bannerName;
    data['banner_img'] = bannerImg;
    data['target_type'] = targetType;
    data['supplier_id'] = supplierId;
    data['product_id'] = productId;
    return data;
  }
}

class Categories {
  String? categoryId;
  String? categoryNameAr;
  String? categoryNameEn;
  String? categoryNameKu;
  String? categoryImg;

  Categories(
      {this.categoryId,
      this.categoryNameAr,
      this.categoryNameEn,
      this.categoryNameKu,
      this.categoryImg});

  Categories.fromJson(Map<String, dynamic>? json) {
    categoryId = json?['category_id'];
    categoryNameAr = json?['category_name_ar'];
    categoryNameEn = json?['category_name_en'];
    categoryNameKu = json?['category_name_ku'];
    categoryImg = json?['category_img'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['category_name_ar'] = categoryNameAr;
    data['category_name_en'] = categoryNameEn;
    data['category_name_ku'] = categoryNameKu;
    data['category_img'] = categoryImg;
    return data;
  }
}

class Products {
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
  List<ProductImg>? productImg;
  String? productPrice;
  String? productDiscount;
  String? productFinalPrice;
  String? isUsed;
  String? productPoints;

  Products(
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
      this.isUsed,
      this.productPoints});

  Products.fromJson(Map<String, dynamic>? json) {
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
    if (json?['product_img'] != null) {
      productImg = <ProductImg>[];
      json?['product_img'].forEach((v) {
        productImg!.add(ProductImg.fromJson(v));
      });
    }
    productPrice = json?['product_price'];
    productDiscount = json?['product_discount'];
    productFinalPrice = json?['product_final_price'];
    isUsed = json?['is_used'];
    productPoints = json?['product_points'];
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
    if (productImg != null) {
      data['product_img'] = productImg!.map((v) => v.toJson()).toList();
    }
    data['product_price'] = productPrice;
    data['product_discount'] = productDiscount;
    data['product_final_price'] = productFinalPrice;
    data['is_used'] = isUsed;
    data['product_points'] = productPoints;
    return data;
  }
}

class ProductImg {
  String? attachmentId;
  String? attachmentType;
  String? attachmentName;

  ProductImg({this.attachmentId, this.attachmentType, this.attachmentName});

  ProductImg.fromJson(Map<String, dynamic>? json) {
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
