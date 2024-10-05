import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';

import '../widgets/auth_widgets.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          height: 1.sh,
          child: Stack(
            children: [
              ClipRRect(
                child: AppConstant.customAssetImage(
                    imagePath: "assets/images/sign_up.png",
                    fit: BoxFit.fill,
                    height: 1.sh,
                    width: 1.sw),
              ),
              const FormContainerForSignIn(),
              const FloationgIcon(),
            ],
          ),
        ),
      ),
    );
  }
}
