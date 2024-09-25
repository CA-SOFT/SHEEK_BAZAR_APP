// ignore_for_file: curly_braces_in_flow_control_structures, must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/Locale/cubit/locale_cubit.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/core/utils/cache_helper.dart';
import 'package:sheek_bazar/features/user/cart/presentation/cubit/cart_cubit.dart';
import 'package:sheek_bazar/features/user/cart/presentation/pages/cart_screen.dart';
import 'package:sheek_bazar/features/user/cart/presentation/pages/my_address.dart';
import 'package:sheek_bazar/features/user/profile/presentation/cubit/profile_cubit.dart';
import 'package:sheek_bazar/sections_screen.dart';

import '../widgets/check_out_widgets.dart';

class CheckOutScreen extends StatefulWidget {
  final bool fromLaundry;
  const CheckOutScreen({super.key, required this.fromLaundry});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  String? addressId = "-1";
  String? deliveryFees;
  Future setValueForAddressId() async {
    setState(() {
      addressId = CacheHelper.getData(key: "ADDRESS_ID");
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getProvinces(context);
    context.read<CartCubit>().checkFromLaundry(widget.fromLaundry);
    setValueForAddressId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppConstant.customAppbar(
            context,
            Text(
              "check_out".tr(context),
              style: TextStyle(fontSize: 50.sp),
            ),
            [],
            true),
        bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(50.0.sp),
              child: state.loadingCheckOut
                  ? AppConstant.customLoadingElvatedButton(context)
                  : AppConstant.customElvatedButton(context, "check_out", () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            WayForPay(fromLaundry: widget.fromLaundry),
                      );
                    }),
            );
          },
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 40.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: 0.75.sw,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Shipping_address".tr(context),
                            style: TextStyle(
                                fontSize: 50.sp, fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                              onTap: () {
                                AppConstant.customNavigation(
                                    context, MyAddressScreen(), -1, 0);
                              },
                              child: Text(
                                "change".tr(context),
                                style: TextStyle(fontSize: 35.sp),
                              ))
                        ],
                      ),
                    ),
                    AppConstant.customSizedBox(0, 20.0),
                    BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        if (addressId == "-1") {
                          return Text("add_address".tr(context));
                        } else {
                          if (state.myAddress != null) if (state
                                  .myAddress!.customerAddresses !=
                              null) {
                            for (int i = 0;
                                i < state.myAddress!.customerAddresses!.length;
                                i++) {
                              if (state.myAddress!.customerAddresses![i]
                                      .addressId ==
                                  addressId) {
                                context.read<CartCubit>().onFeeschange(state
                                    .myAddress!
                                    .customerAddresses![i]
                                    .deliveryCost!);
                                return BlocBuilder<LocaleCubit,
                                    ChangeLocaleState>(
                                  builder: (context, value) {
                                    return Column(
                                      children: [
                                        AddressCard(
                                                provinceName: value.locale
                                                            .languageCode ==
                                                        "en"
                                                    ? state.myAddress!.customerAddresses![i].provinceNameEn ??
                                                        ""
                                                    : value.locale.languageCode ==
                                                            "ar"
                                                        ? state.myAddress!.customerAddresses![i].provinceNameAr ??
                                                            ""
                                                        : state.myAddress!.customerAddresses![i].provinceNameKu ??
                                                            "",
                                                addressTitle: state
                                                        .myAddress!
                                                        .customerAddresses![i]
                                                        .addressTitle ??
                                                    "",
                                                addressNotes: state
                                                        .myAddress!
                                                        .customerAddresses![i]
                                                        .addressNotes ??
                                                    "",
                                                addressPhone: state
                                                        .myAddress!
                                                        .customerAddresses![i]
                                                        .addressPhone ??
                                                    "",
                                                addressId: state
                                                    .myAddress!
                                                    .customerAddresses![i]
                                                    .addressId!,
                                                lat: state.myAddress!.customerAddresses![i].addressLatitude!,
                                                log: state.myAddress!.customerAddresses![i].addressLongitude!)
                                            .animate()
                                            .fade(duration: 500.ms)
                                            .scale(delay: 500.ms),
                                        AppConstant.customSizedBox(0, 30),
                                        state.myAddress!.customerAddresses![i]
                                                        .addressLatitude ==
                                                    null ||
                                                state
                                                        .myAddress!
                                                        .customerAddresses![i]
                                                        .addressLatitude ==
                                                    null
                                            ? const SizedBox()
                                            : MapCard(
                                                lat: state
                                                    .myAddress!
                                                    .customerAddresses![i]
                                                    .addressLatitude!,
                                                long: state
                                                    .myAddress!
                                                    .customerAddresses![i]
                                                    .addressLongitude!,
                                              )
                                                .animate()
                                                .fade(duration: 500.ms)
                                                .scale(delay: 500.ms),
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                          }
                        }
                        return const SizedBox();
                      },
                    ),
                    AppConstant.customSizedBox(0, 50.0),
                    const Billwidget()
                        .animate()
                        .fade(duration: 500.ms)
                        .scale(delay: 500.ms),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class WayForPay extends StatefulWidget {
  bool fromLaundry;
  WayForPay({super.key, required this.fromLaundry});

  @override
  State<WayForPay> createState() => _WayForPayState();
}

class _WayForPayState extends State<WayForPay> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<ThemesCubit, ThemesState>(
        builder: (context, theme) {
          return Container(
            width: 300.0,
            height: 200.0,
            decoration: BoxDecoration(
              color: theme.mode == "dark" ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Choose_payment_method'.tr(context),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  AppConstant.customSizedBox(0, 20),
                  SizedBox(
                    width: 300.0,
                    child: BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        return BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, value) {
                            return ElevatedButton(
                              onPressed: () async {
                                String? addresId = await CacheHelper.getData(
                                    key: "ADDRESS_ID");

                                if (addresId != null) {
                                  if (state.subTotal == 0 &&
                                      widget.fromLaundry == false) {
                                    await AppConstant.customAlert(
                                        context, "cart_is_empty",
                                        withTranslate: true);
                                  } else if (state.servicesArray == null &&
                                      widget.fromLaundry) {
                                    await AppConstant.customAlert(
                                        context, "Laundry order is empty",
                                        withTranslate: false);
                                  } else if (state.servicesArray == null &&
                                      widget.fromLaundry) {
                                    await AppConstant.customAlert(
                                        context, "Laundry order is empty",
                                        withTranslate: false);
                                  } else {
                                    if (value.profileInfo![0].myPoints
                                        is String) {
                                      if (double.parse(state.Fees ?? "0") +
                                              double.parse(
                                                  state.subTotal.toString()) <=
                                          double.parse(
                                              "${value.profileInfo![0].myPoints}")) {
                                        widget.fromLaundry
                                            ? context
                                                .read<CartCubit>()
                                                .ckeckoutForLaundry(
                                                    context, "1")
                                            : context
                                                .read<CartCubit>()
                                                .ckeckout(context, "1");
                                      } else {
                                        Navigator.pop(context);
                                        widget.fromLaundry
                                            ? Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const SectionsScreen(
                                                          number: 1,
                                                        )),
                                                (Route route) => false,
                                              )
                                            : Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        const CartScreen()));
                                        AppConstant.customAlert(context,
                                            "Sorry , you don't have enough points",
                                            withTranslate: true,
                                            witherror: true,
                                            second: 2);
                                      }
                                    } else {
                                      if (double.parse(state.Fees ?? "0") +
                                              double.parse(
                                                  state.subTotal.toString()) <=
                                          value.profileInfo![0].myPoints
                                              .toDouble()) {
                                        widget.fromLaundry
                                            ? context
                                                .read<CartCubit>()
                                                .ckeckoutForLaundry(
                                                    context, "1")
                                            : context
                                                .read<CartCubit>()
                                                .ckeckout(context, "1");
                                      } else {
                                        Navigator.pop(context);
                                        widget.fromLaundry
                                            ? Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const SectionsScreen(
                                                          number: 1,
                                                        )),
                                                (Route route) => false,
                                              )
                                            : Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        const CartScreen()));
                                        AppConstant.customAlert(context,
                                            "Sorry , you don't have enough points",
                                            withTranslate: true,
                                            witherror: true,
                                            second: 2);
                                      }
                                    }
                                  }
                                } else {
                                  await AppConstant.customAlert(
                                      context, "add_new_address",
                                      withTranslate: true);
                                }
                              }, // Close the popup
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.point_of_sale),
                                  AppConstant.customSizedBox(20, 0),
                                  Text('By_points'.tr(context)),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 300.0,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.fromLaundry
                            ? context
                                .read<CartCubit>()
                                .ckeckoutForLaundry(context, "0")
                            : context.read<CartCubit>().ckeckout(context, "0");
                        // Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.arrow_back_ios_new_outlined),
                          AppConstant.customSizedBox(20, 0),
                          Text('Paiement when recieving'.tr(context)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
