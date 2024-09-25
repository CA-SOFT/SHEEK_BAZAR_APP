// ignore_for_file: non_constant_identifier_names, file_names

import '../datasources/home_ds.dart';
import '../models/home_model.dart';

class HomeRepo {
  final HomeDs dataSource;

  HomeRepo({required this.dataSource});

  Future<HomeModel> getProducts(Map<String, String>? body) async {
    HomeModel MyOrdersResponse = HomeModel.fromJson(
      await dataSource.getProducts(body),
    );
    return MyOrdersResponse;
  }
}
