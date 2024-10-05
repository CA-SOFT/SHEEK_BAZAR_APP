import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/features/suppliers/add_product/presentation/cubit/add_product_cubit.dart';
import 'package:sheek_bazar/features/suppliers/add_product/presentation/widgets/sizes_colors_widgets.dart';

import '../../../../../core/utils/app_constants.dart';

class SizesAndColorsScreen extends StatefulWidget {
  const SizesAndColorsScreen({super.key});

  @override
  State<SizesAndColorsScreen> createState() => _SizesAndColorsScreenState();
}

class _SizesAndColorsScreenState extends State<SizesAndColorsScreen> {
  bool shoesSize = false;
  bool isSizesChecked = false;
  bool isColorsChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "choose_the_available_sizes".tr(context),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
        ),
        isSizesChecked
            ? const SizedBox()
            : ElevatedButton(
                onPressed: () {
                  setState(() {
                    shoesSize = !shoesSize;
                  });
                  context.read<AddProductCubit>().changesizeName([]);
                },
                child: Text("Other Sizes".tr(context))),
        AppConstant.customSizedBox(0, 20),
        isSizesChecked
            ? const SizedBox()
            : shoesSize
                ? const OtherWayForSizes()
                : const CategorySelectionForSizesAndColors(),
        Row(
          children: [
            Checkbox(
              value: isSizesChecked,
              onChanged: (bool? value) {
                setState(() {
                  isSizesChecked = value!;
                });
                context.read<AddProductCubit>().changesizeName([]);
              },
            ),
            Text("Without Sizes".tr(context))
          ],
        ),
        //////////////////////////////////////////////////////////////////////////////////////////////
        AppConstant.customSizedBox(0, 50),
        const Divider(),
        AppConstant.customSizedBox(0, 50),
        //////////////////////////////////////////////////////////////////////////////////////////////
        Text(
          "choose_the_available_colors".tr(context),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
        ),
        Row(
          children: [
            Checkbox(
              value: isColorsChecked,
              onChanged: (bool? value) {
                setState(() {
                  isColorsChecked = value!;
                });
                context.read<AddProductCubit>().changecolorHex([]);
              },
            ),
            Text("Without Colors".tr(context))
          ],
        ),
        isColorsChecked ? const SizedBox() : const ColorPickerWidget(),
      ],
    );
  }
}
