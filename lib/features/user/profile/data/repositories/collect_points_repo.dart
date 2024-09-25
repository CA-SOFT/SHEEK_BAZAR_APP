// ignore_for_file: non_constant_identifier_names, file_names

import 'package:sheek_bazar/features/user/profile/data/datasources/collect_points_ds.dart';
import 'package:sheek_bazar/features/user/profile/data/models/collect_points_model.dart';

class CollectPointsRepo {
  final CollectPointsDS dataSource;

  CollectPointsRepo({required this.dataSource});

  Future<CollectPointsModel> collectPoints(Map<String, String>? body) async {
    CollectPointsModel MyOrdersResponse = CollectPointsModel.fromJson(
      await dataSource.collectPoints(body),
    );
    return MyOrdersResponse;
  }
}
