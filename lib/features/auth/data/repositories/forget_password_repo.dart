import 'package:sheek_bazar/features/auth/data/datasources/forget_password_ds.dart';
import 'package:sheek_bazar/features/auth/data/models/forget_password_model.dart';
import 'package:sheek_bazar/features/user/cart/data/models/operations_model.dart';

class ForgetPassswordRepo {
  final ForgetPAsswordDS dataSource;

  ForgetPassswordRepo({required this.dataSource});

  Future<ForgetPasswordModel> forgetPassword(
      {required Map<String, String> body}) async {
    ForgetPasswordModel response = ForgetPasswordModel.fromJson(
      await dataSource.forgetPassword(body),
    );
    return response;
  }

  Future<OperationsModel> resetPassword(
      {required Map<String, String> body}) async {
    OperationsModel response = OperationsModel.fromJson(
      await dataSource.forgetPassword(body),
    );
    return response;
  }
}
