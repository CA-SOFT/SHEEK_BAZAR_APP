import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/user/profile/presentation/widgets/profile_widgets.dart';

class MyAccountScreen extends StatelessWidget {
  final bool fromSupplier;
  const MyAccountScreen({super.key, required this.fromSupplier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppConstant.customAppbar(
          context,
          Text(
            "my_account".tr(context),
            style: TextStyle(fontSize: 50.sp),
          ),
          [],
          true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 75.h),
        child: SingleChildScrollView(
            child: MyAccountInfo(fromSupplier: fromSupplier)),
      ),
    );
  }
}
