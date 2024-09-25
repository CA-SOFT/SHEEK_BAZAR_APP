// ignore_for_file: non_constant_identifier_names, file_names

import '../datasources/orderDetails_ds.dart';
import '../models/orderDetails_model.dart';

class OrderDetailsRepo {
  final OrderDetailsDS dataSource;

  OrderDetailsRepo({required this.dataSource});

  Future<OrderDetailsModel> getOrderDetails(Map<String, String>? body) async {
    OrderDetailsModel MyOrdersResponse = OrderDetailsModel.fromJson(
      await dataSource.getOrderDetails(body),
    );
    return MyOrdersResponse;
  }
}
