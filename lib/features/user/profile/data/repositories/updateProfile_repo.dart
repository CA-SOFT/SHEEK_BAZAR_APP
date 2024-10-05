// ignore_for_file: non_constant_identifier_names, file_names

import 'package:sheek_bazar/features/user/cart/data/models/operations_model.dart';
import 'package:sheek_bazar/features/user/profile/data/datasources/updateProfile_ds.dart';

class UpdateProfileRepo {
  final UpdateProfileDS dataSource;

  UpdateProfileRepo({required this.dataSource});

  Future<OperationsModel> updateProfile(Map<String, String>? body) async {
    OperationsModel MyOrdersResponse = OperationsModel.fromJson(
      await dataSource.updateProfile(body),
    );
    return MyOrdersResponse;
  }
}
