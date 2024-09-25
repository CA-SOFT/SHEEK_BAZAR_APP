// ignore_for_file: non_constant_identifier_names, file_names

import 'package:sheek_bazar/features/user/shops/data/datasources/follow_ds.dart';
import 'package:sheek_bazar/features/user/shops/data/models/follow_model.dart';

class FollowRepo {
  final FollowDs dataSource;

  FollowRepo({required this.dataSource});

  Future<FollowModel> followSupplier(Map<String, String>? body) async {
    FollowModel MyOrdersResponse = FollowModel.fromJson(
      await dataSource.followDs(body),
    );
    return MyOrdersResponse;
  }
}
