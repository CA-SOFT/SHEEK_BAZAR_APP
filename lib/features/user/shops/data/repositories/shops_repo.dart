// ignore_for_file: non_constant_identifier_names, file_names

import 'package:sheek_bazar/features/user/shops/data/datasources/shops_ds.dart';

import '../models/shops_model.dart';

class ShopsRepo {
  final ShopsDs dataSource;

  ShopsRepo({required this.dataSource});

  Future<ShopModel> getShops(Map<String, String>? body) async {
    ShopModel MyOrdersResponse = ShopModel.fromJson(
      await dataSource.getShops(body),
    );
    return MyOrdersResponse;
  }
}
