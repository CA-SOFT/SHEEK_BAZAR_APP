import 'dart:io';

import '../../../../../core/utils/http_helper.dart';

class UpdateProductDS {
  final ApiBaseHelper apiHelper;

  UpdateProductDS({required this.apiHelper});

  Future<Map<String, dynamic>?> updateProduct(
    Map<String, String>? body,
    List<File>? imagesAttachment,
    List<File>? videosAttachment,
  ) async {
    Map<String, dynamic>? response = await apiHelper.multiPartRequest(
        "/api/supplier.php",
        files: imagesAttachment,
        fileKey: 'images',
        files2: videosAttachment,
        fileKey2: 'videos',
        body: body,
        headers: {});
    return response;
  }
}
