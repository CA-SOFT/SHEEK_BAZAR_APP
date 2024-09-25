// ignore_for_file: non_constant_identifier_names, file_names

import 'package:sheek_bazar/features/user/shops/data/datasources/followers_ds.dart';
import 'package:sheek_bazar/features/user/shops/data/models/followers_model.dart';

class FollowersRepo {
  final GetFollowersDS dataSource;

  FollowersRepo({required this.dataSource});

  Future<FollowersModel> getFollowers(Map<String, String>? body) async {
    FollowersModel MyOrdersResponse = FollowersModel.fromJson(
      await dataSource.getFollowers(body),
    );
    return MyOrdersResponse;
  }
}
