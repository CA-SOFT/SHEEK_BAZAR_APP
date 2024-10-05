// ignore_for_file: non_constant_identifier_names, file_names

import 'package:sheek_bazar/features/user/cart/data/datasources/address_ds.dart';

import '../models/operations_model.dart';
import '../models/myAddress_model.dart';
import '../models/provinces_model.dart';

class MyAddressRepo {
  final AddressDs dataSource;

  MyAddressRepo({required this.dataSource});

  Future<MyAddressModel> getMyAddress(Map<String, String>? body) async {
    MyAddressModel MyOrdersResponse = MyAddressModel.fromJson(
      await dataSource.address(body),
    );
    return MyOrdersResponse;
  }

  Future<ProvincesModel> Getprovinces(Map<String, String>? body) async {
    ProvincesModel provincesModel = ProvincesModel.fromJson(
      await dataSource.address(body),
    );
    return provincesModel;
  }

  Future<OperationsModel> addressOpertion(Map<String, String>? body) async {
    OperationsModel provincesModel = OperationsModel.fromJson(
      await dataSource.address(body),
    );
    return provincesModel;
  }
}
