// ignore_for_file: prefer_typing_uninitialized_variables

class ForgetPasswordModel {
  String? errorMsg;
  String? status;
  var code;
  var userId;

  ForgetPasswordModel({this.errorMsg, this.status, this.code, this.userId});

  ForgetPasswordModel.fromJson(Map<String, dynamic>? json) {
    errorMsg = json?['error_msg'];
    status = json?['status'];
    code = json?['code'];
    userId = json?['user_id'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error_msg'] = errorMsg;
    data['status'] = status;
    data['code'] = code;
    data['user_id'] = userId;
    return data;
  }
}
