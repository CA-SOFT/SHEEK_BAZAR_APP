import 'package:sheek_bazar/core/utils/app_logger.dart';

import '../../../../../core/utils/http_helper.dart';

class PointsDS {
  final ApiBaseHelper apiHelper;

  PointsDS({required this.apiHelper});

  Future<Map<String, dynamic>?> getPoints(Map<String, String>? body) async {
    logger.i(body);
    Map<String, dynamic>? response =
        await apiHelper.post("/api/activities.php", body: body, headers: {});
    return response;
  }
}
