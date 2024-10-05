// ignore_for_file: file_names

import 'package:sheek_bazar/core/utils/app_logger.dart';

import '../../../../../core/utils/http_helper.dart';

class PayByPointsDS {
  final ApiBaseHelper apiHelper;

  PayByPointsDS({required this.apiHelper});

  Future<Map<String, dynamic>?> pay(Map<String, String>? body) async {
    logger.i(body);
    Map<String, dynamic>? response =
        await apiHelper.post("/api/orders.php", body: body, headers: {});
    return response;
  }
}
