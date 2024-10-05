import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/user/profile/presentation/cubit/profile_cubit.dart';
import 'package:sheek_bazar/features/user/profile/presentation/widgets/my_points.dart';

class MyPointsScreen extends StatefulWidget {
  const MyPointsScreen({super.key});

  @override
  State<MyPointsScreen> createState() => _MyPointsScreenState();
}

class _MyPointsScreenState extends State<MyPointsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getPoints(context);
  }

  @override
  void deactivate() {
    super.deactivate();
    context.read<ProfileCubit>().clearDataForPoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppConstant.customAppbar(
          context,
          Text(
            "my_points".tr(context),
            style: TextStyle(fontSize: 50.sp),
          ),
          [],
          true),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return state.loadingPoints
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.all(30.sp),
                  child: Column(
                    children: [
                      const UserInfo(),
                      const CountDownTimer(),
                      const LastActivity(),
                      AppConstant.customSizedBox(0, 20),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
