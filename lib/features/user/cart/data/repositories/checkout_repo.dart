// ignore_for_file: non_constant_identifier_names, file_names

import 'package:sheek_bazar/features/user/cart/data/models/check_out_model.dart';

import '../datasources/checkout_ds.dart';

class CheckoutRepo {
  final CheckOutDS dataSource;

  CheckoutRepo({required this.dataSource});

  Future<CheckOutModel> checkout(Map<String, String>? body) async {
    CheckOutModel MyOrdersResponse = CheckOutModel.fromJson(
      await dataSource.checkout(body),
    );
    return MyOrdersResponse;
  }
}
