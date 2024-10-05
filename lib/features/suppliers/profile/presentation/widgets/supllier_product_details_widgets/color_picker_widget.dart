// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/core/extentions/colors_to_hex.dart';
import 'package:sheek_bazar/core/utils/app_colors.dart';
import 'package:sheek_bazar/features/suppliers/profile/presentation/cubit/profile_cubit.dart';
import 'package:sheek_bazar/features/user/home/data/models/productDetails_model.dart';

class ColorPickerProductDetailsWidget extends StatefulWidget {
  List<ProductColors>? initialColorArray;
  ColorPickerProductDetailsWidget({super.key, required this.initialColorArray});

  @override
  State<ColorPickerProductDetailsWidget> createState() =>
      _ColorPickerProductDetailsWidgetState();
}

class _ColorPickerProductDetailsWidgetState
    extends State<ColorPickerProductDetailsWidget> {
  bool showColorPicker = false;
  List<Color> colorsArray = [];
  Color? selectedClolor = Colors.black;
  @override
  void initState() {
    super.initState();
    if (widget.initialColorArray != null) {
      for (int i = 0; i < widget.initialColorArray!.length; i++) {
        setState(() {
          colorsArray
              .add(HexColor.fromHex(widget.initialColorArray![i].colorHex!));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupplierProfileCubit, ProfileState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              state.canEdite!
                  ? Visibility(
                      visible: !showColorPicker,
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              showColorPicker = true;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(20.sp),
                            child: Text("add_color".tr(context)),
                          )),
                    )
                  : const SizedBox(),
              Visibility(
                visible: showColorPicker,
                child: ColorPicker(
                  color: Colors.black,
                  onChanged: (value) {
                    setState(() {
                      selectedClolor = value;
                    });
                  },
                  initialPicker: Picker.paletteHue,
                ),
              ),
              Visibility(visible: showColorPicker, child: const Divider()),
              Visibility(
                visible: showColorPicker,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showColorPicker = false;
                          colorsArray.add(selectedClolor!);
                          selectedClolor = Colors.black;
                          // String hexColor = '#' +
                          //     colorsArray[0]
                          //         .value
                          //         .toRadixString(16)
                          //         .padLeft(8, '0');
                          // print(hexColor);
                        });
                        context
                            .read<SupplierProfileCubit>()
                            .changecolorList(colorsArray);
                      },
                      child: Text(
                        "confirm".tr(context),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            showColorPicker = false;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.all(20.sp),
                          child: Text("cancel".tr(context)),
                        )),
                  ],
                ),
              ),
              Visibility(visible: showColorPicker, child: const Divider()),
              widget.initialColorArray == null && colorsArray.isEmpty
                  ? Text(
                      "There are not any Colors".tr(context),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  : SizedBox(
                      width: 1.sw,
                      height: 200.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: colorsArray.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 20.w),
                            child: Stack(children: [
                              Container(
                                width: 200.sp,
                                height: 200.sp,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: colorsArray[index],
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              state.canEdite!
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          colorsArray.removeAt(index);
                                        });
                                        context
                                            .read<SupplierProfileCubit>()
                                            .changecolorList(colorsArray);
                                      },
                                      child: Container(
                                        width: 75.sp,
                                        height: 75.sp,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.whiteColor,
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            color: Colors.black,
                                            Icons.close,
                                            size: 50.sp,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ]),
                          );
                        },
                      ),
                    )
            ],
          ),
        );
      },
    );
  }
}
