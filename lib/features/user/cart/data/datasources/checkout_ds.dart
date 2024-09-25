import 'package:sheek_bazar/core/utils/app_logger.dart';

import '../../../../../core/utils/http_helper.dart';

class CheckOutDS {
  final ApiBaseHelper apiHelper;

  CheckOutDS({required this.apiHelper});

  Future<Map<String, dynamic>?> checkout(Map<String, String>? body) async {
    logger.i(body);
    Map<String, dynamic>? response =
        await apiHelper.post("/api/checkout.php", body: body, headers: {});
    return response;
  }
}
