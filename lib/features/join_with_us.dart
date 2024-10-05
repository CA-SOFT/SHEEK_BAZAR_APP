import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';

import 'auth/presentation/pages/sign_in.dart';

class JoinWithUsScreen extends StatelessWidget {
  const JoinWithUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppConstant.customAppbar(context, const Text(""), [], true),
      body: Center(
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
              child: AppConstant.customElvatedButton(context, "sign_in", () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const SigninScreen()),
                  (Route route) => false,
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
