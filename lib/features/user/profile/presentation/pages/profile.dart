import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/Locale/cubit/locale_cubit.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/user/profile/presentation/cubit/profile_cubit.dart';
import 'package:sheek_bazar/features/user/profile/presentation/widgets/profile_widgets.dart';

import '../../../../../core/utils/cache_helper.dart';
import '../../../../auth/presentation/pages/sign_in.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userId;

  Future<void> fetchData() async {
    setState(() {
      userId = CacheHelper.getData(key: "USER_ID");
    });
    if (userId != null) {
      context.read<ProfileCubit>().getUserInfo(context);
    }
  }

  @override
  void initState() {
    super.initState();
    // context.read<ProfileCubit>().changeShowCollectPointButton(false);
    fetchData();
  }

  Future refresh() async {
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, ChangeLocaleState>(
      builder: (context, state) {
        return Scaffold(
          drawer: AppConstant.customDrawer(context,
              isGuest: userId == null ? true : false),
          appBar: AppConstant.customAppbar(
              context,
              Text(
                "profile".tr(context),
                style: TextStyle(fontSize: 50.sp),
              ),
              [],
              false),
          body: userId == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/join_with_us.png"),
                      Text(
                        "log_in_to_enjoy_these_benefits".tr(context),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      AppConstant.customSizedBox(0, 50),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.w),
                        child: AppConstant.customElvatedButton(
                            context, "sign_in", () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const SigninScreen()),
                            (Route route) => false,
                          );
                        }),
                      )
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: refresh,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: Column(
                        children: [
                          ProfileImage()
                              .animate()
                              .fade(duration: 500.ms)
                              .scale(delay: 500.ms),
                          AppConstant.customSizedBox(0, 30),
                          InformationDetails()
                              .animate()
                              .fade(duration: 500.ms)
                              .scale(delay: 500.ms),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
