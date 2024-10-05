// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';

class TextFormFieldForAddAddress extends StatelessWidget {
  String hint;
  Icon icon;
  Function onChange;
  String defaultValue;
  TextFormFieldForAddAddress(
      {super.key,
      required this.hint,
      required this.icon,
      this.defaultValue = '',
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: hint == "Enter_phone_number" ? TextInputType.number : null,
      initialValue: defaultValue,
      decoration: InputDecoration(
        labelText: hint.tr(context),
        prefixIcon: icon,
      ),
      onChanged: (value) {
        onChange(value);
      },
    );
  }
}
