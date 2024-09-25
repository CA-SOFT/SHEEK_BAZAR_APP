// ignore_for_file: prefer_typing_uninitialized_variables

class UserIndoModel {
  List<ProfileInfo>? profileInfo;

  UserIndoModel({this.profileInfo});

  UserIndoModel.fromJson(Map<String, dynamic>? json) {
    if (json?['profile_info'] != null) {
      profileInfo = <ProfileInfo>[];
      json?['profile_info'].forEach((v) {
        profileInfo!.add(ProfileInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profileInfo != null) {
      data['profile_info'] = profileInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfileInfo {
  var userId;
  var userName;
  var userPhone;
  var userPassword;
  var customerId;
  var myPoints;

  ProfileInfo(
      {this.userId,
      this.userName,
      this.userPhone,
      this.userPassword,
      this.customerId,
      this.myPoints});

  ProfileInfo.fromJson(Map<String, dynamic>? json) {
    userId = json?['user_id'];
    userName = json?['user_name'];
    userPhone = json?['user_phone'];
    userPassword = json?['user_password'];
    customerId = json?['customer_id'];
    myPoints = json?['my_points'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['user_phone'] = userPhone;
    data['user_password'] = userPassword;
    data['customer_id'] = customerId;
    data['my_points'] = myPoints;
    return data;
  }
}
