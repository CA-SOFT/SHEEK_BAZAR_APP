import 'package:sheek_bazar/core/utils/app_logger.dart';

import '../../../../../core/utils/http_helper.dart';

class ShopsDs {
  final ApiBaseHelper apiHelper;

  ShopsDs({required this.apiHelper});

  Future<Map<String, dynamic>?> getShops(Map<String, String>? body) async {
    logger.i(body);
    Map<String, dynamic>? response =
        await apiHelper.post("/api/shops.php", body: body, headers: {});
    return response;
  }
}
