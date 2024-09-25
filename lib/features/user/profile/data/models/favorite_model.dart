class FavoriteModel {
  List<WishlistItems>? wishlistItems;

  FavoriteModel({this.wishlistItems});

  FavoriteModel.fromJson(Map<String, dynamic>? json) {
    if (json?['wishlist_items'] != null) {
      wishlistItems = <WishlistItems>[];
      json?['wishlist_items'].forEach((v) {
        wishlistItems!.add(WishlistItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (wishlistItems != null) {
      data['wishlist_items'] = wishlistItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WishlistItems {
  String? id;
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

  WishlistItems(
      {this.id,
      this.productId,
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
      this.productFinalPrice});

  WishlistItems.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
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
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
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
    return data;
  }
}
