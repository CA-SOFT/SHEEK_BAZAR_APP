// ignore_for_file: prefer_typing_uninitialized_variables

class CartModel {
  List<CartItems>? cartItems;

  CartModel({this.cartItems});

  CartModel.fromJson(Map<String, dynamic>? json) {
    if (json?['cart_items'] != null) {
      cartItems = <CartItems>[];
      json?['cart_items'].forEach((v) {
        cartItems!.add(CartItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cartItems != null) {
      data['cart_items'] = cartItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartItems {
  String? id;
  String? productId;
  String? productNameAr;
  String? productNameEn;
  String? productNameKu;
  String? productImg;
  String? productPrice;
  String? productDiscount;
  String? productFinalPrice;
  String? productQuantity;
  String? productSize;
  String? productColor;
  String? productPoints;
  var totalPoints;
  int? productGrandTotal;

  CartItems(
      {this.id,
      this.productId,
      this.productNameAr,
      this.productNameEn,
      this.productNameKu,
      this.productImg,
      this.productPrice,
      this.productDiscount,
      this.productFinalPrice,
      this.productQuantity,
      this.productSize,
      this.productPoints,
      this.totalPoints,
      this.productColor,
      this.productGrandTotal});

  CartItems.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    productId = json?['product_id'];
    productNameAr = json?['product_name_ar'];
    productNameEn = json?['product_name_en'];
    productNameKu = json?['product_name_ku'];
    productImg = json?['product_img'];
    productPrice = json?['product_price'];
    productPoints = json?['product_points'];
    productDiscount = json?['product_discount'];
    productFinalPrice = json?['product_final_price'];
    productQuantity = json?['product_quantity'];
    productSize = json?['product_size'];
    productColor = json?['product_color'];
    productGrandTotal = json?['product_grand_total'];
    totalPoints = json?['total_points'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['product_name_ar'] = productNameAr;
    data['product_name_en'] = productNameEn;
    data['product_name_ku'] = productNameKu;
    data['product_img'] = productImg;
    data['product_price'] = productPrice;
    data['product_discount'] = productDiscount;
    data['product_final_price'] = productFinalPrice;
    data['product_quantity'] = productQuantity;
    data['product_size'] = productSize;
    data['product_color'] = productColor;
    data['product_grand_total'] = productGrandTotal;
    data['product_points'] = productPoints;
    data['total_points'] = totalPoints;
    return data;
  }
}
