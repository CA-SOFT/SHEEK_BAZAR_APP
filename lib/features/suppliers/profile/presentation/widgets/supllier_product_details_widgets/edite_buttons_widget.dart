// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/features/suppliers/profile/presentation/cubit/profile_cubit.dart';
import 'package:sheek_bazar/features/user/home/presentation/cubit/home_cubit.dart';
import 'package:sheek_bazar/features/user/home/presentation/cubit/home_state.dart';

class EditeButtonsWidget extends StatefulWidget {
  String productId;
  EditeButtonsWidget({super.key, required this.productId});

  @override
  State<EditeButtonsWidget> createState() => _EditeButtonsWidgetState();
}

class _EditeButtonsWidgetState extends State<EditeButtonsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 0.3.sw,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  context
                      .read<SupplierProfileCubit>()
                      .changeCanEditeValue(false);
                  context.read<SupplierProfileCubit>().addItemsToBanners(
                      state.productDetails!.productAttachments!, context);
                  context.read<ProductDetailsCubit>().getProductDetails(
                      context, widget.productId,
                      fromSupplier: true);
                },
                child: Text(
                  "cancel".tr(context),
                ),
              ),
            ),
            BlocBuilder<SupplierProfileCubit, ProfileState>(
              builder: (context, profileState) {
                return profileState.updateProduct!
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () async {},
                        child: const Center(
                          child: SizedBox(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              )),
                        ),
                      )
                    : SizedBox(
                        width: 0.3.sw,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () async {
                              context
                                  .read<SupplierProfileCubit>()
                                  .updateProduct(context, widget.productId,
                                      state.productDetails!);
                            },
                            child: Text("edit".tr(context))));
              },
            )
          ],
        );
      },
    );
  }
}
