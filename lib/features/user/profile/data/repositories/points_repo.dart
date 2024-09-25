// ignore_for_file: non_constant_identifier_names, file_names

import 'package:sheek_bazar/features/user/profile/data/datasources/point_ds.dart';
import 'package:sheek_bazar/features/user/profile/data/models/points_model.dart';

class PointsRepo {
  final PointsDS dataSource;

  PointsRepo({required this.dataSource});

  Future<PointsModel> getpoints(Map<String, String>? body) async {
    PointsModel MyOrdersResponse = PointsModel.fromJson(
      await dataSource.getPoints(body),
    );
    return MyOrdersResponse;
  }
}
