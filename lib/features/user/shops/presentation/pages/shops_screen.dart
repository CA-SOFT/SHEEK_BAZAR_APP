import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/Locale/cubit/locale_cubit.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/user/shops/data/models/shops_model.dart';
import 'package:sheek_bazar/features/user/shops/presentation/cubit/shops_cubit.dart';

import '../../../../../core/utils/cache_helper.dart';
import '../widgets/shop_widgets.dart';

class ShopsScreen extends StatefulWidget {
  const ShopsScreen({super.key});

  @override
  State<ShopsScreen> createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
  late List<Suppliers> filteredSuppliers;
  String? userId;
  Future<void> fetchData() async {
    setState(() {
      userId = CacheHelper.getData(key: "USER_ID");
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<ShopsCubit>().getShops(context);
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, ChangeLocaleState>(
      builder: (context, state) {
        return Scaffold(
            drawer: AppConstant.customDrawer(context,
                isGuest: userId == null ? true : false),
            appBar: AppConstant.customAppbar(
                context,
                Text(
                  "Shops".tr(context),
                  style:
                      TextStyle(fontSize: 50.0.sp, fontWeight: FontWeight.bold),
                ),
                [],
                false),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(50.0.sp),
                child: BlocBuilder<ShopsCubit, ShopsState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 10.sp,
                                color: Colors.black,
                              ),
                            ),
                            labelText: 'Search'.tr(context),
                            suffixIcon: const Icon(Icons.search),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            suffixIconColor: Colors.black,
                          ),
                          onChanged: (searchTerm) {
                            filteredSuppliers = state.shops!.suppliers!
                                .where(
                                  (supplier) => supplier.supplierName!
                                      .toLowerCase()
                                      .contains(searchTerm.toLowerCase()),
                                )
                                .toList();
                            context
                                .read<ShopsCubit>()
                                .changeFilter(filteredSuppliers);
                          },
                        ),
                        AppConstant.customSizedBox(0, 30),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.shopsFilter == null
                              ? 0
                              : state.shopsFilter!.suppliers!.length,
                          itemBuilder: (context, index) {
                            return shopCard(
                              supplierId: state
                                  .shopsFilter!.suppliers![index].supplierId!,
                              supplierLogo: state
                                  .shopsFilter!.suppliers![index].supplierLogo!,
                              supplierDescription: state.shopsFilter!
                                  .suppliers![index].supplierDescription!,
                              supplierName: state
                                  .shopsFilter!.suppliers![index].supplierName!,
                            )
                                .animate()
                                .fade(duration: 500.ms)
                                .scale(delay: 500.ms);
                          },
                        )
                      ],
                    );
                  },
                ),
              ),
            ));
      },
    );
  }
}
