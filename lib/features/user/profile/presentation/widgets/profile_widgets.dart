// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, use_super_parameters

// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
import 'package:sheek_bazar/core/utils/app_colors.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/core/utils/cache_helper.dart';
import 'package:sheek_bazar/features/user/cart/presentation/pages/my_address.dart';
import 'package:sheek_bazar/features/user/profile/presentation/cubit/profile_cubit.dart';
import 'package:sheek_bazar/features/user/profile/presentation/pages/followers_screen.dart';
import 'package:sheek_bazar/features/user/profile/presentation/pages/my_account_screen.dart';
import 'package:sheek_bazar/features/user/profile/presentation/pages/my_favorite_screen.dart';
import 'package:sheek_bazar/features/user/profile/presentation/pages/my_points_screen.dart';
import 'package:sheek_bazar/features/user/shops/presentation/pages/shopDetails_screen.dart';

import '../pages/my_orders_screen.dart';

class ProfileImage extends StatefulWidget {
  bool fromSupplier;
  ProfileImage({Key? key, this.fromSupplier = false}) : super(key: key);
  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  String? userNameValue;
  String? referralCode;
  @override
  void initState() {
    super.initState();
    setState(() {
      userNameValue = CacheHelper.getData(key: "USER_NAME");
      referralCode = CacheHelper.getData(key: "REFERRAL_CODE");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 250.w,
                height: 250.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(250.sp),
                    image: DecorationImage(
                      image: const AssetImage(
                        'assets/images/profile_avatar.jpg',
                      ),
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) => {},
                    )),
              ),
              AppConstant.customSizedBox(50, 0),
              userNameValue == null
                  ? const SizedBox()
                  : BlocBuilder<ThemesCubit, ThemesState>(
                      builder: (context, theme) {
                        return RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Hi'.tr(context),
                                style: TextStyle(
                                    color: theme.mode == "dark"
                                        ? AppColors.whiteColor
                                        : AppColors.primaryColor,
                                    fontSize: 75.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: " $userNameValue",
                                style: TextStyle(
                                    color: theme.mode == "dark"
                                        ? AppColors.whiteColor
                                        : AppColors.primaryColor,
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ],
          ),
          widget.fromSupplier
              ? const SizedBox()
              : BlocBuilder<ThemesCubit, ThemesState>(
                  builder: (context, theme) {
                    return BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 20.h, left: 20.w),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Clipboard.setData(
                                          ClipboardData(text: referralCode!));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'text_copy'.tr(context),
                                            style: TextStyle(fontSize: 40.sp),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("referral_code".tr(context),
                                            style: TextStyle(
                                                color: theme.mode == "dark"
                                                    ? AppColors.whiteColor
                                                    : AppColors.primaryColor,
                                                fontSize: 50.sp,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                          referralCode ?? "",
                                          style: TextStyle(
                                              color: theme.mode == "dark"
                                                  ? AppColors.whiteColor
                                                  : AppColors.primaryColor,
                                              fontSize: 50.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            state.profileInfo == null
                                ? const SizedBox()
                                : Padding(
                                    padding:
                                        EdgeInsets.only(top: 20.h, right: 20.w),
                                    child: Text(
                                      "${"my_points".tr(context)} \n ${state.profileInfo![0].myPoints}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: theme.mode == "dark"
                                              ? AppColors.whiteColor
                                              : AppColors.primaryColor,
                                          fontSize: 50.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                          ],
                        );
                      },
                    );
                  },
                ),
          // AppConstant.customSizedBox(0, 30),
          // BlocBuilder<ThemesCubit, ThemesState>(
          //   builder: (context, theme) {
          //     return Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         InkWell(
          //           onTap: () {
          //             AppConstant.customNavigation(
          //                 context, const MyPointsScreen(), -1, 0);
          //           },
          //           child: Container(
          //             width: 400.w,
          //             padding: EdgeInsets.symmetric(
          //                 horizontal: 50.w, vertical: 25.h),
          //             margin: EdgeInsets.symmetric(horizontal: 10.w),
          //             decoration: BoxDecoration(
          //               color: theme.mode == "dark"
          //                   ? Colors.yellow[600]
          //                   : AppColors.whiteColor,
          //               borderRadius: BorderRadius.circular(10.0.sp),
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.grey.withOpacity(0.2),
          //                   offset: const Offset(2.0, 2.0),
          //                   blurRadius: 8.0,
          //                 ),
          //               ],
          //             ),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Column(
          //                   children: [
          //                     Text(
          //                       "my_points".tr(context),
          //                       style: TextStyle(
          //                           fontWeight: FontWeight.bold,
          //                           fontSize: 45.sp),
          //                     ),
          //                     AppConstant.customSizedBox(0, 20),
          //                     Text("1765",
          //                         style: TextStyle(
          //                             fontWeight: FontWeight.bold,
          //                             fontSize: 50.sp))
          //                   ],
          //                 ),
          //                 AppConstant.customSizedBox(25, 0),
          //                 const Icon(Icons.arrow_forward_ios)
          //               ],
          //             ),
          //           ),
          //         ),
          //       ],
          //     );
          //   },
          // ),
          AppConstant.customSizedBox(0, 25),
          const Divider(),
        ],
      ),
    );
  }
}

