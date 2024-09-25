import '../../../../core/utils/app_logger.dart';
import '../../../../core/utils/http_helper.dart';

class ForgetPAsswordDS {
  final ApiBaseHelper apiHelper;

  ForgetPAsswordDS({required this.apiHelper});

  Future<Map<String, dynamic>?> forgetPassword(
      Map<String, String>? body) async {
    logger.e(body);

    Map<String, dynamic>? response = await apiHelper
        .post("/api/reset_password.php", body: body, headers: {});
    return response;
  }
}
