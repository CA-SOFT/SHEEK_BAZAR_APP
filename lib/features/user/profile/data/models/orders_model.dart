// ignore_for_file: prefer_typing_uninitialized_variables

class OrdersModel {
  List<Orders>? orders;
  var myPoints;

  OrdersModel({this.orders, this.myPoints});

  OrdersModel.fromJson(Map<String, dynamic>? json) {
    if (json?['orders'] != null) {
      orders = <Orders>[];
      json?['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
    myPoints = json?['my_points'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    data['my_points'] = myPoints;
    return data;
  }
}

class Orders {
  var orderId;
  var invoiceNumber;
  var orderStatus;
  var grandTotal;
  var isPaid;
  var createdAt;

  Orders(
      {this.orderId,
      this.invoiceNumber,
      this.orderStatus,
      this.grandTotal,
      this.isPaid,
      this.createdAt});

  Orders.fromJson(Map<String, dynamic>? json) {
    orderId = json?['order_id'];
    invoiceNumber = json?['invoice_number'];
    orderStatus = json?['order_status'];
    grandTotal = json?['grand_total'];
    isPaid = json?['is_paid'];
    createdAt = json?['created_at'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['invoice_number'] = invoiceNumber;
    data['order_status'] = orderStatus;
    data['grand_total'] = grandTotal;
    data['is_paid'] = isPaid;
    data['created_at'] = createdAt;
    return data;
  }
}
