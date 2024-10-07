import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
import 'package:sheek_bazar/core/utils/app_colors.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/auth/presentation/pages/sign_in.dart';
import '../../Locale/cubit/locale_cubit.dart';
import 'content_model.dart';

class Onbording extends StatefulWidget {
  const Onbording({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocaleCubit, ChangeLocaleState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: contents.length,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (_, i) {
                    return SingleChildScrollView(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              AppConstant.customAssetImage(
                                  imagePath: contents[i].image,
                                  fit: BoxFit.fill,
                                  height: 0.57.sh,
                                  width: 1.sw),
                              SizedBox(
                                height: 75.h,
                              ),
                              Text(
                                contents[i].title.tr(context),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: state.locale.languageCode == "en"
                                      ? 100.sp
                                      : 75.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 30.h),
                              Text(
                                contents[i].discription.tr(context),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: state.locale.languageCode == "en"
                                      ? 50.sp
                                      : 40.sp,
                                ),
                              ),
                              SizedBox(
                                height: 75.h,
                              ),
                              currentIndex == contents.length - 1
                                  ? Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 40.0.w),
                                      height: 150.h,
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      const SigninScreen(),
                                                ),
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all<
                                                      Color>(
                                                AppColors.primaryColor,
                                              ),
                                            ),
                                            child: Text(
                                              "Get_Started".tr(context),
                                              style: const TextStyle(
                                                  color: AppColors.whiteColor),
                                            )),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        currentIndex > 0
                                            ? SizedBox(
                                                width: 0.4.sw,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: 100.h,
                                                      width: 250.w,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  25.0.r),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  25.0.r),
                                                        ),
                                                        child: ElevatedButton(
                                                            onPressed: () {
                                                              _controller
                                                                  .previousPage(
                                                                duration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            100),
                                                                curve: Curves
                                                                    .bounceIn,
                                                              );
                                                            },
                                                            style: ButtonStyle(
                                                              elevation:
                                                                  WidgetStateProperty
                                                                      .all(0.0),
                                                              backgroundColor:
                                                                  WidgetStateProperty
                                                                      .all<
                                                                          Color>(
                                                                AppColors
                                                                    .whiteColor,
                                                              ),
                                                            ),
                                                            child: Text(
                                                              "Back"
                                                                  .tr(context),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      40.sp,
                                                                  color: AppColors
                                                                      .greyColor),
                                                            )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : currentIndex != 0
                                                ? const SizedBox()
                                                : Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 40.0.w),
                                                    child: BlocBuilder<
                                                        ThemesCubit,
                                                        ThemesState>(
                                                      builder:
                                                          (context, theme) {
                                                        return Row(
                                                          children: [
                                                            BlocBuilder<
                                                                LocaleCubit,
                                                                ChangeLocaleState>(
                                                              builder: (context,
                                                                  state) {
                                                                return DropdownButton<
                                                                        String>(
                                                                    dropdownColor: theme.mode ==
                                                                            "dark"
                                                                        ? AppColors
                                                                            .primaryColor
                                                                        : Colors
                                                                            .white,
                                                                    value: state
                                                                        .locale
                                                                        .languageCode,
                                                                    items: [
                                                                      'ar',
                                                                      'en',
                                                                      'ku'
                                                                    ].map((String
                                                                        items) {
                                                                      return DropdownMenuItem<
                                                                          String>(
                                                                        value:
                                                                            items,
                                                                        child: Text(
                                                                            items),
                                                                      );
                                                                    }).toList(),
                                                                    onChanged:
                                                                        (String?
                                                                            newValue) {
                                                                      if (newValue !=
                                                                          null) {
                                                                        context
                                                                            .read<LocaleCubit>()
                                                                            .changeLanguage(newValue);
                                                                      }
                                                                    });
                                                              },
                                                            )
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(
                                            contents.length,
                                            (index) => buildDot(index, context),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          child: BlocBuilder<LocaleCubit,
                                              ChangeLocaleState>(
                                            builder: (context, state) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  SizedBox(
                                                    height: 125.h,
                                                    width: 275.w,
                                                    child: ElevatedButton(
                                                        onPressed: () {
                                                          _controller.nextPage(
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        100),
                                                            curve:
                                                                Curves.bounceIn,
                                                          );
                                                        },
                                                        // style: ButtonStyle(

                                                        // ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              AppColors
                                                                  .primaryColor,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: state.locale.languageCode == 'en'
                                                                    ? Radius.circular(
                                                                        75.0.r)
                                                                    : Radius.circular(
                                                                        0.0.r),
                                                                bottomLeft: state.locale.languageCode == 'en'
                                                                    ? Radius.circular(
                                                                        75.0.r)
                                                                    : Radius.circular(
                                                                        0.0.r),
                                                                bottomRight: state.locale.languageCode == 'en'
                                                                    ? Radius.circular(
                                                                        0.0.r)
                                                                    : Radius.circular(
                                                                        75.0.r),
                                                                topRight: state.locale.languageCode ==
                                                                        'en'
                                                                    ? const Radius.circular(0.0)
                                                                    : const Radius.circular(25.0)),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          "Next".tr(context),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        )),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                          SafeArea(
                              child: Padding(
                            padding: EdgeInsets.all(15.0.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  'assets/images/icon.png',
                                  width: 125.w,
                                  height: 125.w,
                                ),
                                SizedBox(
                                  width: 225.w,
                                  height: 100.h,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const SigninScreen(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: AppColors.primaryColor,
                                      backgroundColor: AppColors.whiteColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                    ),
                                    child: Text(
                                      'skip'.tr(context),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30.sp),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ))
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 25.h,
      width: currentIndex == index ? 70.w : 40.w,
      margin: EdgeInsets.only(right: 5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: currentIndex == index
            ? AppColors.primaryColor
            : AppColors.greyColor,
      ),
    );
  }
}