class MyAccountInfo extends StatefulWidget {
  final bool fromSupplier;
  const MyAccountInfo({super.key, required this.fromSupplier});

  @override
  State<MyAccountInfo> createState() => _MyAccountInfoState();
}

class _MyAccountInfoState extends State<MyAccountInfo> {
  String? userNameValue, phoneNumberValue, passwordValue;
  Future<void> getData() async {
    setState(() {
      userNameValue = CacheHelper.getData(key: "USER_NAME");
      phoneNumberValue = CacheHelper.getData(key: "USER_PHONENUMBER");
      passwordValue = CacheHelper.getData(key: "USER_PASSWORD");
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void deactivate() {
    super.deactivate();
    context.read<ProfileCubit>().clearMyInfo();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemesCubit, ThemesState>(
      builder: (context, theme) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.0.sp),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "my_account".tr(context),
                    style:
                        TextStyle(fontSize: 50.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              AppConstant.customSizedBox(0, 50),
              TextFormFieldForProfile(
                hint: "user_name",
                initialValue: userNameValue,
                icon: Icon(
                  Icons.person,
                  color: theme.mode == "dark"
                      ? AppColors.whiteColor
                      : AppColors.primaryColor,
                ),
                onChange: (String value) {
                  context.read<ProfileCubit>().onUserNameChange(value);
                },
              ),
              AppConstant.customSizedBox(0, 30),
              TextFormFieldForProfile(
                initialValue: phoneNumberValue,
                hint: "Enter_phone_number",
                icon: Icon(Icons.phone,
                    color: theme.mode == "dark"
                        ? AppColors.whiteColor
                        : AppColors.primaryColor),
                onChange: (String value) {
                  context.read<ProfileCubit>().onPhoneNumberChange(value);
                },
              ),
              AppConstant.customSizedBox(0, 30),
              TextFormFieldForProfile(
                initialValue: passwordValue,
                hint: "password",
                icon: Icon(Icons.password,
                    color: theme.mode == "dark"
                        ? AppColors.whiteColor
                        : AppColors.primaryColor),
                onChange: (String value) {
                  context.read<ProfileCubit>().onPasswordChange(value);
                },
              ),
              AppConstant.customSizedBox(0, 100),
              AppConstant.customElvatedButton(context, "save_changes", () {
                context.read<ProfileCubit>().updateProfile(
                    context,
                    userNameValue!,
                    passwordValue!,
                    phoneNumberValue!,
                    widget.fromSupplier);
              }),
              AppConstant.customSizedBox(0, 50),
              const Divider(),
              AppConstant.customSizedBox(0, 50),
            ],
          ),
        );
      },
    );
  }
}

class TextFormFieldForProfile extends StatelessWidget {
  String hint;
  String? initialValue;
  Icon icon;
  Function onChange;
  TextFormFieldForProfile(
      {super.key,
      required this.hint,
      required this.icon,
      required this.initialValue,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        labelStyle: const TextStyle(color: Colors.black),
        prefixIconColor: Colors.black,
        labelText: hint.tr(context),
        prefixIcon: icon,
      ),
      onChanged: (value) {
        onChange(value);
      },
    );
  }
}

