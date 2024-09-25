import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/suppliers/add_product/presentation/cubit/add_product_cubit.dart';

import '../widgets/basic_info_widgets.dart';

class BasicInfoWidget extends StatelessWidget {
  const BasicInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "add_product_name".tr(context),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
        ),
        AppConstant.customSizedBox(0, 20),
        TextFormFieldWithTitle(
          hint: "product_name_in_arabic",
          onChange: (value) {
            context.read<AddProductCubit>().changeProductNameAr(value);
          },
        ),
        AppConstant.customSizedBox(0, 20),
        TextFormFieldWithTitle(
          hint: "product_name_in_english",
          onChange: (value) {
            context.read<AddProductCubit>().changeProductNameEn(value);
          },
        ),
        AppConstant.customSizedBox(0, 20),
        TextFormFieldWithTitle(
          hint: "product_name_in_kurdish",
          onChange: (value) {
            context.read<AddProductCubit>().changeProductNameKu(value);
          },
        ),
        //////////////////////////////////////////////////////////////////////////////////////////////
        AppConstant.customSizedBox(0, 50),
        const Divider(),
        AppConstant.customSizedBox(0, 50),
        //////////////////////////////////////////////////////////////////////////////////////////////
        Text(
          "add_product_description".tr(context),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
        ),
        AppConstant.customSizedBox(0, 20),
        TextFormFieldWithTitle(
          maxLines: true,
          hint: "Arabic_description",
          onChange: (value) {
            context.read<AddProductCubit>().changeproductDescriptionAr(value);
          },
        ),
        AppConstant.customSizedBox(0, 20),
        TextFormFieldWithTitle(
          maxLines: true,
          hint: "English_description",
          onChange: (value) {
            context.read<AddProductCubit>().changeproductDescriptionEn(value);
          },
        ),
        AppConstant.customSizedBox(0, 20),
        TextFormFieldWithTitle(
          maxLines: true,
          hint: "Kurdish_description",
          onChange: (value) {
            context.read<AddProductCubit>().changeproductDescriptionKu(value);
          },
        ),
        //////////////////////////////////////////////////////////////////////////////////////////////
        AppConstant.customSizedBox(0, 50),
        const Divider(),
        AppConstant.customSizedBox(0, 50),
        //////////////////////////////////////////////////////////////////////////////////////////////
        Text(
          "explanation_of_the_product".tr(context),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
        ),
        AppConstant.customSizedBox(0, 20),
        TextFormFieldWithTitle(
          maxLines: true,
          hint: "Arabic_explanation",
          onChange: (value) {
            context.read<AddProductCubit>().changeproductParagraphAr(value);
          },
        ),
        AppConstant.customSizedBox(0, 20),
        TextFormFieldWithTitle(
          maxLines: true,
          hint: "English_explanation",
          onChange: (value) {
            context.read<AddProductCubit>().changeproductParagraphEn(value);
          },
        ),
        AppConstant.customSizedBox(0, 20),
        TextFormFieldWithTitle(
          maxLines: true,
          hint: "Kurdish_explanation",
          onChange: (value) {
            context.read<AddProductCubit>().changeproductParagraphKu(value);
          },
        ),
        //////////////////////////////////////////////////////////////////////////////////////////////
        AppConstant.customSizedBox(0, 50),
        const Divider(),
        AppConstant.customSizedBox(0, 50),
        //////////////////////////////////////////////////////////////////////////////////////////////
        Text(
          "select_product_type".tr(context),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
        ),
        AppConstant.customSizedBox(0, 20),
        const SelectProductType(
            valueForFirstRadio: "New",
            titleForFirstRadio: "new",
            valueForSecondRadio: "Old",
            titleForSecondRadio: "old"),
        //////////////////////////////////////////////////////////////////////////////////////////////
        AppConstant.customSizedBox(0, 50),
        const Divider(),
        AppConstant.customSizedBox(0, 50),
        //////////////////////////////////////////////////////////////////////////////////////////////
        Text(
          "Appearance_status".tr(context),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
        ),
        AppConstant.customSizedBox(0, 20),
        const SelectProductType(
            valueForFirstRadio: "visible",
            titleForFirstRadio: "visible",
            valueForSecondRadio: "Not Visible",
            titleForSecondRadio: "not_visible"),
        //////////////////////////////////////////////////////////////////////////////////////////////
        AppConstant.customSizedBox(0, 50),
        const Divider(),
        AppConstant.customSizedBox(0, 50),
        //////////////////////////////////////////////////////////////////////////////////////////////
        Text(
          "store_status".tr(context),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
        ),
        AppConstant.customSizedBox(0, 20),
        const SelectProductType(
            valueForFirstRadio: "available",
            titleForFirstRadio: "available",
            valueForSecondRadio: "Not available",
            titleForSecondRadio: "not_available"),
        //////////////////////////////////////////////////////////////////////////////////////////////
        AppConstant.customSizedBox(0, 50),
        const Divider(),
        AppConstant.customSizedBox(0, 50),
        //////////////////////////////////////////////////////////////////////////////////////////////
        Text(
          "product_price".tr(context),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
        ),
        AppConstant.customSizedBox(0, 20),
        Row(
          children: [
            SizedBox(
              width: 0.7.sw,
              child: TextFormFieldWithTitle(
                hint: "",
                onChange: (value) {
                  context.read<AddProductCubit>().changeproductPrice(value);
                  context.read<AddProductCubit>().changeproductFinalPrice();
                },
              ),
            ),
            AppConstant.customSizedBox(50, 0),
            Text(
              "د.ع",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
            )
          ],
        ),
        //////////////////////////////////////////////////////////////////////////////////////////////
        AppConstant.customSizedBox(0, 50),
        const Divider(),
        AppConstant.customSizedBox(0, 50),
        //////////////////////////////////////////////////////////////////////////////////////////////
        Text(
          "discount_percentage".tr(context),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
        ),
        AppConstant.customSizedBox(0, 20),
        Row(
          children: [
            SizedBox(
              width: 0.7.sw,
              child: TextFormFieldWithTitle(
                hint: "",
                onChange: (value) {
                  context.read<AddProductCubit>().changeproductDiscount(value);

                  context.read<AddProductCubit>().changeproductFinalPrice();
                },
              ),
            ),
            AppConstant.customSizedBox(50, 0),
            Text(
              "%",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
            )
          ],
        ),
        //////////////////////////////////////////////////////////////////////////////////////////////
        AppConstant.customSizedBox(0, 50),
        const Divider(),
        AppConstant.customSizedBox(0, 50),
        //////////////////////////////////////////////////////////////////////////////////////////////
        Text(
          "the_final_price".tr(context),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
        ),
        AppConstant.customSizedBox(0, 20),
        Row(
          children: [
            SizedBox(
                width: 0.7.sw,
                child: Column(
                  children: [
                    AppConstant.customSizedBox(0, 10),
                    BlocBuilder<AddProductCubit, AddProductState>(
                      builder: (context, state) {
                        return TextFormField(
                          readOnly: true,

                          // initialValue: state.productFinalPrice,
                          decoration: InputDecoration(
                              hintText: state.productFinalPrice),
                          onChanged: (value) {},
                        );
                      },
                    )
                  ],
                )),
            AppConstant.customSizedBox(50, 0),
            Text(
              "د.ع",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
            )
          ],
        ),
        //////////////////////////////////////////////////////////////////////////////////////////////
        AppConstant.customSizedBox(0, 50),
        const Divider(),
        AppConstant.customSizedBox(0, 50),
        //////////////////////////////////////////////////////////////////////////////////////////////
        // Text(
        //   "product_points".tr(context),
        //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
        // ),
        // AppConstant.customSizedBox(0, 20),
        // TextFormFieldWithTitle(
        //   hint: "",
        //   onChange: (value) {
        //     context.read<AddProductCubit>().changeproductPoints(value);
        //   },
        // ),
        // AppConstant.customSizedBox(0, 50),
        // const Divider(),
        // AppConstant.customSizedBox(0, 50),
        AppConstant.customSizedBox(0, 30),
      ],
    );
  }
}
