// ignore_for_file: non_constant_identifier_names, file_names

import 'package:sheek_bazar/features/user/profile/data/datasources/get_user_info_ds.dart';
import 'package:sheek_bazar/features/user/profile/data/models/user_info_model.dart';

class GetUserInfoRepo {
  final GetUserInfoDS dataSource;

  GetUserInfoRepo({required this.dataSource});

  Future<UserIndoModel> getUserInfo(Map<String, String>? body) async {
    UserIndoModel MyOrdersResponse = UserIndoModel.fromJson(
      await dataSource.getUserInfo(body),
    );
    return MyOrdersResponse;
  }
}
