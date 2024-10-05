// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/core/utils/app_colors.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class WhatsappConfirmScreen extends StatefulWidget {
  const WhatsappConfirmScreen({super.key});

  @override
  State<WhatsappConfirmScreen> createState() => _WhatsappConfirmScreenState();
}

class _WhatsappConfirmScreenState extends State<WhatsappConfirmScreen> {
  int? number;
  void generateRandomNumber() async {
    final random = Random();
    setState(() {
      number = 1000 + random.nextInt(9000);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
    context.read<AuthCubit>().changesendWhatsappUnsuccessfully();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(75.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "send_whatsapp".tr(context),
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            AppConstant.customSizedBox(0, 10),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return state.loading == true
                    ? AppConstant.customLoadingElvatedButton(context)
                    : AppConstant.customElvatedButton(context, "send",
                        () async {
                        print(state.phoneNumberForSignUp!);
                        context.read<AuthCubit>().changeLoadingState(true);
                        generateRandomNumber();
                        var headers = {
                          'Content-Type': 'application/x-www-form-urlencoded'
                        };
                        var request = http.Request(
                            'POST',
                            Uri.parse(
                                'https://api.ultramsg.com/instance91486/messages/chat'));
                        request.bodyFields = {
                          'token': 'lctsc6l0fo7hoz8l',
                          'to': state.phoneNumberForSignUp!,
                          'body': 'رمز التأكيد هو $number'
                        };
                        request.headers.addAll(headers);
                        http.StreamedResponse response = await request.send();
                        context.read<AuthCubit>().changeLoadingState(false);
                        if (response.statusCode == 200) {
                          print("Done");
                          context
                              .read<AuthCubit>()
                              .changesendWhatsappSuccessfully();
                        } else {
                          print("not done");

                          print(response.reasonPhrase);
                        }
                      });
              },
            ),
            AppConstant.customSizedBox(0, 50),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return state.sendWhatsappSuccessfully!
                    ? PinCodeTextField(
                        keyboardType: TextInputType.number,
                        appContext: context,
                        length: 4,
                        onChanged: (value) {},
                        onCompleted: (value) {
                          if (int.parse(value) == number) {
                            context.read<AuthCubit>().SignUp(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.primaryColor,
                                padding: EdgeInsets.only(
                                    bottom: 150.h,
                                    top: 50.h,
                                    left: 50.w,
                                    right: 50.w),
                                content: Text(
                                  'no_match_pin'.tr(context),
                                  style: const TextStyle(color: Colors.red),
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        textStyle: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 75.sp,
                            fontWeight: FontWeight.bold),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        enableActiveFill: true,
                        pinTheme: PinTheme(
                            disabledColor: Colors.white,
                            selectedFillColor: Colors.white,
                            activeFillColor: Colors.white,
                            inactiveFillColor: Colors.white,
                            fieldHeight: 275.h,
                            fieldWidth: 200.w,
                            shape: PinCodeFieldShape.box,
                            activeColor: AppColors.primaryColor,
                            inactiveColor: AppColors.primaryColor,
                            selectedColor: const Color.fromARGB(153, 0, 0, 0),
                            borderRadius: BorderRadius.circular(8.sp)),
                      )
                    : const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
