import 'package:sheek_bazar/core/utils/app_logger.dart';

import '../../../../../core/utils/http_helper.dart';

class OrdersDS {
  final ApiBaseHelper apiHelper;

  OrdersDS({required this.apiHelper});

  Future<Map<String, dynamic>?> getOrders(Map<String, String>? body) async {
    logger.i(body);
    Map<String, dynamic>? response =
        await apiHelper.post("/api/orders.php", body: body, headers: {});
    return response;
  }
}
