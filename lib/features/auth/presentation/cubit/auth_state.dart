// ignore_for_file: must_be_immutable, non_constant_identifier_names

part of 'auth_cubit.dart';

class AuthState extends Equatable {
  AuthState(
      {this.show = true,
      this.showconfirmpass = true,
      this.user_phone,
      this.user_password,
      this.loading = false,
      this.userNameForSignUp,
      this.phoneNumberForSignUp,
      this.passwordForSignUp,
      this.phoneNumberForResetPassword,
      this.newPasswordForReset,
      this.validationCode,
      this.userIdFromForgetPassword,
      this.confirmNewPasswordForReset,
      this.referral_code,
      this.sendSMSSuccessfully = false,
      this.sendWhatsappSuccessfully = false,
      this.confirmPasswordForSignUp});
  bool show;
  bool showconfirmpass;
  bool? sendSMSSuccessfully;
  bool? sendWhatsappSuccessfully;
  final String? user_phone;
  final String? referral_code;
  final String? user_password;
  final String? validationCode;
  final String? userIdFromForgetPassword;
  final String? userNameForSignUp;
  final String? phoneNumberForSignUp;
  final String? passwordForSignUp;
  final String? confirmPasswordForSignUp;
  final String? phoneNumberForResetPassword;
  final String? newPasswordForReset;
  final String? confirmNewPasswordForReset;
  bool loading;
  @override
  List<Object?> get props => [
        show,
        showconfirmpass,
        user_phone,
        sendSMSSuccessfully,
        referral_code,
        user_password,
        loading,
        confirmNewPasswordForReset,
        sendWhatsappSuccessfully,
        validationCode,
        phoneNumberForResetPassword,
        userIdFromForgetPassword,
        userNameForSignUp,
        phoneNumberForSignUp,
        passwordForSignUp,
        confirmPasswordForSignUp,
        newPasswordForReset,
      ];
  AuthState copyWith(
          {bool? show,
          bool? showconfirmpass,
          bool? sendSMSSuccessfully,
          bool? sendWhatsappSuccessfully,
          String? user_phone,
          String? referral_code,
          String? validationCode,
          String? user_password,
          String? userIdFromForgetPassword,
          String? userNameForSignUp,
          String? phoneNumberForSignUp,
          String? phoneNumberForResetPassword,
          String? passwordForSignUp,
          String? confirmNewPasswordForReset,
          String? confirmPasswordForSignUp,
          String? newPasswordForReset,
          bool? loading}) =>
      AuthState(
        show: show ?? this.show,
        sendWhatsappSuccessfully:
            sendWhatsappSuccessfully ?? this.sendWhatsappSuccessfully,
        showconfirmpass: showconfirmpass ?? this.showconfirmpass,
        referral_code: referral_code ?? this.referral_code,
        newPasswordForReset: newPasswordForReset ?? this.newPasswordForReset,
        validationCode: validationCode ?? this.validationCode,
        sendSMSSuccessfully: sendSMSSuccessfully ?? this.sendSMSSuccessfully,
        userIdFromForgetPassword:
            userIdFromForgetPassword ?? this.userIdFromForgetPassword,
        confirmNewPasswordForReset:
            confirmNewPasswordForReset ?? this.confirmNewPasswordForReset,
        user_phone: user_phone ?? this.user_phone,
        phoneNumberForResetPassword:
            phoneNumberForResetPassword ?? this.phoneNumberForResetPassword,
        user_password: user_password ?? this.user_password,
        loading: loading ?? this.loading,
        userNameForSignUp: userNameForSignUp ?? this.userNameForSignUp,
        phoneNumberForSignUp: phoneNumberForSignUp ?? this.phoneNumberForSignUp,
        passwordForSignUp: passwordForSignUp ?? this.passwordForSignUp,
        confirmPasswordForSignUp:
            confirmPasswordForSignUp ?? this.confirmPasswordForSignUp,
      );
}

class AuthInitial extends AuthState {}
