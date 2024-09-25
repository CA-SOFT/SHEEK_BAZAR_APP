import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/suppliers/add_product/presentation/cubit/add_product_cubit.dart';

class TextFormFieldWithTitle extends StatelessWidget {
  final String hint;
  final Function onChange;
  final bool maxLines;
  const TextFormFieldWithTitle(
      {super.key,
      required this.hint,
      required this.onChange,
      this.maxLines = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppConstant.customSizedBox(0, 10),
        TextFormField(
          maxLines: maxLines ? 2 : 1,
          decoration: InputDecoration(
            labelText: hint.tr(context),
          ),
          onChanged: (value) {
            onChange(value);
          },
        ),
      ],
    );
  }
}

class SelectProductType extends StatefulWidget {
  final String titleForFirstRadio,
      valueForFirstRadio,
      titleForSecondRadio,
      valueForSecondRadio;
  const SelectProductType({
    super.key,
    required this.valueForFirstRadio,
    required this.valueForSecondRadio,
    required this.titleForFirstRadio,
    required this.titleForSecondRadio,
  });

  @override
  State<SelectProductType> createState() => _SelectProductTypeState();
}

class _SelectProductTypeState extends State<SelectProductType> {
  String selectedGender = "";

  void onGenderSelected(String? value) {
    setState(() {
      selectedGender = value!;
    });
    if (value == "New") {
      context.read<AddProductCubit>().changeisUsed("0");
    } else if (value == "Old") {
      context.read<AddProductCubit>().changeisUsed("1");
    } else if (value == "Not Visible") {
      context.read<AddProductCubit>().changeisVisible("0");
    } else if (value == "visible") {
      context.read<AddProductCubit>().changeisVisible("1");
    } else if (value == "available") {
      context.read<AddProductCubit>().changeisOutOfStock("0");
    } else if (value == "Not available") {
      context.read<AddProductCubit>().changeisOutOfStock("1");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Radio(
              value: widget.valueForFirstRadio,
              groupValue: selectedGender,
              onChanged: onGenderSelected,
            ),
            Text(widget.titleForFirstRadio.tr(context)),
          ],
        ),
        Row(
          children: [
            Radio(
              value: widget.valueForSecondRadio,
              groupValue: selectedGender,
              onChanged: onGenderSelected,
            ),
            Text(widget.titleForSecondRadio.tr(context)),
          ],
        ),
      ],
    );
  }
}
