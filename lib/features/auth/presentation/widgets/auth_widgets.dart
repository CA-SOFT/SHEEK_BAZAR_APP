// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:sheek_bazar/features/auth/presentation/pages/sign_in.dart';
import 'package:sheek_bazar/features/auth/presentation/pages/sign_up.dart';
import 'package:sheek_bazar/features/auth/presentation/pages/whatsapp_confirm_screen.dart';
import 'package:sheek_bazar/sections_screen.dart';

import '../../../../core/utils/app_colors.dart';
import '../pages/forget_password_screen.dart';

class FloationgIcon extends StatelessWidget {
  const FloationgIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemesCubit, ThemesState>(
      builder: (context, theme) {
        return Positioned(
          top: MediaQuery.of(context).size.height * 0.27,
          right: MediaQuery.of(context).size.width * 0.4,
          child: CircleAvatar(
            radius: 100.0.r,
            backgroundColor:
                theme.mode == "dark" ? Colors.grey[900] : AppColors.whiteColor,
            child: Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: CircleAvatar(
                backgroundColor: theme.mode == "dark"
                    ? AppColors.whiteColor
                    : AppColors.primaryColor,
                radius: 75.0.r,
                child: Padding(
                  padding: EdgeInsets.all(15.0.sp),
                  child: Image.asset(
                    'assets/images/icon.png',
                    color: theme.mode == "dark"
                        ? AppColors.primaryColor
                        : AppColors.whiteColor,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class FormContainerForSignIn extends StatelessWidget {
  const FormContainerForSignIn({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Positioned(
      top: MediaQuery.of(context).size.height * 0.3,
      left: 0,
      right: 0,
      child: SingleChildScrollView(
        child: BlocBuilder<ThemesCubit, ThemesState>(
          builder: (context, theme) {
            return Container(
                height: MediaQuery.of(context).size.height * 0.7,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: theme.mode == "dark"
                      ? Colors.grey[900]
                      : AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(75.0.r),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 120.0.h, left: 80.0.w, right: 80.0.w),
                  child: Column(
                    children: [
                      Text(
                        "Welcome_Dakota".tr(context),
                        style: TextStyle(
                            fontSize: 100.sp, fontWeight: FontWeight.bold),
                      ),
                      AppConstant.customSizedBox(0, 100),
                      TextFormFieldForSignin(
                        controller: controller,
                        hint: "Enter_phone_number",
                        icon: const Icon(
                          Icons.person_outline,
                        ),
                        onChange: (value) {
                          bool startsWith0 = value.startsWith("0");
                          if (startsWith0 == false) {
                            controller.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.primaryColor,
                                padding: EdgeInsets.only(
                                    bottom: 150.h,
                                    top: 50.h,
                                    left: 50.w,
                                    right: 50.w),
                                content: Text(
                                  "statr_with0".tr(context),
                                  style: const TextStyle(color: Colors.red),
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          } else {
                            context.read<AuthCubit>().changeUserPhone(value);
                          }
                        },
                      ),
                      AppConstant.customSizedBox(0, 50),
                      TextFormFieldForSignin(
                        hint: "password",
                        icon: const Icon(
                          Icons.lock_outline,
                        ),
                        onChange: (value) {
                          context.read<AuthCubit>().changeUserPassword(value);
                        },
                      ),
                      AppConstant.customSizedBox(0, 25),
                      Row(
                        children: [
                          AppConstant.customSizedBox(25, 0),
                          Text(
                            "forget_password".tr(context),
                            style: TextStyle(fontSize: 40.sp),
                          ),
                          AppConstant.customSizedBox(25, 0),
                          InkWell(
                            onTap: () {
                              AppConstant.customNavigation(
                                  context, ForgetPasswordScreen(), -1, 0);
                            },
                            child: Text(
                              "click_here".tr(context),
                              style: TextStyle(
                                  fontSize: 40.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      AppConstant.customSizedBox(0, 100),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          return state.loading == true
                              ? AppConstant.customLoadingElvatedButton(context)
                              : AppConstant.customElvatedButton(
                                  context, "sign_in", () {
                                  context.read<AuthCubit>().logIn(context);
                                });
                        },
                      ),
                      AppConstant.customSizedBox(0, 50),
                      AppConstant.customElvatedButton(context, "skip", () {
                        // AppConstant.customNavigation(
                        //     context, const HomeSupplier(), 0, -1);
                        AppConstant.customNavigation(
                            context, const SectionsScreen(), 0, -1);
                      }),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 50.0.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("have_account".tr(context)),
                                InkWell(
                                  onTap: () {
                                    AppConstant.customNavigation(
                                        context, const SignupScreen(), -1, 0);
                                  },
                                  child: Text(
                                    "creat_account".tr(context),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TextFormFieldForSignin extends StatelessWidget {
  String hint;
  Icon icon;
  Function onChange;
  TextEditingController? controller;
  TextFormFieldForSignin(
      {super.key,
      required this.hint,
      required this.icon,
      this.controller,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return TextFormField(
          controller: controller,
          keyboardType:
              hint == "Enter_phone_number" ? TextInputType.number : null,
          obscureText: hint == "password"
              ? state.show
              : hint == "confirm_pass"
                  ? state.showconfirmpass
                  : false,
          decoration: InputDecoration(
            labelText: hint.tr(context),
            prefixIcon: icon,
            suffixIcon: hint == "password" || hint == "confirm_pass"
                ? InkWell(
                    onTap: () {
                      if (hint == "confirm_pass") {
                        context
                            .read<AuthCubit>()
                            .changeConfirmPasswordVisability();
                      } else {
                        context.read<AuthCubit>().changePasswordVisability();
                      }
                    },
                    child: Icon(
                      state.show && hint == "password"
                          ? Icons.visibility
                          : state.show && hint == "password"
                              ? Icons.visibility_off
                              : state.showconfirmpass && hint == "confirm_pass"
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                    ),
                  )
                : null,
          ),
          onChanged: (value) {
            onChange(value);
          },
        );
      },
    );
  }
}

class FormContainerForSignUp extends StatelessWidget {
  const FormContainerForSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemesCubit, ThemesState>(
      builder: (context, theme) {
        return Positioned(
          top: MediaQuery.of(context).size.height * 0.3,
          left: 0,
          right: 0,
          child: Container(
              height: 0.71.sh,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: theme.mode == "dark"
                    ? Colors.grey[900]
                    : AppColors.whiteColor,
                borderRadius: BorderRadius.circular(75.0.h),
              ),
              child: Padding(
                padding:
                    EdgeInsets.only(top: 120.0.h, left: 80.0.w, right: 80.0.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Welcome_Dakota".tr(context),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 100.sp, fontWeight: FontWeight.bold),
                      ),
                      AppConstant.customSizedBox(0, 100),
                      TextFormFieldForSignin(
                        hint: "user_name",
                        icon: const Icon(
                          Icons.person_outline,
                        ),
                        onChange: (value) {
                          context
                              .read<AuthCubit>()
                              .changeUserNameForSignUp(value);
                        },
                      ),
                      AppConstant.customSizedBox(0, 50),
                      TextFormFieldForSignin(
                        hint: "Enter_phone_number",
                        icon: const Icon(
                          Icons.person_outline,
                        ),
                        onChange: (value) {
                          context
                              .read<AuthCubit>()
                              .changePhoneNumberForSignUp(value);
                        },
                      ),
                      AppConstant.customSizedBox(0, 50),
                      TextFormFieldForSignin(
                        hint: "password",
                        icon: const Icon(
                          Icons.lock_outline,
                        ),
                        onChange: (value) {
                          context
                              .read<AuthCubit>()
                              .changePasswordForSignUp(value);
                        },
                      ),
                      AppConstant.customSizedBox(0, 50),
                      TextFormFieldForSignin(
                        hint: "confirm_pass",
                        icon: const Icon(
                          Icons.repeat,
                        ),
                        onChange: (value) {
                          context
                              .read<AuthCubit>()
                              .changeConfirmPasswordForSignUp(value);
                        },
                      ),
                      AppConstant.customSizedBox(0, 50),
                      TextFormFieldForSignin(
                        hint: "referral_code",
                        icon: const Icon(
                          Icons.person_outline,
                        ),
                        onChange: (value) {
                          context
                              .read<AuthCubit>()
                              .changeReferralCodeValue(value);
                        },
                      ),
                      AppConstant.customSizedBox(0, 100),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          return state.loading == true
                              ? AppConstant.customLoadingElvatedButton(context)
                              : AppConstant.customElvatedButton(
                                  context, "sign_up", () async {
                                  if (await context
                                      .read<AuthCubit>()
                                      .fieldsValidationForSignUp(context)) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(30.sp),
                                              topLeft: Radius.circular(30.sp)),
                                          child: SizedBox(
                                            height: 0.4.sh,
                                            child: Column(
                                              children: [
                                                AppConstant.customSizedBox(
                                                    0, 40),
                                                Text(
                                                  "Choose_a_method_to_verify_the_account"
                                                      .tr(context),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                AppConstant.customSizedBox(
                                                    0, 20),
                                                BlocBuilder<ThemesCubit,
                                                    ThemesState>(
                                                  builder: (context, theme) {
                                                    return BlocBuilder<
                                                        AuthCubit, AuthState>(
                                                      builder:
                                                          (context, state) {
                                                        return InkWell(
                                                          onTap: () async {
                                                            AppConstant
                                                                .customNavigation(
                                                                    context,
                                                                    const WhatsappConfirmScreen(),
                                                                    -1,
                                                                    0);
                                                          },
                                                          child: Container(
                                                            width: 0.9.sw,
                                                            height: 0.1.sh,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        50.w,
                                                                    vertical:
                                                                        25.h),
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10.w,
                                                                    vertical:
                                                                        50.h),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: theme
                                                                          .mode ==
                                                                      "dark"
                                                                  ? AppColors
                                                                      .whiteColor
                                                                  : AppColors
                                                                      .whiteColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0.sp),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.2),
                                                                  offset:
                                                                      const Offset(
                                                                          2.0,
                                                                          2.0),
                                                                  blurRadius:
                                                                      8.0,
                                                                ),
                                                              ],
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                theme.mode ==
                                                                        "dark"
                                                                    ? Image
                                                                        .asset(
                                                                        "assets/images/whatsapp_dark_mode.png",
                                                                        height:
                                                                            100.h,
                                                                      )
                                                                    : Image
                                                                        .asset(
                                                                        "assets/images/whatsapp_logo.jpeg",
                                                                        height:
                                                                            100.h,
                                                                      ),
                                                                Text(
                                                                  "Whatsapp",
                                                                  style: TextStyle(
                                                                      color: AppColors
                                                                          .primaryColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          50.sp),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                                // BlocBuilder<ThemesCubit,
                                                //     ThemesState>(
                                                //   builder: (context, theme) {
                                                //     return InkWell(
                                                //       onTap: () {
                                                //         AppConstant
                                                //             .customNavigation(
                                                //                 context,
                                                //                 ForgetPasswordScreen(
                                                //                     fromSignUp:
                                                //                         true),
                                                //                 -1,
                                                //                 0);
                                                //       },
                                                //       child: Container(
                                                //         width: 0.9.sw,
                                                //         height: 0.1.sh,
                                                //         padding: EdgeInsets
                                                //             .symmetric(
                                                //                 horizontal:
                                                //                     75.w,
                                                //                 vertical: 25.h),
                                                //         margin: EdgeInsets
                                                //             .symmetric(
                                                //                 horizontal:
                                                //                     10.w,
                                                //                 vertical: 50.h),
                                                //         decoration:
                                                //             BoxDecoration(
                                                //           color: theme.mode ==
                                                //                   "dark"
                                                //               ? AppColors
                                                //                   .primaryColor
                                                //               : AppColors
                                                //                   .whiteColor,
                                                //           borderRadius:
                                                //               BorderRadius
                                                //                   .circular(
                                                //                       10.0.sp),
                                                //           boxShadow: [
                                                //             BoxShadow(
                                                //               color: Colors.grey
                                                //                   .withOpacity(
                                                //                       0.2),
                                                //               offset:
                                                //                   const Offset(
                                                //                       2.0, 2.0),
                                                //               blurRadius: 8.0,
                                                //             ),
                                                //           ],
                                                //         ),
                                                //         child: Row(
                                                //           mainAxisAlignment:
                                                //               MainAxisAlignment
                                                //                   .spaceBetween,
                                                //           children: [
                                                //             CircleAvatar(
                                                //               backgroundColor:
                                                //                   AppColors
                                                //                       .primaryColor,
                                                //               radius: 50.sp,
                                                //               child: Icon(
                                                //                 Icons.mail,
                                                //                 color: AppColors
                                                //                     .whiteColor,
                                                //                 size: 50.sp,
                                                //               ),
                                                //             ),
                                                //             Text(
                                                //               "SMS",
                                                //               style: TextStyle(
                                                //                   fontWeight:
                                                //                       FontWeight
                                                //                           .bold,
                                                //                   fontSize:
                                                //                       50.sp),
                                                //             ),
                                                //           ],
                                                //         ),
                                                //       ),
                                                //     );
                                                //   },
                                                // )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                    // showDialog(
                                    //   context: context,
                                    //   builder: (context) {
                                    //     return AlertDialog(
                                    //       content:
                                    //     );
                                    //   },
                                    // );
                                    // Navigator.of(context).pushAndRemoveUntil(
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           const ConfirmAccountScreen()),
                                    //   (Route route) => false,
                                    // );
                                  }
                                });
                        },
                      ),
                      AppConstant.customSizedBox(0, 30),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 50.0.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("already_have_account".tr(context)),
                                InkWell(
                                  onTap: () {
                                    AppConstant.customNavigation(
                                        context, const SigninScreen(), 1, 0);
                                  },
                                  child: Text(
                                    "sign_in".tr(context),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }
}

class ContainerForCongratulationScreen extends StatelessWidget {
  const ContainerForCongratulationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.3,
      left: 0,
      right: 0,
      child: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(75.0.r),
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(top: 120.0.h, left: 80.0.w, right: 80.0.w),
              child: Column(
                children: [
                  Text(
                    "success".tr(context),
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 100.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  AppConstant.customSizedBox(0, 50),
                  Text(
                    "congratulations".tr(context),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 50.0.sp,
                        height: 1.5,
                        color: const Color.fromARGB(255, 100, 100, 100)),
                  ),
                  AppConstant.customSizedBox(0, 50),
                  ClipRRect(
                    child: Image.asset("assets/images/image_success.png"),
                  ),
                  AppConstant.customSizedBox(0, 50),
                  AppConstant.customElvatedButton(context, "go_shopping", () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const SectionsScreen()),
                      (Route route) => false,
                    );
                  })
                ],
              ),
            )),
      ),
    );
  }
}
