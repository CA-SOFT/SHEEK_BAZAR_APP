// ignore_for_file: non_constant_identifier_names, file_names

import 'package:sheek_bazar/features/suppliers/supplier_order/data/datasources/get_orders_ds.dart';
import 'package:sheek_bazar/features/suppliers/supplier_order/data/models/supplier_orders_model.dart';

class GetSupplierOrdersRepo {
  final SupllierOrdersDS dataSource;

  GetSupplierOrdersRepo({required this.dataSource});

  Future<SupplierOrders> getOrders(Map<String, String>? body) async {
    SupplierOrders MyOrdersResponse = SupplierOrders.fromJson(
      await dataSource.getOrders(body),
    );
    return MyOrdersResponse;
  }
}
