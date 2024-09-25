// ignore_for_file: file_names

import 'package:sheek_bazar/core/utils/app_logger.dart';

import '../../../../../core/utils/http_helper.dart';

class GetUserInfoDS {
  final ApiBaseHelper apiHelper;

  GetUserInfoDS({required this.apiHelper});

  Future<Map<String, dynamic>?> getUserInfo(Map<String, String>? body) async {
    logger.i(body);
    Map<String, dynamic>? response =
        await apiHelper.post("/api/profile.php", body: body, headers: {});
    return response;
  }
}
