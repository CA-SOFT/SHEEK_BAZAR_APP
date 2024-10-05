// ignore_for_file: non_constant_identifier_names, file_names

import 'package:sheek_bazar/features/user/categories/data/datasources/categories_ds.dart';
import 'package:sheek_bazar/features/user/categories/data/models/categories_model.dart';

class CategoriesRepo {
  final CategoriesDS dataSource;

  CategoriesRepo({required this.dataSource});

  Future<CategoriesModel> getCategories(Map<String, String>? body) async {
    CategoriesModel MyCategories = CategoriesModel.fromJson(
      await dataSource.getCategories(body),
    );
    return MyCategories;
  }
}
