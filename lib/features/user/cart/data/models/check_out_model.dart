// ignore_for_file: file_names, prefer_typing_uninitialized_variables

class CheckOutModel {
  String? errorMsg;
  var status;
  var paidMessage;

  CheckOutModel({this.errorMsg, this.status, this.paidMessage});

  CheckOutModel.fromJson(Map<String, dynamic>? json) {
    errorMsg = json?['error_msg'];
    status = json?['status'];
    paidMessage = json?['paid_message'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error_msg'] = errorMsg;
    data['status'] = status;
    data['paid_message'] = paidMessage;
    return data;
  }
}
