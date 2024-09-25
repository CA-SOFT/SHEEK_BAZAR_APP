// ignore_for_file: non_constant_identifier_names, file_names

import 'package:sheek_bazar/features/suppliers/supplier_order/data/datasources/get_order_details_ds.dart';
import 'package:sheek_bazar/features/user/profile/data/models/orderDetails_model.dart';

class GetSupplierOrderDetailsRepo {
  final SupllierOrderDeatilsDS dataSource;

  GetSupplierOrderDetailsRepo({required this.dataSource});

  Future<OrderDetailsModel> getOrders(Map<String, String>? body) async {
    OrderDetailsModel MyOrdersResponse = OrderDetailsModel.fromJson(
      await dataSource.getOrderDetails(body),
    );
    return MyOrdersResponse;
  }
}
