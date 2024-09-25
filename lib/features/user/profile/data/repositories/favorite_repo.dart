// ignore_for_file: non_constant_identifier_names, file_names

import 'package:sheek_bazar/features/user/profile/data/models/favorite_model.dart';

import '../../../cart/data/models/operations_model.dart';
import '../datasources/favorite_ds.dart';

class FavoriteRepo {
  final FavoriteDS dataSource;

  FavoriteRepo({required this.dataSource});

  Future<FavoriteModel> getMyFavorite(Map<String, String>? body) async {
    FavoriteModel MyOrdersResponse = FavoriteModel.fromJson(
      await dataSource.getMyFavorite(body),
    );
    return MyOrdersResponse;
  }

  Future<OperationsModel> insertOrDeleteToMyFavorite(
      Map<String, String>? body) async {
    OperationsModel MyOrdersResponse = OperationsModel.fromJson(
      await dataSource.getMyFavorite(body),
    );
    return MyOrdersResponse;
  }
}
