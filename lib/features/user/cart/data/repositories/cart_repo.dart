// ignore_for_file: non_constant_identifier_names, file_names

import '../datasources/cart_ds.dart';
import '../models/cart_model.dart';
import '../models/operations_model.dart';

class CartRepo {
  final CartDs dataSource;

  CartRepo({required this.dataSource});

  Future<CartModel> getMyCart(Map<String, String>? body) async {
    CartModel MyOrdersResponse = CartModel.fromJson(
      await dataSource.fetchCart(body),
    );
    return MyOrdersResponse;
  }

  Future<OperationsModel> updateItemCart(Map<String, String>? body) async {
    OperationsModel MyOrdersResponse = OperationsModel.fromJson(
      await dataSource.fetchCart(body),
    );
    return MyOrdersResponse;
  }
}
