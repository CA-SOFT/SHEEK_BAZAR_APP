// ignore_for_file: file_names

import '../../../../../core/utils/http_helper.dart';

class ProductDetailsDs {
  final ApiBaseHelper apiHelper;

  ProductDetailsDs({required this.apiHelper});

  Future<Map<String, dynamic>?> getProductDetails(
      Map<String, String>? body) async {
    Map<String, dynamic>? response = await apiHelper
        .post("/api/product_details.php", body: body, headers: {});
    return response;
  }
}
