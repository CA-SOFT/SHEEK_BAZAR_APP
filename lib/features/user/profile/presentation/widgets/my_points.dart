// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
import 'package:sheek_bazar/core/utils/app_colors.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/user/profile/data/models/points_model.dart';
import 'package:sheek_bazar/features/user/profile/presentation/cubit/profile_cubit.dart';

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({super.key});

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  Duration duration = const Duration();
  Timer? timer;
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemesCubit, ThemesState>(
      builder: (context, theme) {
        return BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return Container(
                width: 0.9.sw,
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 25.h),
                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 50.h),
                decoration: BoxDecoration(
                  color: theme.mode == "dark"
                      ? AppColors.primaryColor
                      : AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(10.0.sp),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: const Offset(2.0, 2.0),
                      blurRadius: 8.0,
                    ),
                  ],
                ),
                child: state.showCollectPointButton
                    ? state.loadingCollectPoints
                        ? AppConstant.customLoadingElvatedButton(context)
                        : AppConstant.customElvatedButton(
                            context, "get_100_points", () {
                            context.read<ProfileCubit>().collectPoints(context);
                          })
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "get_point".tr(context),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 50.sp),
                          ),
                          state.newDate == null
                              ? const SizedBox()
                              : TimerCountdown(
                                  format:
                                      CountDownTimerFormat.hoursMinutesSeconds,
                                  colonsTextStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 100.sp),
                                  timeTextStyle: TextStyle(
                                      fontSize: 100.sp,
                                      fontWeight: FontWeight.bold),
                                  endTime: DateTime.now().add(
                                    Duration(
                                      hours: state.newDate!.inHours,
                                      minutes: state.newDate!.inMinutes -
                                          state.newDate!.inHours * 60,
                                      seconds: state.newDate!.inSeconds -
                                          state.newDate!.inMinutes * 60,
                                    ),
                                  ),
                                  onEnd: () {
                                    if (i == 0) {
                                      context
                                          .read<ProfileCubit>()
                                          .changeShowCollectPointButton(true);
                                      i++;
                                    }
                                  },
                                ),
                        ],
                      ));
          },
        );
      },
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemesCubit, ThemesState>(
      builder: (context, theme) {
        return BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: 0.9.sw,
                    padding:
                        EdgeInsets.symmetric(horizontal: 50.w, vertical: 25.h),
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      color: theme.mode == "dark"
                          ? AppColors.primaryColor
                          : AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(10.0.sp),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          offset: const Offset(2.0, 2.0),
                          blurRadius: 8.0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
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
                            AppConstant.customSizedBox(25, 0),
                            Column(
                              children: [
                                Text(
                                  state.customerInfo!.customerName ?? "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(state.customerInfo!.customerPhone ?? "",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold))
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text("my_points".tr(context),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            Text(state.customerInfo!.points ?? "",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))
                          ],
                        )
                      ],
                    )),
              ],
            );
          },
        );
      },
    );
  }
}

class LastActivity extends StatelessWidget {
  const LastActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemesCubit, ThemesState>(
      builder: (context, theme) {
        return Flexible(
          child: SingleChildScrollView(
            child: Container(
              width: 0.9.sw,
              padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 25.h),
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 50.h),
              decoration: BoxDecoration(
                color: theme.mode == "dark"
                    ? AppColors.primaryColor
                    : AppColors.whiteColor,
                borderRadius: BorderRadius.circular(10.0.sp),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(2.0, 2.0),
                    blurRadius: 8.0,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "last_activity".tr(context),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
                  ),
                  AppConstant.customSizedBox(0, 20),
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      return state.pointsActivities == null
                          ? const SizedBox()
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.pointsActivities!.length,
                              itemBuilder: (context, index) {
                                return OneActivity(
                                  activity: state.pointsActivities![index],
                                );
                              },
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class OneActivity extends StatelessWidget {
  Activities activity;
  OneActivity({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemesCubit, ThemesState>(
      builder: (context, theme) {
        return Container(
          width: 0.7.sw,
          padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 25.h),
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 50.h),
          decoration: BoxDecoration(
            color:
                theme.mode == "dark" ? Colors.grey[900] : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10.0.sp),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                offset: const Offset(2.0, 2.0),
                blurRadius: 8.0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity.type == "daily"
                        ? "Earn_free_points".tr(context)
                        : activity.type == "order"
                            ? "Buy_products".tr(context)
                            : activity.type == "returned"
                                ? "Order payment returned".tr(context)
                                : activity.type == "referral"
                                    ? "Invite_a_friend".tr(context)
                                    : activity.type == "pay"
                                        ? "Pay_with_points".tr(context)
                                        : "",
                    style:
                        TextStyle(fontSize: 35.sp, fontWeight: FontWeight.bold),
                  ),
                  AppConstant.customSizedBox(0, 25),
                  Text(
                    "${"date".tr(context)} : ${activity.createdAt}",
                    style:
                        TextStyle(fontSize: 35.sp, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Text(
                activity.type == "pay"
                    ? "${"You_spend".tr(context)} : \n ${activity.points} ${"points".tr(context)}"
                    : "${"You_Earned".tr(context)} : \n +${activity.points} ${"points".tr(context)}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: activity.type == "pay" ? Colors.red : Colors.green,
                    fontSize: 35.sp,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }
}
