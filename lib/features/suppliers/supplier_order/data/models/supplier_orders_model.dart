class SupplierOrders {
  bool? status;
  String? message;
  List<OneOrder>? data;

  SupplierOrders({this.status, this.message, this.data});

  SupplierOrders.fromJson(Map<String, dynamic>? json) {
    status = json?['status'];
    message = json?['message'];
    if (json?['data'] != null) {
      data = <OneOrder>[];
      json?['data'].forEach((v) {
        data!.add(OneOrder.fromJson(v));
      });
    }
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OneOrder {
  String? orderId;
  String? invoiceNumber;
  String? invoiceType;
  String? customerId;
  String? customerName;
  String? createdAt;
  String? orderStatus;
  String? finalAmount;

  OneOrder(
      {this.orderId,
      this.invoiceNumber,
      this.invoiceType,
      this.customerId,
      this.customerName,
      this.createdAt,
      this.orderStatus,
      this.finalAmount});

  OneOrder.fromJson(Map<String, dynamic>? json) {
    orderId = json?['order_id'];
    invoiceNumber = json?['invoice_number'];
    invoiceType = json?['invoice_type'];
    customerId = json?['customer_id'];
    customerName = json?['customer_name'];
    createdAt = json?['created_at'];
    orderStatus = json?['order_status'];
    finalAmount = json?['final_amount'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['invoice_number'] = invoiceNumber;
    data['invoice_type'] = invoiceType;
    data['customer_id'] = customerId;
    data['customer_name'] = customerName;
    data['created_at'] = createdAt;
    data['order_status'] = orderStatus;
    data['final_amount'] = finalAmount;
    return data;
  }
}
