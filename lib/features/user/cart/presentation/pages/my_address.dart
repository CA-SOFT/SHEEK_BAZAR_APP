// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/Locale/cubit/locale_cubit.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/core/utils/cache_helper.dart';
import 'package:sheek_bazar/features/user/cart/presentation/cubit/cart_cubit.dart';
import 'package:sheek_bazar/features/user/cart/presentation/pages/add_address_screen.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../auth/presentation/pages/sign_in.dart';
import '../widgets/check_out_widgets.dart';

class MyAddressScreen extends StatefulWidget {
  bool fromProfile;
  MyAddressScreen({super.key, this.fromProfile = false});

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  String? userId;
  Future<void> fetchData() async {
    setState(() {
      userId = CacheHelper.getData(key: "USER_ID");
    });
    if (userId != null) {
      if (widget.fromProfile) {
        context.read<CartCubit>().getMyAdress(context);
        context.read<CartCubit>().getProvinces(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: userId == null
      //     ? null
      //     : Padding(
      //         padding: EdgeInsets.all(50.0.sp),
      //         child: AppConstant.customElvatedButton(context, "submit", () {}),
      //       ),
      appBar: AppConstant.customAppbar(
          context,
          Text(
            "my_address".tr(context),
            style: TextStyle(fontSize: 50.sp),
          ),
          userId == null
              ? []
              : [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: InkWell(
                      onTap: () {
                        AppConstant.customNavigation(
                            context, AddAdressScreen(), 0, -1);
                      },
                      child: Icon(
                        Icons.add,
                        size: 75.sp,
                      ),
                    ),
                  )
                ],
          true),
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
                    child:
                        AppConstant.customElvatedButton(context, "sign_in", () {
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
          : SingleChildScrollView(child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                return state.loadingMyAdress
                    ? SizedBox(
                        height: 0.5.sh,
                        child: const Center(
                            child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        )),
                      )
                    : state.myAddress == null
                        ? SizedBox(
                            height: 1.sh,
                            child: Center(
                              child: Column(
                                children: [
                                  Image.asset("assets/images/empty_data.png"),
                                  Text(
                                    "no_addresss".tr(context),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : state.myAddress!.customerAddresses == null
                            ? SizedBox(
                                height: 1.sh,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/empty_data.png",
                                      ),
                                      Text(
                                        "no_addresss".tr(context),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(horizontal: 50.w),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state
                                      .myAddress!.customerAddresses!.length,
                                  itemBuilder: (context, index) {
                                    return BlocBuilder<LocaleCubit,
                                        ChangeLocaleState>(
                                      builder: (context, value) {
                                        return AddressCard(
                                                fromProfile: widget.fromProfile,
                                                provinceName: value.locale.languageCode ==
                                                        "en"
                                                    ? state.myAddress!.customerAddresses![index].provinceNameEn ??
                                                        ""
                                                    : value.locale.languageCode ==
                                                            "ar"
                                                        ? state.myAddress!.customerAddresses![index].provinceNameAr ??
                                                            ""
                                                        : state.myAddress!.customerAddresses![index].provinceNameKu ??
                                                            "",
                                                addressTitle:
                                                    state.myAddress!.customerAddresses![index].addressTitle ??
                                                        "",
                                                addressNotes:
                                                    state.myAddress!.customerAddresses![index].addressNotes ??
                                                        "",
                                                addressPhone:
                                                    state.myAddress!.customerAddresses![index].addressPhone ??
                                                        "",
                                                addressId: state
                                                    .myAddress!
                                                    .customerAddresses![index]
                                                    .addressId!,
                                                lat: state
                                                    .myAddress!
                                                    .customerAddresses![index]
                                                    .addressLatitude!,
                                                log: state
                                                    .myAddress!
                                                    .customerAddresses![index]
                                                    .addressLongitude!)
                                            .animate()
                                            .fade(duration: 500.ms)
                                            .scale(delay: 500.ms);
                                      },
                                    );
                                  },
                                ),
                              );
              },
            )),
    );
  }
}
