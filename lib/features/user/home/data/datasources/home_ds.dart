import '../../../../../core/utils/app_logger.dart';
import '../../../../../core/utils/http_helper.dart';

class HomeDs {
  final ApiBaseHelper apiHelper;

  HomeDs({required this.apiHelper});

  Future<Map<String, dynamic>?> getProducts(Map<String, String>? body) async {
    logger.i(body);

    Map<String, dynamic>? response =
        await apiHelper.post("/api/home.php", body: body, headers: {});
    return response;
  }
}
