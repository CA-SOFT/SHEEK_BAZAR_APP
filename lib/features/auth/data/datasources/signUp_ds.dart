// ignore_for_file: file_names

import '../../../../core/utils/http_helper.dart';

class SignUpDs {
  final ApiBaseHelper apiHelper;

  SignUpDs({required this.apiHelper});

  Future<Map<String, dynamic>?> signUp(Map<String, String>? body) async {
    Map<String, dynamic>? response =
        await apiHelper.post("/api/signup.php", body: body, headers: {});
    return response;
  }
}
