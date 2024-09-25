import 'package:sheek_bazar/core/utils/app_logger.dart';

import '../../../../../core/utils/http_helper.dart';

class CartDs {
  final ApiBaseHelper apiHelper;

  CartDs({required this.apiHelper});

  Future<Map<String, dynamic>?> fetchCart(Map<String, String>? body) async {
    logger.i(body);
    Map<String, dynamic>? response =
        await apiHelper.post("/api/cart.php", body: body, headers: {});
    return response;
  }
}
