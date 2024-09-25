// ignore_for_file: prefer_typing_uninitialized_variables

class PointsModel {
  bool? status;
  String? message;
  Data? data;
  String? newDate;

  PointsModel({this.status, this.message, this.data, this.newDate});

  PointsModel.fromJson(Map<String, dynamic>? json) {
    status = json?['status'];
    message = json?['message'];
    data = json?['data'] != null ? Data.fromJson(json?['data']) : null;
    newDate = json?['new_date'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['new_date'] = newDate;
    return data;
  }
}

class Data {
  Customer? customer;
  List<Activities>? activities;

  Data({this.customer, this.activities});

  Data.fromJson(Map<String, dynamic>? json) {
    customer =
        json?['customer'] != null ? Customer.fromJson(json?['customer']) : null;
    if (json?['activities'] != null) {
      activities = <Activities>[];
      json?['activities'].forEach((v) {
        activities!.add(Activities.fromJson(v));
      });
    }
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (activities != null) {
      data['activities'] = activities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customer {
  String? customerId;
  String? customerName;
  String? customerPhone;
  String? customerPassword;
  String? isActive;
  String? points;
  String? referralCode;
  String? createdAt;
  var updatedAt;

  Customer(
      {this.customerId,
      this.customerName,
      this.customerPhone,
      this.customerPassword,
      this.isActive,
      this.points,
      this.referralCode,
      this.createdAt,
      this.updatedAt});

  Customer.fromJson(Map<String, dynamic>? json) {
    customerId = json?['customer_id'];
    customerName = json?['customer_name'];
    customerPhone = json?['customer_phone'];
    customerPassword = json?['customer_password'];
    isActive = json?['is_active'];
    points = json?['points'];
    referralCode = json?['referral_code'];
    createdAt = json?['created_at'];
    updatedAt = json?['updated_at'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_id'] = customerId;
    data['customer_name'] = customerName;
    data['customer_phone'] = customerPhone;
    data['customer_password'] = customerPassword;
    data['is_active'] = isActive;
    data['points'] = points;
    data['referral_code'] = referralCode;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Activities {
  String? id;
  String? type;
  String? points;
  String? customerId;
  String? newDate;
  String? createdAt;

  Activities(
      {this.id,
      this.type,
      this.points,
      this.customerId,
      this.newDate,
      this.createdAt});

  Activities.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    type = json?['type'];
    points = json?['points'];
    customerId = json?['customer_id'];
    newDate = json?['new_date'];
    createdAt = json?['created_at'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['points'] = points;
    data['customer_id'] = customerId;
    data['new_date'] = newDate;
    data['created_at'] = createdAt;
    return data;
  }
}
