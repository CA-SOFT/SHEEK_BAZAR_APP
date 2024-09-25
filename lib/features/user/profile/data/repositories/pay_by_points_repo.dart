// ignore_for_file: non_constant_identifier_names, file_names

import 'package:sheek_bazar/features/user/profile/data/datasources/pay_by_points_ds.dart';
import 'package:sheek_bazar/features/user/profile/data/models/pay_by_points_model.dart';

class PayByPointsRepo {
  final PayByPointsDS dataSource;

  PayByPointsRepo({required this.dataSource});

  Future<BayByPointsModel> pay(Map<String, String>? body) async {
    BayByPointsModel MyOrdersResponse = BayByPointsModel.fromJson(
      await dataSource.pay(body),
    );
    return MyOrdersResponse;
  }
}
