// ignore_for_file: file_names

import 'package:sheek_bazar/core/utils/app_logger.dart';

import '../../../../../core/utils/http_helper.dart';

class GetFollowersDS {
  final ApiBaseHelper apiHelper;

  GetFollowersDS({required this.apiHelper});

  Future<Map<String, dynamic>?> getFollowers(Map<String, String>? body) async {
    logger.i(body);
    Map<String, dynamic>? response =
        await apiHelper.post("/api/supplier.php", body: body, headers: {});
    return response;
  }
}
