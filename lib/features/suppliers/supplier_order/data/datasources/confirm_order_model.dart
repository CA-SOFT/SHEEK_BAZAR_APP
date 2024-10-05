import 'package:sheek_bazar/core/utils/app_logger.dart';

import '../../../../../core/utils/http_helper.dart';

class ConfirmOrderDs {
  final ApiBaseHelper apiHelper;

  ConfirmOrderDs({required this.apiHelper});

  Future<Map<String, dynamic>?> confirmOrder(Map<String, String>? body) async {
    logger.i(body);
    Map<String, dynamic>? response =
        await apiHelper.post("/api/supplier.php", body: body, headers: {});
    return response;
  }
}
