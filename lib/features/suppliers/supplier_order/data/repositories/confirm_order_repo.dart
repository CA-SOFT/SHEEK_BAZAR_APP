// ignore_for_file: non_constant_identifier_names, file_names

import 'package:sheek_bazar/features/suppliers/supplier_order/data/datasources/confirm_order_model.dart';
import 'package:sheek_bazar/features/suppliers/supplier_order/data/models/confirm_order_model.dart';

class ConfirmRepo {
  final ConfirmOrderDs dataSource;

  ConfirmRepo({required this.dataSource});

  Future<ConfirmOrderModel> sendConfirm(Map<String, String>? body) async {
    ConfirmOrderModel MyOrdersResponse = ConfirmOrderModel.fromJson(
      await dataSource.confirmOrder(body),
    );
    return MyOrdersResponse;
  }
}
