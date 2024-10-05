import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';

import '../widgets/auth_widgets.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              ClipRRect(
                child: AppConstant.customAssetImage(
                    imagePath: "assets/images/sign_up.png",
                    fit: BoxFit.fill,
                    height: 1.sh,
                    width: 1.sw),
              ),
              const FormContainerForSignUp(),
              const FloationgIcon(),
            ],
          ),
        ),
      ),
    );
  }
}
