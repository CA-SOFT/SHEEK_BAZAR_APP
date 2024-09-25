// ignore_for_file: prefer_typing_uninitialized_variables
class AuthInModel {
  var errorMsg;
  var status;
  var userId;
  var userName;
  var userType;
  var customerId;
  var supplierId;
  var referralCode;

  AuthInModel(
      {this.errorMsg,
      this.status,
      this.userId,
      this.userName,
      this.userType,
      this.customerId,
      this.supplierId,
      this.referralCode});

  AuthInModel.fromJson(Map<String, dynamic>? json) {
    errorMsg = json?['error_msg'];
    status = json?['status'];
    userId = json?['user_id'];
    userName = json?['user_name'];
    userType = json?['user_type'];
    customerId = json?['customer_id'];
    supplierId = json?['supplier_id'];
    referralCode = json?['referral_code'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error_msg'] = errorMsg;
    data['status'] = status;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['user_type'] = userType;
    data['customer_id'] = customerId;
    data['supplier_id'] = supplierId;
    data['referral_code'] = referralCode;
    return data;
  }
}

// class AuthInModel {
//   var errorMsg;
//   var status;
//   var userId;
//   var userName;
//   var userType;
//   var customerId;
//   var supplierId;

//   AuthInModel(
//       {this.errorMsg,
//       this.status,
//       this.userId,
//       this.userName,
//       this.userType,
//       this.customerId,
//       this.supplierId});

//   AuthInModel.fromJson(Map<String, dynamic>? json) {
//     errorMsg = json?['error_msg'];
//     status = json?['status'];
//     userId = json?['user_id'];
//     userName = json?['user_name'];
//     userType = json?['user_type'];
//     customerId = json?['customer_id'];
//     supplierId = json?['supplier_id'];
//   }

//   Map<String, dynamic>? toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['error_msg'] = errorMsg;
//     data['status'] = status;
//     data['user_id'] = userId;
//     data['user_name'] = userName;
//     data['user_type'] = userType;
//     data['customer_id'] = customerId;
//     data['supplier_id'] = supplierId;
//     return data;
//   }
// }
