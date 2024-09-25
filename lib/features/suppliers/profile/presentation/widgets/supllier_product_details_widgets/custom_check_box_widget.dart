import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/features/suppliers/profile/presentation/cubit/profile_cubit.dart';

class CustomCheckBox extends StatefulWidget {
  final String titleForFirstRadio,
      valueForFirstRadio,
      titleForSecondRadio,
      valueForSecondRadio,
      initalValue;
  const CustomCheckBox({
    super.key,
    required this.valueForFirstRadio,
    required this.initalValue,
    required this.valueForSecondRadio,
    required this.titleForFirstRadio,
    required this.titleForSecondRadio,
  });

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  String initialValue = "";
  @override
  void initState() {
    super.initState();
    if (widget.initalValue == "0") {
      setState(() {
        initialValue = widget.valueForFirstRadio;
      });
    } else {
      setState(() {
        initialValue = widget.valueForSecondRadio;
      });
    }
  }

  void onGenderSelected(String? value) {
    setState(() {
      initialValue = value!;
    });
    if (value == "New") {
      context.read<SupplierProfileCubit>().changeIsused("0");
    } else if (value == "Old") {
      context.read<SupplierProfileCubit>().changeIsused("1");
    } else if (value == "Not Visible") {
      context.read<SupplierProfileCubit>().changeIsVisible("0");
    } else if (value == "visible") {
      context.read<SupplierProfileCubit>().changeIsVisible("1");
    } else if (value == "available") {
      context.read<SupplierProfileCubit>().changeoutOfStock("0");
    } else if (value == "Not available") {
      context.read<SupplierProfileCubit>().changeoutOfStock("1");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupplierProfileCubit, ProfileState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Radio(
                  value: widget.valueForFirstRadio,
                  groupValue: initialValue,
                  onChanged: state.canEdite! ? onGenderSelected : (value) {},
                ),
                Text(widget.titleForFirstRadio.tr(context)),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: widget.valueForSecondRadio,
                  groupValue: initialValue,
                  onChanged: state.canEdite! ? onGenderSelected : (value) {},
                ),
                Text(widget.titleForSecondRadio.tr(context)),
              ],
            ),
          ],
        );
      },
    );
  }
}
