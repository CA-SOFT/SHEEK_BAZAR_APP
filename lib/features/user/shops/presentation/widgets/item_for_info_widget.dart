// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';

class ItemForInfo extends StatelessWidget {
  Icon icon;
  String? title, description;
  ItemForInfo(
      {super.key,
      required this.icon,
      required this.description,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40.sp),
      child: Row(
        children: [
          icon,
          AppConstant.customSizedBox(50, 0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title!.tr(context),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45.sp),
              ),
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: description!));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'text_copy'.tr(context),
                        style: TextStyle(fontSize: 40.sp),
                      ),
                    ),
                  );
                },
                child: Text(
                  description!,
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 45.sp),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
