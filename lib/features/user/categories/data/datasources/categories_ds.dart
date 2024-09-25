import 'package:sheek_bazar/core/utils/app_logger.dart';

import '../../../../../core/utils/http_helper.dart';

class CategoriesDS {
  final ApiBaseHelper apiHelper;

  CategoriesDS({required this.apiHelper});

  Future<Map<String, dynamic>?> getCategories(Map<String, String>? body) async {
    logger.i(body);
    Map<String, dynamic>? response =
        await apiHelper.post("/api/categories.php", body: body, headers: {});
    return response;
  }
}
