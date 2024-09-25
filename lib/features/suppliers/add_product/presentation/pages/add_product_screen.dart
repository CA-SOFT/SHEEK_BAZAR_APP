import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/Locale/cubit/locale_cubit.dart';
import 'package:sheek_bazar/features/suppliers/add_product/presentation/cubit/add_product_cubit.dart';
import 'package:sheek_bazar/features/suppliers/add_product/presentation/pages/attachment_screen.dart';
import 'package:sheek_bazar/features/suppliers/add_product/presentation/pages/sizes_colors_screen.dart';
import 'package:sheek_bazar/features/user/categories/presentation/cubit/categories_cubit.dart';

import 'basic_info_screen.dart';
import 'categories_screen.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  int currentStep = 0;
  continueStep() {
    if (currentStep < 3) {
      setState(() {
        currentStep = currentStep + 1; //currentStep+=1;
      });
    }
  }

  cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep = currentStep - 1; //currentStep-=1;
      });
    }
  }

  onStepTapped(int value) {
    setState(() {
      currentStep = value;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<CategoriesCubit>().getCategories(context);
    context.read<AddProductCubit>().changeProductNameAr("");
    context.read<AddProductCubit>().changeProductNameEn("");
    context.read<AddProductCubit>().changeProductNameKu("");
    context.read<AddProductCubit>().changeproductDescriptionAr("");
    context.read<AddProductCubit>().changeproductDescriptionEn("");
    context.read<AddProductCubit>().changeproductDescriptionKu("");
    context.read<AddProductCubit>().changeproductParagraphAr("");
    context.read<AddProductCubit>().changeproductParagraphEn("");
    context.read<AddProductCubit>().changeproductParagraphKu("");
    context.read<AddProductCubit>().changeisUsed("");
    context.read<AddProductCubit>().changeisVisible("");
    context.read<AddProductCubit>().changeisOutOfStock("");
    context.read<AddProductCubit>().changeproductPrice("");
    context.read<AddProductCubit>().changeproductDiscount("");
    // context.read<AddProductCubit>().changeproductFinalPrice();
    context.read<AddProductCubit>().changecategoryId([]);
    context.read<AddProductCubit>().changesubCategoryId([]);
    context.read<AddProductCubit>().changesizeName([]);
    context.read<AddProductCubit>().changecolorHex([]);
    context.read<AddProductCubit>().cleanattachment([]);
  }

  @override
  Widget build(BuildContext context) {
    Widget controlBuilders(context, details) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // currentStep == 0
            //     ? const SizedBox()
            //     : OutlinedButton(
            //         onPressed: details.onStepCancel,
            //         child: Text('Back'.tr(context)),
            //       ),
            currentStep == 3
                ? BlocBuilder<AddProductCubit, AddProductState>(
                    builder: (context, state) {
                      return ElevatedButton(
                          onPressed: () {
                            if (state.sendProduct == false) {
                              var validate = context
                                  .read<AddProductCubit>()
                                  .fieldsValidationForFourthStep(context);
                              if (validate) {
                                context
                                    .read<AddProductCubit>()
                                    .AddProduct(context);
                              }
                            }
                          },
                          child: state.sendProduct!
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text("insert_product".tr(context)));
                    },
                  )
                : BlocBuilder<AddProductCubit, AddProductState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          if (currentStep == 0) {
                            var validate = context
                                .read<AddProductCubit>()
                                .fieldsValidationForOneStep(context);
                            if (validate == true) {
                              details.onStepContinue();
                            }
                          } else if (currentStep == 1) {
                            var validate = context
                                .read<AddProductCubit>()
                                .fieldsValidationForSecondStep(context);
                            if (validate == true) {
                              details.onStepContinue();
                            }
                          } else if (currentStep == 2) {
                            // var validate = false;
                            // if (validate == true) {
                            details.onStepContinue();
                            // }
                            // validate = true;
                          }
                        },
                        child: Text('Next'.tr(context)),
                      );
                    },
                  ),
          ],
        ),
      );
    }

    return Scaffold(
      body: BlocBuilder<LocaleCubit, ChangeLocaleState>(
        builder: (context, state) {
          return SafeArea(
            child: Stepper(
              // elevation: 0, //Horizontal Impact
              // margin: const EdgeInsets.all(0), //vertical impact
              controlsBuilder: controlBuilders,
              type: StepperType.horizontal,
              physics: const ScrollPhysics(),
              onStepTapped: onStepTapped,
              onStepContinue: continueStep,
              onStepCancel: cancelStep,
              currentStep: currentStep,
              steps: [
                Step(
                    title: Icon(
                      state.locale.languageCode == "en"
                          ? Icons.keyboard_double_arrow_right_sharp
                          : Icons.keyboard_double_arrow_left_sharp,
                      size: 50.sp,
                    ),
                    label: Text(
                      'basic_info'.tr(context),
                      style: TextStyle(
                          fontSize: state.locale.languageCode == "en"
                              ? 30.sp
                              : 25.sp),
                    ),
                    content: const BasicInfoWidget(),
                    isActive: currentStep >= 0,
                    state: currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled),
                Step(
                  title: Icon(
                    state.locale.languageCode == "en"
                        ? Icons.keyboard_double_arrow_right_sharp
                        : Icons.keyboard_double_arrow_left_sharp,
                    size: 50.sp,
                  ),
                  label: Text('Categories'.tr(context),
                      style: TextStyle(
                          fontSize: state.locale.languageCode == "en"
                              ? 30.sp
                              : 25.sp)),
                  content: const CategoriesScreen(),
                  isActive: currentStep >= 0,
                  state: currentStep >= 1
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: Icon(
                    state.locale.languageCode == "en"
                        ? Icons.keyboard_double_arrow_right_sharp
                        : Icons.keyboard_double_arrow_left_sharp,
                    size: 50.sp,
                  ),
                  label: Text('Colors_Sizes'.tr(context),
                      style: TextStyle(
                          fontSize: state.locale.languageCode == "en"
                              ? 30.sp
                              : 25.sp)),
                  content: const SizesAndColorsScreen(),
                  isActive: currentStep >= 0,
                  state: currentStep >= 2
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: const Text(""),
                  label: Text('attachment'.tr(context),
                      style: TextStyle(
                          fontSize: state.locale.languageCode == "en"
                              ? 30.sp
                              : 25.sp)),
                  content: const VideoSelector(),
                  isActive: currentStep >= 0,
                  state: currentStep >= 3
                      ? StepState.complete
                      : StepState.disabled,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
