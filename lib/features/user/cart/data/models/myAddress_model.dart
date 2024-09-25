// ignore_for_file: file_names
class MyAddressModel {
  List<CustomerAddresses>? customerAddresses;

  MyAddressModel({this.customerAddresses});

  MyAddressModel.fromJson(Map<String, dynamic>? json) {
    if (json?['customer_addresses'] != null) {
      customerAddresses = <CustomerAddresses>[];
      json?['customer_addresses'].forEach((v) {
        customerAddresses!.add(CustomerAddresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customerAddresses != null) {
      data['customer_addresses'] =
          customerAddresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerAddresses {
  String? provinceId;
  String? provinceNameAr;
  String? provinceNameEn;
  String? provinceNameKu;
  String? deliveryCost;
  String? addressId;
  String? customerId;
  String? addressTitle;
  String? addressLongitude;
  String? addressLatitude;
  String? addressNotes;
  String? addressPhone;

  CustomerAddresses(
      {this.provinceId,
      this.provinceNameAr,
      this.provinceNameEn,
      this.provinceNameKu,
      this.deliveryCost,
      this.addressId,
      this.customerId,
      this.addressTitle,
      this.addressLongitude,
      this.addressLatitude,
      this.addressNotes,
      this.addressPhone});

  CustomerAddresses.fromJson(Map<String, dynamic>? json) {
    provinceId = json?['province_id'];
    provinceNameAr = json?['province_name_ar'];
    provinceNameEn = json?['province_name_en'];
    provinceNameKu = json?['province_name_ku'];
    deliveryCost = json?['delivery_cost'];
    addressId = json?['address_id'];
    customerId = json?['customer_id'];
    addressTitle = json?['address_title'];
    addressLongitude = json?['address_longitude'];
    addressLatitude = json?['address_latitude'];
    addressNotes = json?['address_notes'];
    addressPhone = json?['address_phone'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['province_id'] = provinceId;
    data['province_name_ar'] = provinceNameAr;
    data['province_name_en'] = provinceNameEn;
    data['province_name_ku'] = provinceNameKu;
    data['delivery_cost'] = deliveryCost;
    data['address_id'] = addressId;
    data['customer_id'] = customerId;
    data['address_title'] = addressTitle;
    data['address_longitude'] = addressLongitude;
    data['address_latitude'] = addressLatitude;
    data['address_notes'] = addressNotes;
    data['address_phone'] = addressPhone;
    return data;
  }
}
