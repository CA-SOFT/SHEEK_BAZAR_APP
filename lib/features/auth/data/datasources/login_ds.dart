import '../../../../core/utils/http_helper.dart';

class LogInDs {
  final ApiBaseHelper apiHelper;

  LogInDs({required this.apiHelper});

  Future<Map<String, dynamic>?> logIn(Map<String, String>? body) async {
    Map<String, dynamic>? response =
        await apiHelper.post("/api/login.php", body: body, headers: {});
    return response;
  }
}
