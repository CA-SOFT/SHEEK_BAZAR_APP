// ignore_for_file: must_be_immutable, use_build_context_synchronously, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
import 'package:sheek_bazar/core/utils/cache_helper.dart';
import 'package:sheek_bazar/features/user/cart/presentation/cubit/cart_cubit.dart';
import 'package:sheek_bazar/features/user/cart/presentation/pages/add_address_screen.dart';
import 'package:sheek_bazar/features/user/cart/presentation/pages/check_out.dart';

import '../../../../../Locale/cubit/locale_cubit.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_constants.dart';

class AddressCard extends StatefulWidget {
  bool fromProfile;
  String provinceName,
      addressTitle,
      addressNotes,
      addressPhone,
      addressId,
      lat,
      log;
  AddressCard({
    super.key,
    required this.provinceName,
    this.fromProfile = false,
    required this.addressTitle,
    required this.addressNotes,
    required this.addressPhone,
    required this.lat,
    required this.log,
    required this.addressId,
  });

  @override
  State<AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  String? Id;
  Future<void> giveValueForId() async {
    setState(() {
      Id = CacheHelper.getData(key: "ADDRESS_ID");
    });
  }

  @override
  void initState() {
    super.initState();
    giveValueForId();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemesCubit, ThemesState>(
      builder: (context, theme) {
        return Stack(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 50.0.w, vertical: 30.0.h),
              child: Container(
                height: 500.0.h,
                width: 0.8.sw,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: theme.mode == "dark"
                            ? AppColors.whiteColor
                            : AppColors.primaryColor,
                        width: 5.0.sp),
                    borderRadius: BorderRadius.circular(40.0.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(
                            1.0), // Adjust opacity for subtle effect
                        offset: const Offset(2.0,
                            2.0), // Adjust offset for direction and distance
                        blurRadius: 10.0, // Adjust blur radius for softness
                      ),
                    ],
                    color: theme.mode == "dark"
                        ? AppColors.primaryColor
                        : AppColors.whiteColor),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 100.w, vertical: 50.0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.provinceName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 50.sp),
                          ),
                          PopupMenuButton<String>(
                            child: Text(
                              "...",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 50.sp),
                            ),
                            onSelected: (value) {
                              if (value == "delete") {
                                context
                                    .read<CartCubit>()
                                    .deleteAddress(context, widget.addressId);
                              } else {
                                AppConstant.customNavigation(
                                    context,
                                    AddAdressScreen(
                                        update: true,
                                        lat: widget.lat,
                                        log: widget.log,
                                        title: widget.addressTitle,
                                        notes: widget.addressNotes,
                                        phoneNumber: widget.addressPhone,
                                        provinceName: widget.provinceName,
                                        addressId: widget.addressId),
                                    -1,
                                    0);
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: "edit",
                                child: Text("edit".tr(context)),
                              ),
                              PopupMenuItem(
                                value: "delete",
                                child: Text("delete".tr(context)),
                              ),
                            ],
                          )
                        ],
                      ),
                      AppConstant.customSizedBox(0, 20),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.addressTitle,
                            style: TextStyle(
                                height: 1.5,
                                fontSize: widget.addressTitle.length > 80
                                    ? 30.sp
                                    : 35.0.sp),
                          ),
                          Text(
                            widget.addressNotes,
                            style: TextStyle(height: 1.5, fontSize: 35.0.sp),
                          ),
                        ],
                      )),
                      AppConstant.customSizedBox(0, 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.addressPhone,
                            style: TextStyle(fontSize: 35.0.sp),
                          ),
                          Id == widget.addressId
                              ? SizedBox(
                                  height: 80.h,
                                  width: 250.w,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(75.r),
                                      child: Container(
                                          color: AppColors.greyColor,
                                          child: Center(
                                            child: Text(
                                              "default".tr(context),
                                              style: TextStyle(
                                                  fontSize: 25.sp,
                                                  color:
                                                      AppColors.primaryColor),
                                            ),
                                          ))),
                                )
                              : SizedBox(
                                  height: 80.h,
                                  width: 250.w,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(75.r),
                                    child: BlocBuilder<CartCubit, CartState>(
                                      builder: (context, state) {
                                        return ElevatedButton(
                                            onPressed: () async {
                                              await CacheHelper.saveData(
                                                key: "ADDRESS_ID",
                                                value: widget.addressId,
                                              );
                                              if (widget.fromProfile == true) {
                                                Navigator.pop(context);
                                              } else {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CheckOutScreen(
                                                              fromLaundry: state
                                                                      .fromLaundry ??
                                                                  false,
                                                            )));
                                              }
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all<
                                                      Color>(
                                                theme.mode == "dark"
                                                    ? AppColors.whiteColor
                                                    : AppColors.primaryColor,
                                              ),
                                            ),
                                            child: Text(
                                              "set_default".tr(context),
                                              style: TextStyle(
                                                  color: theme.mode == "dark"
                                                      ? AppColors.primaryColor
                                                      : AppColors.whiteColor,
                                                  fontSize: 20.sp),
                                            ));
                                      },
                                    ),
                                  ),
                                )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            BlocBuilder<LocaleCubit, ChangeLocaleState>(
              builder: (context, state) {
                return Positioned(
                  top: 75.0.h,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.primaryColor,
                          width: 5.0.sp), // Customize border here
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundColor: AppColors.whiteColor,
                      child: Icon(
                        Icons.storefront_outlined,
                        size: 50.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class Billwidget extends StatelessWidget {
  const Billwidget({super.key});

  @override
  Widget build(BuildContext context) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc(Match match) => '${match[1]},';
    return SizedBox(
      width: 0.75.sw,
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "sub_total".tr(context),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 60.sp),
                  ),
                  Text(
                    " ${state.subTotal!.toString().replaceAllMapped(reg, mathFunc)}  د.ع",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
                  )
                ],
              ),
              AppConstant.customSizedBox(0, 50.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "delivery_fees".tr(context),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 60.sp),
                  ),
                  Text(
                    state.Fees == null
                        ? "0 د.ع"
                        : state.Fees!.isEmpty
                            ? "0 د.ع"
                            : " ${state.Fees!.toString().replaceAllMapped(reg, mathFunc)} د.ع",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
                  )
                ],
              ),
              AppConstant.customSizedBox(0, 25.0),
              const Divider(),
              AppConstant.customSizedBox(0, 25.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "total".tr(context),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 60.sp),
                  ),
                  Text(
                    state.Fees != "" && state.subTotal != null
                        ? "${(double.parse(state.Fees!) + double.parse(state.subTotal!.toString())).toString().replaceAllMapped(reg, mathFunc)} د.ع"
                        : state.Fees != null
                            ? state.subTotal!
                                .toString()
                                .replaceAllMapped(reg, mathFunc)
                            : state.Fees!,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
                  )
                ],
              ),
              AppConstant.customSizedBox(0, 50.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${"Points Earned".tr(context)} :",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 60.sp),
                  ),
                  Text(
                    "${state.earnedPoints ?? ""}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class MapCard extends StatelessWidget {
  var lat, long;
  MapCard({super.key, required this.lat, required this.long});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColor, width: 5.0.sp),
          borderRadius: BorderRadius.circular(40.0.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(1.0),
              offset: const Offset(2.0, 2.0),
              blurRadius: 10.0,
            ),
          ],
          color: AppColors.whiteColor),
      height: 500.0.h,
      width: 0.8.sw,
      child: FlutterMap(
        options: MapOptions(
          initialZoom: 15,
          initialCenter: LatLng(double.parse(lat), double.parse(long)),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 30.0,
                height: 30.0,
                point: LatLng(double.parse(lat), double.parse(long)),
                child: Icon(Icons.location_on,
                    size: 75.w, color: AppColors.primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
