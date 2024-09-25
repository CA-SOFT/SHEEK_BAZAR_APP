// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/features/auth/data/models/forget_password_model.dart';
import 'package:sheek_bazar/features/auth/presentation/pages/congratulation_screen.dart';
import 'package:sheek_bazar/features/suppliers/HomeScreenForSupllier/presentation/pages/home_supplier_screen.dart';
import 'package:sheek_bazar/sections_screen.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../../../core/utils/http_helper.dart';
import '../../../user/cart/data/models/operations_model.dart';
import '../../data/models/auth_model.dart';
import '../../data/repositories/forget_password_repo.dart';
import '../../data/repositories/login_repo.dart';
import '../../../../injection_container.dart' as di;
import '../../data/repositories/signUp_repo.dart';
import '../pages/sign_in.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LogInRepo logInRepo;
  final SignUpRepo signUpRepo;
  final ForgetPassswordRepo forgetPassswordRepo;
  AuthCubit(
      {required this.logInRepo,
      required this.signUpRepo,
      required this.forgetPassswordRepo})
      : super(AuthInitial());

  ///////////////////////// Section For LogIn /////////////////////////////////////
  Future<void> logIn(BuildContext context) async {
    try {
      if (await fieldsValidationForLogIn(context)) {
        emit(state.copyWith(loading: true));
        Map<String, String> body = {};
        body['user_phone'] = "${state.user_phone}";
        body['user_password'] = "${state.user_password}";
        AuthInModel? user = await logInRepo.LogIn(body: body);
        emit(state.copyWith(loading: false));

        if (user.errorMsg == "true") {
          if (user.status == "user_not_exist") {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.primaryColor,
                padding: EdgeInsets.only(
                    bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
                content: Text(
                  'no_account'.tr(context),
                  style: const TextStyle(color: Colors.red),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
            // AppConstant.customAlert(context, "no_account");
          } else if (user.status == "wrong_password") {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.primaryColor,
                padding: EdgeInsets.only(
                    bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
                content: Text(
                  'wrong_pass'.tr(context),
                  style: const TextStyle(color: Colors.red),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
            // AppConstant.customAlert(context, "wrong_pass");
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.primaryColor,
                padding: EdgeInsets.only(
                    bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
                content: Text(
                  user.status!.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
            // AppConstant.customAlert(context, user.status!.toString(),
            //     withTranslate: false);
          }
        } else {
          if (user.status == 'success_login') {
            await cacheData(user, state.user_password!.toString(),
                state.user_phone!.toString());
            di.sl<ApiBaseHelper>().updateHeader();
            if (user.userType == "customer") {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const SectionsScreen()),
                (Route route) => false,
              );
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeSupplier()),
                (Route route) => false,
              );
            }
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.only(
              bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
          content: Text(
            e.toString(),
            style: const TextStyle(color: Colors.red),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      // await AppConstant.customAlert(context, e.toString(),
      //     withTranslate: false);
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> cacheData(
      AuthInModel response, String? password, String? phoneNumer) async {
    if (response.userId != null) {
      await CacheHelper.saveData(key: "USER_ID", value: response.userId);
    }
    if (response.customerId != null) {
      await CacheHelper.saveData(
          key: "CUSTOMER_ID", value: response.customerId);
    }
    if (response.userType != null) {
      await CacheHelper.saveData(key: "USER_TYPE", value: response.userType);
    }
    if (response.supplierId != null) {
      await CacheHelper.saveData(
          key: "SUPPLIER_ID", value: response.supplierId);
    }
    if (response.userName != null) {
      await CacheHelper.saveData(
        key: "USER_NAME",
        value: response.userName,
      );
    }
    if (response.referralCode != null) {
      await CacheHelper.saveData(
        key: "REFERRAL_CODE",
        value: response.referralCode,
      );
    }
    await CacheHelper.saveData(
      key: "USER_PASSWORD",
      value: password,
    );
    await CacheHelper.saveData(
      key: "USER_PHONENUMBER",
      value: phoneNumer,
    );
  }

  Future<bool> fieldsValidationForLogIn(BuildContext context) async {
    if (state.user_phone == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.only(
              bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
          content: Text(
            "Enter_phone_number".tr(context),
            style: const TextStyle(color: Colors.red),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      // await AppConstant.customAlert(context, "Enter_phone_number");
      return false;
    } else {
      bool startsWith07 = state.user_phone!.startsWith("07");

      if (startsWith07 == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.primaryColor,
            padding: EdgeInsets.only(
                bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
            content: Text(
              "statr_with".tr(context),
              style: const TextStyle(color: Colors.red),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
        // await AppConstant.customAlert(context, "statr_with");
        return false;
      }
    }
    if (state.user_password == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.only(
              bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
          content: Text(
            "password".tr(context),
            style: const TextStyle(color: Colors.red),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      // await AppConstant.customAlert(context, "password");
      return false;
    }
    return true;
  }

  changePasswordVisability() {
    emit(state.copyWith(show: !state.show));
  }

  changeConfirmPasswordVisability() {
    emit(state.copyWith(showconfirmpass: !state.showconfirmpass));
  }

  changeUserPhone(String value) => emit(state.copyWith(user_phone: value));

  changeUserPassword(String value) {
    emit(state.copyWith(user_password: value));
  }

  ///////////////////////// Section For SignUp /////////////////////////////////////
  changeUserNameForSignUp(String value) =>
      emit(state.copyWith(userNameForSignUp: value));
  changePhoneNumberForSignUp(String value) =>
      emit(state.copyWith(phoneNumberForSignUp: value));
  changePasswordForSignUp(String value) =>
      emit(state.copyWith(passwordForSignUp: value));
  changeConfirmPasswordForSignUp(String value) =>
      emit(state.copyWith(confirmPasswordForSignUp: value));
  changeReferralCodeValue(String value) =>
      emit(state.copyWith(referral_code: value));

  Future<void> SignUp(BuildContext context) async {
    try {
      if (await fieldsValidationForSignUp(context)) {
        emit(state.copyWith(loading: true));

        Map<String, String> body = {};
        body['user_name'] = "${state.userNameForSignUp}";
        body['user_phone'] = "${state.phoneNumberForSignUp}";
        body['user_password'] = "${state.passwordForSignUp}";
        body['referral_code'] = state.referral_code ?? "";
        AuthInModel? user = await signUpRepo.signUp(body: body);
        emit(state.copyWith(loading: false));

        if (user.errorMsg == "true") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.primaryColor,
              padding: EdgeInsets.only(
                  bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
              content: Text(
                user.status!,
                style: const TextStyle(color: Colors.red),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
          // AppConstant.customAlert(context, user.status!, withTranslate: false);
        } else {
          di.sl<ApiBaseHelper>().updateHeader();
          await cacheData(
              user, state.passwordForSignUp!, state.phoneNumberForSignUp!);
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => const CongratulationScreen()),
            (Route route) => false,
          );
        }
      }
    } catch (e) {
      emit(state.copyWith(loading: false));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.only(
              bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
          content: Text(
            e.toString(),
            style: const TextStyle(color: Colors.red),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      // await AppConstant.customAlert(context, e.toString(),
      //     withTranslate: false);
    }
  }

  Future<bool> fieldsValidationForSignUp(BuildContext context) async {
    if (state.userNameForSignUp == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.only(
              bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
          content: Text(
            'user_name'.tr(context),
            style: const TextStyle(color: Colors.red),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      // await AppConstant.customAlert(context, "user_name");
      return false;
    }
    if (state.phoneNumberForSignUp == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.only(
              bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
          content: Text(
            'Enter_phone_number'.tr(context),
            style: const TextStyle(color: Colors.red),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      // await AppConstant.customAlert(context, "Enter_phone_number");
      return false;
    } else {
      // bool startsWith07 = state.phoneNumberForSignUp!.startsWith("07");

      // if (startsWith07 == false) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       backgroundColor: AppColors.primaryColor,
      //       padding: EdgeInsets.only(
      //           bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
      //       content: Text(
      //         'statr_with'.tr(context),
      //         style: const TextStyle(color: Colors.red),
      //       ),
      //       duration: const Duration(seconds: 2),
      //     ),
      //   );
      //   // await AppConstant.customAlert(context, "statr_with");
      //   return false;
      // }
    }
    if (state.passwordForSignUp == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.only(
              bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
          content: Text(
            'password'.tr(context),
            style: const TextStyle(color: Colors.red),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      // await AppConstant.customAlert(context, "password");
      return false;
    }
    if (state.confirmPasswordForSignUp == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.only(
              bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
          content: Text(
            'confirm_pass'.tr(context),
            style: const TextStyle(color: Colors.red),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      // await AppConstant.customAlert(context, "confirm_pass");
      return false;
    }
    if (state.passwordForSignUp != state.confirmPasswordForSignUp) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.only(
              bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
          content: Text(
            'no_match'.tr(context),
            style: const TextStyle(color: Colors.red),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      // await AppConstant.customAlert(context, "no_match");
      return false;
    }
    return true;
  }

  //////////////////// Reset Password Section //////////////////////////////
  ///
  onChangePhoneNumberForResetPassword(String value) =>
      emit(state.copyWith(phoneNumberForResetPassword: value));

  Future<void> sendSmS(BuildContext context, {bool fromSignUp = false}) async {
    try {
      if (state.phoneNumberForResetPassword != null) {
        if (state.phoneNumberForResetPassword!.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.primaryColor,
              padding: EdgeInsets.only(
                  bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
              content: Text(
                'Enter_phone_number'.tr(context),
                style: const TextStyle(color: Colors.red),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        } else {
          bool startsWith07 =
              state.phoneNumberForResetPassword!.startsWith("07");
          if (startsWith07) {
            emit(state.copyWith(loading: true));
            Map<String, String> body = {};
            body['user_phone'] = state.phoneNumberForResetPassword!;
            if (fromSignUp) {
              body['activate_user'] = "1";
            } else {
              body['send_reset_code'] = "1";
            }

            ForgetPasswordModel data =
                await forgetPassswordRepo.forgetPassword(body: body);
            logger.e(data);

            if (fromSignUp == false) {
              if (data.status == "user_not_exist") {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.primaryColor,
                    padding: EdgeInsets.only(
                        bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
                    content: Text(
                      'no_account'.tr(context),
                      style: const TextStyle(color: Colors.red),
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            }
            if (data.errorMsg == "false" && data.status == "success") {
              emit(state.copyWith(sendSMSSuccessfully: true));
              emit(state.copyWith(validationCode: data.code));
              emit(state.copyWith(userIdFromForgetPassword: data.userId));
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.primaryColor,
                padding: EdgeInsets.only(
                    bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
                content: Text(
                  'statr_with'.tr(context),
                  style: const TextStyle(color: Colors.red),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.primaryColor,
            padding: EdgeInsets.only(
                bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
            content: Text(
              'Enter_phone_number'.tr(context),
              style: const TextStyle(color: Colors.red),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }

      emit(state.copyWith(loading: false));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(loading: false));
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  clearForgetPasswordVar() => emit(state.copyWith(
      sendSMSSuccessfully: false,
      validationCode: "",
      phoneNumberForResetPassword: ""));

  ///////////////////////////////// Reset Password ////////////////////////
  changeNewPasswordForReset(value) =>
      emit(state.copyWith(newPasswordForReset: value));
  changeConfirmNewPasswordForReset(value) =>
      emit(state.copyWith(confirmNewPasswordForReset: value));

  Future<void> resetPassword(BuildContext context) async {
    try {
      if (state.confirmNewPasswordForReset != null ||
          state.newPasswordForReset != null) {
        if (state.confirmNewPasswordForReset!.isEmpty ||
            state.newPasswordForReset!.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.primaryColor,
              padding: EdgeInsets.only(
                  bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
              content: Text(
                'password'.tr(context),
                style: const TextStyle(color: Colors.red),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        } else {
          if (state.confirmNewPasswordForReset == state.newPasswordForReset) {
            emit(state.copyWith(loading: true));
            Map<String, String> body = {};
            body['new_password'] = state.newPasswordForReset!;
            body['reset_password'] = "1";
            body['user_id'] = state.userIdFromForgetPassword!;

            OperationsModel data =
                await forgetPassswordRepo.resetPassword(body: body);
            logger.e(data);

            if (data.errorMsg == "false") {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const SigninScreen()),
                (Route route) => false,
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.primaryColor,
                padding: EdgeInsets.only(
                    bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
                content: Text(
                  'no_match'.tr(context),
                  style: const TextStyle(color: Colors.red),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.primaryColor,
            padding: EdgeInsets.only(
                bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
            content: Text(
              'password'.tr(context),
              style: const TextStyle(color: Colors.red),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }

      emit(state.copyWith(loading: false));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(loading: false));
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  /////////////////Whatsapp Section////////////////
  changesendWhatsappSuccessfully() =>
      emit(state.copyWith(sendWhatsappSuccessfully: true));
  changesendWhatsappUnsuccessfully() =>
      emit(state.copyWith(sendWhatsappSuccessfully: false));
  changeLoadingState(bool value) => emit(state.copyWith(loading: value));
}
