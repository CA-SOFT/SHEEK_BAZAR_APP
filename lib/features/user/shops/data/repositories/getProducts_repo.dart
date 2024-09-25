// ignore_for_file: non_constant_identifier_names, file_names

import 'package:sheek_bazar/features/user/shops/data/models/products_model.dart';

import '../datasources/getProducts_ds.dart';

class GetProductsRepo {
  final GetProductsDS dataSource;

  GetProductsRepo({required this.dataSource});

  Future<ProductsModel> getProducts(Map<String, String>? body) async {
    ProductsModel MyOrdersResponse = ProductsModel.fromJson(
      await dataSource.getProducts(body),
    );
    return MyOrdersResponse;
  }
}
