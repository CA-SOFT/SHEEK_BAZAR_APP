import 'package:sheek_bazar/core/utils/app_logger.dart';

import '../../../../../core/utils/http_helper.dart';

class SupllierOrdersDS {
  final ApiBaseHelper apiHelper;

  SupllierOrdersDS({required this.apiHelper});

  Future<Map<String, dynamic>?> getOrders(Map<String, String>? body) async {
    logger.i(body);
    Map<String, dynamic>? response =
        await apiHelper.post("/api/supplier.php", body: body, headers: {});
    return response;
  }
}
