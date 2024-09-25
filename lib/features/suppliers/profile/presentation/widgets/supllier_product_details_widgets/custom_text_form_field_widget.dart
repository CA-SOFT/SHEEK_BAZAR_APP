import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/suppliers/profile/presentation/cubit/profile_cubit.dart';

class CustomTextFormField extends StatelessWidget {
  final String initalValue;
  final Function onChange;
  final bool maxLines;
  const CustomTextFormField(
      {super.key,
      required this.initalValue,
      required this.onChange,
      this.maxLines = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupplierProfileCubit, ProfileState>(
      builder: (context, state) {
        return Column(
          children: [
            AppConstant.customSizedBox(0, 10),
            TextFormField(
              readOnly: state.canEdite! ? false : true,
              maxLines: maxLines ? 2 : 1,
              // decoration: InputDecoration(
              //   labelText: hint.tr(context),
              // ),
              initialValue: initalValue,
              onChanged: (value) {
                onChange(value);
              },
            ),
          ],
        );
      },
    );
  }
}
