import 'package:sheek_bazar/core/utils/app_logger.dart';

import '../../../../../core/utils/http_helper.dart';

class AddressDs {
  final ApiBaseHelper apiHelper;

  AddressDs({required this.apiHelper});

  Future<Map<String, dynamic>?> address(Map<String, String>? body) async {
    logger.i(body);
    Map<String, dynamic>? response =
        await apiHelper.post("/api/addresses.php", body: body, headers: {});
    return response;
  }
}
