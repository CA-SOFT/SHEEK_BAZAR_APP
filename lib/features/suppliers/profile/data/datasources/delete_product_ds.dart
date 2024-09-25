import '../../../../../core/utils/http_helper.dart';

class DeleteProductDS {
  final ApiBaseHelper apiHelper;

  DeleteProductDS({required this.apiHelper});

  Future<Map<String, dynamic>?> deleteProduct(
    Map<String, String>? body,
  ) async {
    Map<String, dynamic>? response =
        await apiHelper.post("/api/supplier.php", body: body, headers: {});
    return response;
  }
}