class InformationDetails extends StatelessWidget {
  bool fromSupplier;
  String? supplierId;
  InformationDetails({super.key, this.fromSupplier = false, this.supplierId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0.sp),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "information_details".tr(context),
                style: TextStyle(fontSize: 50.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          AppConstant.customSizedBox(0, 50.0),
          InkWell(
            onTap: () {
              AppConstant.customNavigation(
                  context, MyAccountScreen(fromSupplier: fromSupplier), 0, -1);
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "my_account".tr(context),
                      style: TextStyle(
                        fontSize: 50.sp,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 75.sp,
                    ),
                  ],
                ),
                const Divider(),
              ],
            ),
          ),
          AppConstant.customSizedBox(0, 50.0),
          fromSupplier
              ? const SizedBox()
              : InkWell(
                  onTap: () {
                    AppConstant.customNavigation(
                        context, const MyOrdersScreen(), 0, -1);
                  },
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "my_orders".tr(context),
                            style: TextStyle(
                              fontSize: 50.sp,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 75.sp,
                          ),
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
                ),
          AppConstant.customSizedBox(0, 50.0),
          fromSupplier
              ? InkWell(
                  onTap: () {
                    AppConstant.customNavigation(
                        context,
                        ShopDetailsScreen(
                          supplierId: supplierId!,
                          fromSupllier: fromSupplier,
                        ),
                        0,
                        -1);
                  },
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "shop_information".tr(context),
                            style: TextStyle(
                              fontSize: 50.sp,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 75.sp,
                          ),
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
                )
              : const SizedBox(),
          fromSupplier ? AppConstant.customSizedBox(0, 50.0) : const SizedBox(),
          fromSupplier
              ? const SizedBox()
              : InkWell(
                  onTap: () {
                    AppConstant.customNavigation(
                        context, const MyPointsScreen(), 0, -1);
                  },
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "my_points".tr(context),
                            style: TextStyle(
                              fontSize: 50.sp,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 75.sp,
                          ),
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
                ),
          AppConstant.customSizedBox(0, 50.0),
          fromSupplier
              ? const SizedBox()
              : InkWell(
                  onTap: () {
                    AppConstant.customNavigation(
                        context, const FollwersScreen(), 0, -1);
                  },
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "followers_by_me".tr(context),
                            style: TextStyle(
                              fontSize: 50.sp,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 75.sp,
                          ),
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
                ),
          AppConstant.customSizedBox(0, 50.0),
          fromSupplier
              ? const SizedBox()
              : InkWell(
                  onTap: () {
                    AppConstant.customNavigation(
                        context, MyAddressScreen(fromProfile: true), 0, -1);
                  },
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Shipping_address".tr(context),
                            style: TextStyle(
                              fontSize: 50.sp,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 75.sp,
                          ),
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
                ),
          AppConstant.customSizedBox(0, 50.0),
          fromSupplier
              ? const SizedBox()
              : InkWell(
                  onTap: () {
                    AppConstant.customNavigation(
                        context, const FavoriteScreen(), 0, -1);
                  },
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "favorite".tr(context),
                            style: TextStyle(
                              fontSize: 50.sp,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 75.sp,
                          ),
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
                ),
          AppConstant.customSizedBox(0, 50.0),
          SizedBox(
            height: 175.h,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(75.r),
              child: BlocBuilder<ThemesCubit, ThemesState>(
                builder: (context, theme) {
                  return ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'are_you_sure'.tr(context),
                              ),
                              actions: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: theme.mode == "dark"
                                          ? Colors.white
                                          : Colors.black),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('close'.tr(context)),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                  onPressed: () {
                                    context
                                        .read<ProfileCubit>()
                                        .deletePRofile(context);
                                  },
                                  child: Text('delete'.tr(context)),
                                ),
                              ],
                            );
                          },
                        );
                        // AwesomeDialog(
                        //   context: context,
                        //   animType: AnimType.scale,
                        //   dialogType: DialogType.info,
                        //   body: Center(
                        //     child: Text(
                        //       'are_you_sure'.tr(context),
                        //       style: const TextStyle(fontStyle: FontStyle.italic),
                        //     ),
                        //   ),
                        //   title: 'This is Ignored',
                        //   desc: 'This is also Ignored',
                        //   btnOkOnPress: () {
                        //     context.read<ProfileCubit>().deletePRofile(context);
                        //   },
                        // ).show();
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          Colors.red,
                        ),
                      ),
                      child: Text(
                        "delete_account".tr(context),
                        style: TextStyle(
                            color: AppColors.whiteColor, fontSize: 50.sp),
                      ));
                },
              ),
            ),
          ),
          AppConstant.customSizedBox(0, 100.0),
        ],
      ),
    );
  }
}
