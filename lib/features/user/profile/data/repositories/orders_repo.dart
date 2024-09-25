// ignore_for_file: non_constant_identifier_names, file_names

import '../datasources/orders_ds.dart';
import '../models/orders_model.dart';

class OrdersRepo {
  final OrdersDS dataSource;

  OrdersRepo({required this.dataSource});

  Future<OrdersModel> getOrders(Map<String, String>? body) async {
    OrdersModel MyOrdersResponse = OrdersModel.fromJson(
      await dataSource.getOrders(body),
    );
    return MyOrdersResponse;
  }
}
