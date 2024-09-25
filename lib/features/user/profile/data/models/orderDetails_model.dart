// ignore_for_file: file_names

class OrderDetailsModel {
  List<OrderItems>? orderItems;

  OrderDetailsModel({this.orderItems});

  OrderDetailsModel.fromJson(Map<String, dynamic>? json) {
    if (json?['order_items'] != null) {
      orderItems = <OrderItems>[];
      json?['order_items'].forEach((v) {
        orderItems!.add(OrderItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orderItems != null) {
      data['order_items'] = orderItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderItems {
  String? itemId;
  String? productId;
  String? productNameAr;
  String? productNameEn;
  String? productNameKu;
  String? productImg;
  String? productColor;
  String? productSize;
  String? productQuantity;
  String? productPrice;
  String? productTotalBeforeDiscount;
  String? productDiscountPercentage;
  String? productDiscountValue;
  String? productTotalAfterDiscount;

  OrderItems(
      {this.itemId,
      this.productId,
      this.productNameAr,
      this.productNameEn,
      this.productNameKu,
      this.productImg,
      this.productColor,
      this.productSize,
      this.productQuantity,
      this.productPrice,
      this.productTotalBeforeDiscount,
      this.productDiscountPercentage,
      this.productDiscountValue,
      this.productTotalAfterDiscount});

  OrderItems.fromJson(Map<String, dynamic>? json) {
    itemId = json?['item_id'];
    productId = json?['product_id'];
    productNameAr = json?['product_name_ar'];
    productNameEn = json?['product_name_en'];
    productNameKu = json?['product_name_ku'];
    productImg = json?['product_img'];
    productColor = json?['product_color'];
    productSize = json?['product_size'];
    productQuantity = json?['product_quantity'];
    productPrice = json?['product_price'];
    productTotalBeforeDiscount = json?['product_total_before_discount'];
    productDiscountPercentage = json?['product_discount_percentage'];
    productDiscountValue = json?['product_discount_value'];
    productTotalAfterDiscount = json?['product_total_after_discount'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_id'] = itemId;
    data['product_id'] = productId;
    data['product_name_ar'] = productNameAr;
    data['product_name_en'] = productNameEn;
    data['product_name_ku'] = productNameKu;
    data['product_img'] = productImg;
    data['product_color'] = productColor;
    data['product_size'] = productSize;
    data['product_quantity'] = productQuantity;
    data['product_price'] = productPrice;
    data['product_total_before_discount'] = productTotalBeforeDiscount;
    data['product_discount_percentage'] = productDiscountPercentage;
    data['product_discount_value'] = productDiscountValue;
    data['product_total_after_discount'] = productTotalAfterDiscount;
    return data;
  }
}
