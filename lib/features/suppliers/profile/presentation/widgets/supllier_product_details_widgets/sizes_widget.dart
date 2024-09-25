// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/core/utils/app_colors.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/suppliers/profile/presentation/cubit/profile_cubit.dart';
import 'package:sheek_bazar/features/user/home/data/models/productDetails_model.dart';

class OtherWayForSizes extends StatefulWidget {
  var productSizes;
  OtherWayForSizes({super.key, this.productSizes});

  @override
  State<OtherWayForSizes> createState() => _OtherWayForSizesState();
}

class _OtherWayForSizesState extends State<OtherWayForSizes> {
  var selectedSized = [];
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.productSizes != null) {
      for (int i = 0; i < widget.productSizes.length; i++) {
        setState(() {
          if (widget.productSizes![i].sizeName != 'xxxl' &&
              widget.productSizes![i].sizeName != 'xxl' &&
              widget.productSizes![i].sizeName != 'xl' &&
              widget.productSizes![i].sizeName != 's' &&
              widget.productSizes![i].sizeName != 'm' &&
              widget.productSizes![i].sizeName != 'l') {
            selectedSized.add(widget.productSizes![i].sizeName);
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupplierProfileCubit, ProfileState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            state.canEdite!
                ? TextFormField(
                    controller: controller,
                  )
                : const SizedBox(),
            AppConstant.customSizedBox(0, 20),
            state.canEdite!
                ? ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedSized.add(controller.text);
                      });
                      context
                          .read<SupplierProfileCubit>()
                          .changesizesList(selectedSized);

                      // context.read<AddProductCubit>().changesizeName(selectedSized);
                    },
                    child: Text("confirm".tr(context)))
                : const SizedBox(),
            SizedBox(
              height: 250.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: selectedSized.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: Stack(children: [
                      Container(
                        width: 200.sp,
                        height: 200.sp,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            selectedSized[index].toString(),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      state.canEdite!
                          ? InkWell(
                              onTap: () {
                                var newList = [];

                                setState(() {
                                  for (int i = 0;
                                      i < selectedSized.length;
                                      i++) {
                                    if (selectedSized[i] ==
                                        selectedSized[index]) {
                                      // continue;
                                    } else {
                                      newList.add(selectedSized[i]);
                                    }
                                  }
                                  selectedSized = newList;
                                  // colorsArray.removeAt(index);
                                  // context
                                  //     .read<AddProductCubit>()
                                  //     .changesizeName(selectedSized);
                                });
                                // context.read<AddProductCubit>().changecolorHex(colorsArray);
                                context
                                    .read<SupplierProfileCubit>()
                                    .changesizesList(selectedSized);
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
                                    Icons.close,
                                    color: Colors.black,
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
        );
      },
    );
  }
}

class SizesWidgetForEdite extends StatefulWidget {
  List<ProductSizes>? productSizes;

  SizesWidgetForEdite({
    super.key,
    required this.productSizes,
  });

  @override
  State<SizesWidgetForEdite> createState() => _SizesWidgetForEditeState();
}

class _SizesWidgetForEditeState extends State<SizesWidgetForEdite> {
  bool isSelecteds = false;
  bool isSelectedm = false;
  bool isSelectedl = false;
  bool isSelectedxl = false;
  bool isSelectedxxl = false;
  bool isSelectedxxxl = false;
  var isSelected = [];

  void handleCheckboxChange(bool value, String option) {
    if (isSelected.any((item) => item == option)) {
      setState(() {
        isSelected.removeWhere((item) => item == option);
      });
    } else {
      setState(() {
        isSelected.add(option);
      });
    }
    setState(() {
      if (option == 's') {
        isSelecteds = !isSelecteds;
      } else if (option == 'm') {
        isSelectedm = !isSelectedm;
      } else if (option == 'l') {
        isSelectedl = !isSelectedl;
      } else if (option == 'xl') {
        isSelectedxl = !isSelectedxl;
      } else if (option == 'xxl') {
        isSelectedxxl = !isSelectedxxl;
      } else if (option == 'xxxl') {
        isSelectedxxxl = !isSelectedxxxl;
      }
    });
    context.read<SupplierProfileCubit>().changesizesList(isSelected);
  }

  @override
  void initState() {
    super.initState();
    insertOldValues();
  }

  insertOldValues() {
    if (widget.productSizes != null) {
      for (int i = 0; i < widget.productSizes!.length; i++) {
        setState(() {
          if (widget.productSizes![i].sizeName == 'xxxl' ||
              widget.productSizes![i].sizeName == 'xxl' ||
              widget.productSizes![i].sizeName == 's' ||
              widget.productSizes![i].sizeName == 'm' ||
              widget.productSizes![i].sizeName == 'l' ||
              widget.productSizes![i].sizeName == 'xl') {
            isSelected.add(widget.productSizes![i].sizeName);
          }
          if (widget.productSizes![i].sizeName == 's') {
            isSelecteds = !isSelecteds;
          } else if (widget.productSizes![i].sizeName == 'm') {
            isSelectedm = !isSelectedm;
          } else if (widget.productSizes![i].sizeName == 'l') {
            isSelectedl = !isSelectedl;
          } else if (widget.productSizes![i].sizeName == 'xl') {
            isSelectedxl = !isSelectedxl;
          } else if (widget.productSizes![i].sizeName == 'xxl') {
            isSelectedxxl = !isSelectedxxl;
          } else if (widget.productSizes![i].sizeName == 'xxxl') {
            isSelectedxxxl = !isSelectedxxxl;
          }
        });
      }
    }
  }

  bool shoesSizes = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<SupplierProfileCubit, ProfileState>(
          builder: (context, state) {
            // print(state.sizesList!);
            return Column(
              children: [
                widget.productSizes == null && state.sizesList == null
                    ? Text(
                        "There are not any sizes".tr(context),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    : widget.productSizes == null && state.sizesList!.isEmpty
                        ? Text(
                            "There are not any sizes".tr(context),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        : const SizedBox(),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        shoesSizes = !shoesSizes;
                      });
                      context.read<SupplierProfileCubit>().changesizesList([]);
                    },
                    child: Text("Other Sizes".tr(context))),
                shoesSizes
                    ? OtherWayForSizes(productSizes: widget.productSizes)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: isSelecteds,
                                onChanged: state.canEdite!
                                    ? (value) =>
                                        handleCheckboxChange(value!, 's')
                                    : (value) {},
                              ),
                              const Text('s'),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: isSelectedm,
                                onChanged: state.canEdite!
                                    ? (value) =>
                                        handleCheckboxChange(value!, 'm')
                                    : (value) {},
                              ),
                              const Text('m'),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: isSelectedl,
                                onChanged: state.canEdite!
                                    ? (value) =>
                                        handleCheckboxChange(value!, 'l')
                                    : (value) {},
                              ),
                              const Text('l'),
                            ],
                          ),
                        ],
                      ),
                ////////////////////////////////////////////////////
                shoesSizes
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: isSelectedxl,
                                onChanged: state.canEdite!
                                    ? (value) =>
                                        handleCheckboxChange(value!, 'xl')
                                    : (value) {},
                              ),
                              const Text('xl'),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: isSelectedxxl,
                                onChanged: state.canEdite!
                                    ? (value) =>
                                        handleCheckboxChange(value!, 'xxl')
                                    : (value) {},
                              ),
                              const Text('xxl'),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: isSelectedxxxl,
                                onChanged: state.canEdite!
                                    ? (value) =>
                                        handleCheckboxChange(value!, 'xxxl')
                                    : (value) {},
                              ),
                              const Text('xxl'),
                            ],
                          ),
                        ],
                      ),
              ],
            );
          },
        ),
      ],
    );
  }
}
