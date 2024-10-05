class CollectPointsModel {
  bool? status;
  String? message;
  String? newDate;

  CollectPointsModel({this.status, this.message, this.newDate});

  CollectPointsModel.fromJson(Map<String, dynamic>? json) {
    status = json?['status'];
    message = json?['message'];
    newDate = json?['new_date'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['new_date'] = newDate;
    return data;
  }
}
