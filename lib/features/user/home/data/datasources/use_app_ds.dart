// ignore_for_file: file_names

import '../../../../../core/utils/http_helper.dart';

class UseAppDS {
  final ApiBaseHelper apiHelper;

  UseAppDS({required this.apiHelper});

  Future<Map<String, dynamic>?> getUseApp(Map<String, String>? body) async {
    Map<String, dynamic>? response = await apiHelper
        .post("/api/tutorial_videos.php", body: body, headers: {});
    return response;
  }
}
