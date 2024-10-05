// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:io';
import 'package:sheek_bazar/features/suppliers/profile/data/datasources/update_product_ds.dart';
import 'package:sheek_bazar/features/suppliers/profile/data/models/update_product_model.dart';

class UpdateProductRepo {
  final UpdateProductDS dataSource;

  UpdateProductRepo({required this.dataSource});

  Future<UpdateProductModel> AddProduct(
    Map<String, String>? body,
    List<File>? imagesattachment,
    List<File>? videosattachment,
  ) async {
    UpdateProductModel AddProductRespone = UpdateProductModel.fromJson(
      await dataSource.updateProduct(body, imagesattachment, videosattachment),
    );
    return AddProductRespone;
  }
}
