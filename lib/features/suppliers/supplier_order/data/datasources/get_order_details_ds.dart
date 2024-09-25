import 'package:sheek_bazar/core/utils/app_logger.dart';

import '../../../../../core/utils/http_helper.dart';

class SupllierOrderDeatilsDS {
  final ApiBaseHelper apiHelper;

  SupllierOrderDeatilsDS({required this.apiHelper});

  Future<Map<String, dynamic>?> getOrderDetails(
      Map<String, String>? body) async {
    logger.i(body);
    Map<String, dynamic>? response =
        await apiHelper.post("/api/supplier.php", body: body, headers: {});
    return response;
  }
}
