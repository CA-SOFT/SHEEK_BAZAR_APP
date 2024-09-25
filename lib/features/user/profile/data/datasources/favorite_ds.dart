import '../../../../../core/utils/http_helper.dart';

class FavoriteDS {
  final ApiBaseHelper apiHelper;

  FavoriteDS({required this.apiHelper});

  Future<Map<String, dynamic>?> getMyFavorite(Map<String, String>? body) async {
    Map<String, dynamic>? response =
        await apiHelper.post("/api/wishlist.php", body: body, headers: {});
    return response;
  }
}
