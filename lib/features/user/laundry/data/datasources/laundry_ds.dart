import 'package:sheek_bazar/core/utils/app_logger.dart';

import '../../../../../core/utils/http_helper.dart';

class LaundryDS {
  final ApiBaseHelper apiHelper;

  LaundryDS({required this.apiHelper});

  Future<Map<String, dynamic>?> getLundry(Map<String, String>? body) async {
    logger.i(body);
    Map<String, dynamic>? response =
        await apiHelper.post("/api/laundry.php", body: body, headers: {});
    return response;
  }
}
