// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/cubit/locale_cubit.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/core/utils/cache_helper.dart';
import 'package:sheek_bazar/features/user/profile/presentation/widgets/profile_widgets.dart';

class supllierProfileScreen extends StatefulWidget {
  const supllierProfileScreen({super.key});

  @override
  State<supllierProfileScreen> createState() => _supllierProfileScreenState();
}

class _supllierProfileScreenState extends State<supllierProfileScreen> {
  String? userId;
  String? supplierId;

  Future<void> fetchData() async {
    setState(() {
      userId = CacheHelper.getData(key: "USER_ID");
      supplierId = CacheHelper.getData(key: "SUPPLIER_ID");
    });
    // if (userId != null) {
    //   context.read<CartCubit>().getProvinces(context);
    // }
  }

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, ChangeLocaleState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Column(
              children: [
                ProfileImage(
                  fromSupplier: true,
                ).animate().fade(duration: 500.ms).scale(delay: 500.ms),
                AppConstant.customSizedBox(0, 30),
                InformationDetails(
                  fromSupplier: true,
                  supplierId: supplierId,
                ).animate().fade(duration: 500.ms).scale(delay: 500.ms),
              ],
            ),
          ),
        );
      },
    );
  }
}
