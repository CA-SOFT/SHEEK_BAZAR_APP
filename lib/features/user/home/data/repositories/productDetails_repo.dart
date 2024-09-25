// ignore_for_file: non_constant_identifier_names, file_names

import '../datasources/productDetails_ds.dart';
import '../models/productDetails_model.dart';

class ProductDetailsRepo {
  final ProductDetailsDs dataSource;

  ProductDetailsRepo({required this.dataSource});

  Future<ProductDetailsModel> getProductDetails(
      Map<String, String>? body) async {
    ProductDetailsModel MyOrdersResponse = ProductDetailsModel.fromJson(
      await dataSource.getProductDetails(body),
    );
    return MyOrdersResponse;
  }
}
