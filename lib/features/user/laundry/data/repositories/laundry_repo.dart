// ignore_for_file: non_constant_identifier_names, file_names

import '../datasources/laundry_ds.dart';
import '../models/laundry_model.dart';

class LundryRepo {
  final LaundryDS dataSource;

  LundryRepo({required this.dataSource});

  Future<LundryModel> getLundray(Map<String, String>? body) async {
    LundryModel lundry = LundryModel.fromJson(
      await dataSource.getLundry(body),
    );
    return lundry;
  }
}
