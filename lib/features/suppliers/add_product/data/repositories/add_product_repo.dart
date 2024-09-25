// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:io';

import 'package:sheek_bazar/features/suppliers/add_product/data/datasources/add_product_ds.dart';
import 'package:sheek_bazar/features/suppliers/add_product/data/models/add_product_model.dart';

class AddProductRepo {
  final AddProductDS dataSource;

  AddProductRepo({required this.dataSource});

  Future<AddProductModel> AddProduct(
    Map<String, String>? body,
    List<File>? attachment,
  ) async {
    AddProductModel AddProductRespone = AddProductModel.fromJson(
      await dataSource.addProduct(body, attachment),
    );
    return AddProductRespone;
  }
}
