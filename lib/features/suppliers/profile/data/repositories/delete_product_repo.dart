// ignore_for_file: non_constant_identifier_names, file_names
import 'package:sheek_bazar/features/suppliers/profile/data/datasources/delete_product_ds.dart';
import 'package:sheek_bazar/features/suppliers/profile/data/models/delete_product_model.dart';

class DeleteProductRepo {
  final DeleteProductDS dataSource;

  DeleteProductRepo({required this.dataSource});

  Future<DeleteProductModel> deleteProduct(
    Map<String, String>? body,
  ) async {
    DeleteProductModel AddProductRespone = DeleteProductModel.fromJson(
      await dataSource.deleteProduct(body),
    );
    return AddProductRespone;
  }
}
