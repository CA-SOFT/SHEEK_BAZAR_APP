// ignore_for_file: file_names
import '../../../../../core/utils/http_helper.dart';

class FollowDs {
  final ApiBaseHelper apiHelper;

  FollowDs({required this.apiHelper});

  Future<Map<String, dynamic>?> followDs(Map<String, String>? body) async {
    Map<String, dynamic>? response =
        await apiHelper.post("/api/supplier.php", body: body, headers: {});
    return response;
  }
}
