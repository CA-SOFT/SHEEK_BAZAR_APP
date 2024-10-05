// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/Locale/cubit/locale_cubit.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/user/cart/presentation/cubit/cart_cubit.dart';
import '../../../../../core/utils/app_colors.dart';
import '../widgets/add_address_widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class AddAdressScreen extends StatefulWidget {
  String? title, notes, phoneNumber, provinceName, addressId, lat, log;
  bool update;
  AddAdressScreen(
      {super.key,
      this.title,
      this.notes,
      this.lat,
      this.log,
      this.phoneNumber,
      this.addressId,
      this.update = false,
      this.provinceName});

  @override
  State<AddAdressScreen> createState() => _AddAdressScreenState();
}

class _AddAdressScreenState extends State<AddAdressScreen> {
  late double lat = 0.0, log = 0.0;
  String address = " ";

  void check() async {
    await Geolocator.requestPermission();
    Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      lat = pos.latitude;
      log = pos.longitude;
    });

    // print(pos);
    // bool _serviceEnabled;
    // StreamSubscription<Position> stream =
    //     Geolocator.getPositionStream().listen((event) {
    //   setState(() {
    //     lat = event.latitude;
    //     log = event.longitude;
    //     print(lat);
    //     print(log);
    //   });
    // }) as StreamSubscription<Position>;
  }

  @override
  void initState() {
    super.initState();
    check();
  }

  @override
  void deactivate() {
    super.deactivate();
    context.read<CartCubit>().clearAddressVariables();
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: lat == 0 && log == 0
          ? const SizedBox()
          : Padding(
              padding: EdgeInsets.all(50.0.sp),
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  return state.loading
                      ? AppConstant.customLoadingElvatedButton(context)
                      : AppConstant.customElvatedButton(
                          context, widget.update ? "update" : "submit",
                          () async {
                          if (widget.update) {
                            await context.read<CartCubit>().checkIfChangeValue(
                                widget.title!,
                                widget.notes!,
                                widget.phoneNumber!,
                                widget.provinceName!,
                                widget.lat!,
                                widget.log!);

                            await context
                                .read<CartCubit>()
                                .updateAddress(context, widget.addressId!);
                          } else {
                            await context.read<CartCubit>().changeLatAndLong(
                                lat.toString(), log.toString());
                            await context
                                .read<CartCubit>()
                                .insertAdress(context);
                          }
                        });
                },
              ),
            ),
      appBar: AppConstant.customAppbar(
          context,
          Text(
            "add_new_address".tr(context),
            style: TextStyle(fontSize: 50.0.sp),
          ),
          [],
          true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(50.0.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "shipping_details".tr(context),
                style:
                    TextStyle(fontSize: 50.0.sp, fontWeight: FontWeight.bold),
              ),
              AppConstant.customSizedBox(0, 50),
              TextFormFieldForAddAddress(
                defaultValue: widget.notes ?? "",
                hint: "add_notes",
                icon: const Icon(Icons.person),
                onChange: (String value) {
                  context.read<CartCubit>().changeNotes(value);
                },
              ),
              AppConstant.customSizedBox(0, 30),
              TextFormFieldForAddAddress(
                defaultValue: widget.phoneNumber ?? "",
                hint: "Enter_phone_number",
                icon: const Icon(Icons.phone),
                onChange: (String value) {
                  context.read<CartCubit>().changePhoneNumber(value);
                },
              ),
              AppConstant.customSizedBox(0, 30),
              TextFormFieldForAddAddress(
                defaultValue: widget.title ?? "",
                hint: "address_title",
                icon: const Icon(Icons.location_city),
                onChange: (String value) {
                  context.read<CartCubit>().changeAddressTitle(value);
                },
              ),
              AppConstant.customSizedBox(0, 30),
              BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  return PopupMenuButton<String>(
                    child: Container(
                      width: double.infinity,
                      height: 150.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primaryColor,
                        ),
                        borderRadius:
                            BorderRadius.circular(15), // Set rounded corners
                      ),
                      child: Center(
                        child: BlocBuilder<LocaleCubit, ChangeLocaleState>(
                          builder: (context, value) {
                            return Text(
                              state.selectedCity == null
                                  ? widget.update
                                      ? widget.provinceName!
                                      : "choose_city".tr(context)
                                  : state.selectedCity!.provinceId!.isEmpty
                                      ? widget.update
                                          ? widget.provinceName!
                                          : "choose_city".tr(context)
                                      : value.locale.languageCode == "en"
                                          ? state.selectedCity!.provinceNameEn!
                                          : value.locale.languageCode == "ar"
                                              ? state
                                                  .selectedCity!.provinceNameAr!
                                              : state.selectedCity!
                                                  .provinceNameKu!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 50.sp),
                            );
                          },
                        ),
                      ),
                    ),
                    onSelected: (value) {
                      context.read<CartCubit>().changeCity(context, value);
                    },
                    itemBuilder: (context) => [
                      for (int i = 0;
                          i < state.provinces!.provinces!.length;
                          i++)
                        PopupMenuItem(
                          value: state.provinces!.provinces![i].provinceId,
                          child: BlocBuilder<LocaleCubit, ChangeLocaleState>(
                            builder: (context, value) {
                              return Text(value.locale.languageCode == "en"
                                  ? state
                                      .provinces!.provinces![i].provinceNameEn!
                                  : value.locale.languageCode == "ar"
                                      ? state.provinces!.provinces![i]
                                          .provinceNameAr!
                                      : state.provinces!.provinces![i]
                                          .provinceNameKu!);
                            },
                          ),
                        ),
                    ],
                  );
                },
              ),
              AppConstant.customSizedBox(0, 50),
              lat == 0 && log == 0
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ))
                  : Column(
                      children: [
                        SizedBox(
                          height: 0.4.sh,
                          child: FlutterMap(
                            options: MapOptions(
                              initialZoom: 15,
                              initialCenter: widget.update
                                  ? LatLng(double.parse(widget.lat!),
                                      double.parse(widget.log!))
                                  : LatLng(lat, log),
                              onPositionChanged: (position, bool hasGesture) {
                                setState(() {
                                  lat = position.center!.latitude;
                                  log = position.center!.longitude;
                                });
                              },
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName:
                                    'dev.fleaflet.flutter_map.example',
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    width: 30.0,
                                    height: 30.0,
                                    point: widget.update
                                        ? LatLng(double.parse(widget.lat!),
                                            double.parse(widget.log!))
                                        : LatLng(lat, log),
                                    child: Icon(Icons.location_on,
                                        size: 75.w,
                                        color: AppColors.primaryColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // AppConstant.customSizedBox(0, 20),
                        // Text(address),
                        // AppConstant.customSizedBox(0, 20),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 50.0.w),
                        //   child: loading
                        //       ? AppConstant.customLoadingElvatedButton(context)
                        //       : AppConstant.customElvatedButton(
                        //           context, "select_address", () async {
                        //           try {
                        //             setState(() {
                        //               loading = true;
                        //             });
                        //             // Get current latitude and longitude from the map
                        //             final latt = lat;
                        //             final logg = log;
                        //             context.read<CartCubit>().changeLatAndLong(
                        //                 lat.toString(), log.toString());

                        //             // Retrieve addresses using the geocoding package
                        //             final placemarks =
                        //                 await placemarkFromCoordinates(
                        //                     latt, logg);

                        //             // Display the first address (or handle multiple addresses if needed)
                        //             final firstAddress = placemarks.first;
                        //             setState(() {
                        //               address =
                        //                   "${firstAddress.thoroughfare} ${firstAddress.subThoroughfare}, " // Street and sub-street
                        //                   "${firstAddress.subLocality}, ${firstAddress.locality}, " // Suburb and city
                        //                   "${firstAddress.administrativeArea}, ${firstAddress.postalCode}, " // State and ZIP code
                        //                   "${firstAddress.country}";
                        //               context
                        //                   .read<CartCubit>()
                        //                   .changeAddressTitle(address);
                        //               loading = false;
                        //             });

                        //             // Optionally store the address in variables or use it for other purposes
                        //           } catch (e) {
                        //             setState(() {
                        //               loading = false;
                        //             });
                        //           }
                        //         }),
                        // )
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
