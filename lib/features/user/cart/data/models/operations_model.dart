// ignore_for_file: file_names, prefer_typing_uninitialized_variables

class OperationsModel {
  String? errorMsg;
  var status;

  OperationsModel({this.errorMsg, this.status});

  OperationsModel.fromJson(Map<String, dynamic>? json) {
    errorMsg = json?['error_msg'];
    status = json?['status'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error_msg'] = errorMsg;
    data['status'] = status;
    return data;
  }
}
