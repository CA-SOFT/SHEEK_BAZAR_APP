import 'dart:io';

import '../../../../../core/utils/http_helper.dart';

class AddProductDS {
  final ApiBaseHelper apiHelper;

  AddProductDS({required this.apiHelper});

  Future<Map<String, dynamic>?> addProduct(
    Map<String, String>? body,
    List<File>? attachment,
  ) async {
    Map<String, dynamic>? response = await apiHelper.multiPartRequest(
        "/api/supplier.php",
        files: attachment,
        fileKey: 'attachment_name',
        body: body,
        headers: {});
    return response;
  }
}
