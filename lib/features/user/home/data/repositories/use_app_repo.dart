// ignore_for_file: non_constant_identifier_names, file_names

import 'package:sheek_bazar/features/user/home/data/datasources/use_app_ds.dart';
import 'package:sheek_bazar/features/user/home/data/models/use_app_model.dart';

class UseAppRepo {
  final UseAppDS dataSource;

  UseAppRepo({required this.dataSource});

  Future<UseAppModel> getTutorialVideos(Map<String, String>? body) async {
    UseAppModel MyOrdersResponse = UseAppModel.fromJson(
      await dataSource.getUseApp(body),
    );
    return MyOrdersResponse;
  }
}
