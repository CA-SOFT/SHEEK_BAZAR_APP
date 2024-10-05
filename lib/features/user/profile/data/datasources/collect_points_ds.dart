import '../../../../../core/utils/http_helper.dart';

class CollectPointsDS {
  final ApiBaseHelper apiHelper;

  CollectPointsDS({required this.apiHelper});

  Future<Map<String, dynamic>?> collectPoints(Map<String, String>? body) async {
    Map<String, dynamic>? response =
        await apiHelper.post("/api/activities.php", body: body, headers: {});
    return response;
  }
}
