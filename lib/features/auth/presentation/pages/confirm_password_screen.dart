import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/auth/presentation/cubit/auth_cubit.dart';

class ConfirmPasswordScreen extends StatelessWidget {
  const ConfirmPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0.w),
        child: Column(
          children: [
            Text("Congratulations".tr(context),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
                textAlign: TextAlign.center),
            AppConstant.customSizedBox(0, 50),
            TextFormField(
              onChanged: (value) {
                context.read<AuthCubit>().changeNewPasswordForReset(value);
              },
              decoration: InputDecoration(
                labelText: "enter_new_password".tr(context),
                prefixIcon: const Icon(Icons.password),
              ),
            ),
            AppConstant.customSizedBox(0, 30),
            TextFormField(
              onChanged: (value) {
                context
                    .read<AuthCubit>()
                    .changeConfirmNewPasswordForReset(value);
              },
              decoration: InputDecoration(
                labelText: "enter_new_confirm_password".tr(context),
                prefixIcon: const Icon(Icons.password),
              ),
            ),
            AppConstant.customSizedBox(0, 50),
            AppConstant.customElvatedButton(context, "save_changes", () {
              context.read<AuthCubit>().resetPassword(context);
            })
          ],
        ),
      ),
    );
  }
}
