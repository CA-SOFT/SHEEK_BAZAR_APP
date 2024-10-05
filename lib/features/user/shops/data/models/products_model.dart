class ProductsModel {
  List<Products>? products;
  List<SupplierInfo>? supplierInfo;
  List<SupplierAttachments>? supplierAttachments;

  ProductsModel({this.products, this.supplierInfo, this.supplierAttachments});

  ProductsModel.fromJson(Map<String, dynamic>? json) {
    if (json?['products'] != null) {
      products = <Products>[];
      json?['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    if (json?['supplier_info'] != null) {
      supplierInfo = <SupplierInfo>[];
      json?['supplier_info'].forEach((v) {
        supplierInfo!.add(SupplierInfo.fromJson(v));
      });
    }
    if (json?['supplier_attachments'] != null) {
      supplierAttachments = <SupplierAttachments>[];
      json?['supplier_attachments'].forEach((v) {
        supplierAttachments!.add(SupplierAttachments.fromJson(v));
      });
    }
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (supplierInfo != null) {
      data['supplier_info'] = supplierInfo!.map((v) => v.toJson()).toList();
    }
    if (supplierAttachments != null) {
      data['supplier_attachments'] =
          supplierAttachments!.map((v) => v.toJson()).toList();
    }
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
  String? productImg;
  String? productPrice;
  String? productDiscount;
  String? productFinalPrice;
  String? categoriesId;
  String? isUsed;
  String? createdAt;

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
      this.categoriesId,
      this.isUsed,
      this.createdAt});

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

class SupplierInfo {
  String? supplierId;
  String? supplierName;
  String? supplierPhone;
  String? supplierEmail;
  String? longtitude;
  String? latitude;
  String? supplierLogo;
  String? supplierDescription;
  String? totalFollowers;
  bool? isFollowing;

  SupplierInfo(
      {this.supplierId,
      this.supplierName,
      this.supplierPhone,
      this.supplierEmail,
      this.longtitude,
      this.latitude,
      this.supplierLogo,
      this.supplierDescription,
      this.totalFollowers,
      this.isFollowing});

  SupplierInfo.fromJson(Map<String, dynamic>? json) {
    supplierId = json?['supplier_id'];
    supplierName = json?['supplier_name'];
    supplierPhone = json?['supplier_phone'];
    supplierEmail = json?['supplier_email'];
    longtitude = json?['longtitude'];
    latitude = json?['latitude'];
    supplierLogo = json?['supplier_logo'];
    supplierDescription = json?['supplier_description'];
    totalFollowers = json?['total_followers'];
    isFollowing = json?['is_following'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['supplier_id'] = supplierId;
    data['supplier_name'] = supplierName;
    data['supplier_phone'] = supplierPhone;
    data['supplier_email'] = supplierEmail;
    data['longtitude'] = longtitude;
    data['latitude'] = latitude;
    data['supplier_logo'] = supplierLogo;
    data['supplier_description'] = supplierDescription;
    data['total_followers'] = totalFollowers;
    data['is_following'] = isFollowing;
    return data;
  }
}

class SupplierAttachments {
  String? attachmentId;
  String? attachmentName;

  SupplierAttachments({this.attachmentId, this.attachmentName});

  SupplierAttachments.fromJson(Map<String, dynamic>? json) {
    attachmentId = json?['attachment_id'];
    attachmentName = json?['attachment_name'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attachment_id'] = attachmentId;
    data['attachment_name'] = attachmentName;
    return data;
  }
}
