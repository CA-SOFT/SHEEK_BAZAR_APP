// ignore_for_file: file_names

import 'package:sheek_bazar/features/auth/data/datasources/signUp_ds.dart';
import '../models/auth_model.dart';

class SignUpRepo {
  final SignUpDs dataSource;

  SignUpRepo({required this.dataSource});

  Future<AuthInModel> signUp({required Map<String, String> body}) async {
    AuthInModel response = AuthInModel.fromJson(
      await dataSource.signUp(body),
    );
    return response;
  }
}
