// ignore_for_file: non_constant_identifier_names

import 'package:sheek_bazar/features/auth/data/datasources/login_ds.dart';

import '../models/auth_model.dart';

class LogInRepo {
  final LogInDs dataSource;

  LogInRepo({required this.dataSource});

  Future<AuthInModel> LogIn({required Map<String, String> body}) async {
    AuthInModel response = AuthInModel.fromJson(
      await dataSource.logIn(body),
    );
    return response;
  }
}
