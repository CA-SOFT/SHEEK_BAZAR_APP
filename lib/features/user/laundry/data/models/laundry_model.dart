class LundryModel {
  List<Services>? services;
  List<ClothesType>? clothesType;
  List<LaundryItems>? laundryItems;

  LundryModel({this.services, this.clothesType, this.laundryItems});

  LundryModel.fromJson(Map<String, dynamic>? json) {
    if (json?['services'] != null) {
      services = <Services>[];
      json?['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
    if (json?['clothes_type'] != null) {
      clothesType = <ClothesType>[];
      json?['clothes_type'].forEach((v) {
        clothesType!.add(ClothesType.fromJson(v));
      });
    }
    if (json?['laundry_items'] != null) {
      laundryItems = <LaundryItems>[];
      json?['laundry_items'].forEach((v) {
        laundryItems!.add(LaundryItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    if (clothesType != null) {
      data['clothes_type'] = clothesType!.map((v) => v.toJson()).toList();
    }
    if (laundryItems != null) {
      data['laundry_items'] = laundryItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  String? serviceId;
  String? serviceNameAr;
  String? serviceNameEn;
  String? serviceNameKu;

  Services(
      {this.serviceId,
      this.serviceNameAr,
      this.serviceNameEn,
      this.serviceNameKu});

  Services.fromJson(Map<String, dynamic>? json) {
    serviceId = json?['service_id'];
    serviceNameAr = json?['service_name_ar'];
    serviceNameEn = json?['service_name_en'];
    serviceNameKu = json?['service_name_ku'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_id'] = serviceId;
    data['service_name_ar'] = serviceNameAr;
    data['service_name_en'] = serviceNameEn;
    data['service_name_ku'] = serviceNameKu;
    return data;
  }
}

class ClothesType {
  String? categoryId;
  String? categoryNameAr;
  String? categoryNameEn;
  String? categoryNameKu;
  String? count = "0";

  ClothesType(
      {this.categoryId,
      this.categoryNameAr,
      this.categoryNameEn,
      this.categoryNameKu,
      this.count});

  ClothesType.fromJson(Map<String, dynamic>? json) {
    categoryId = json?['category_id'];
    categoryNameAr = json?['category_name_ar'];
    categoryNameEn = json?['category_name_en'];
    categoryNameKu = json?['category_name_ku'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['category_name_ar'] = categoryNameAr;
    data['category_name_en'] = categoryNameEn;
    data['category_name_ku'] = categoryNameKu;
    return data;
  }
}

class LaundryItems {
  String? itemId;
  String? categoryId;
  String? serviceId;
  String? itemPrice;

  LaundryItems({this.itemId, this.categoryId, this.serviceId, this.itemPrice});

  LaundryItems.fromJson(Map<String, dynamic>? json) {
    itemId = json?['item_id'];
    categoryId = json?['category_id'];
    serviceId = json?['service_id'];
    itemPrice = json?['item_price'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_id'] = itemId;
    data['category_id'] = categoryId;
    data['service_id'] = serviceId;
    data['item_price'] = itemPrice;
    return data;
  }
}
