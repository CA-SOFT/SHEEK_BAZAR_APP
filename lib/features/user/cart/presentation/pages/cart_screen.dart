// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/core/utils/app_colors.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/core/utils/cache_helper.dart';
import 'package:sheek_bazar/features/auth/presentation/pages/sign_in.dart';
import 'package:sheek_bazar/features/user/profile/presentation/cubit/profile_cubit.dart';

import '../cubit/cart_cubit.dart';
import '../widgets/cart_widgets.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? userId;
  Future<void> fetchData() async {
    setState(() {
      userId = CacheHelper.getData(key: "USER_ID");
    });
    if (userId != null) {
      context.read<CartCubit>().getMyCart(context);
      context.read<ProfileCubit>().getUserInfo(context);
      context.read<CartCubit>().getMyAdress(context);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void deactivate() {
    super.deactivate();
    context.read<CartCubit>().clearMyCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppConstant.customAppbar(
            context,
            Text(
              "my_cart".tr(context),
              style: TextStyle(fontSize: 50.0.sp),
            ),
            [],
            true),
        bottomNavigationBar:
            userId == null ? null : const CutsomBottomNavForCart(),
        body: userId == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/join_with_us.png"),
                    Text(
                      "log_in_to_enjoy_these_benefits".tr(context),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    AppConstant.customSizedBox(0, 50),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.w),
                      child: AppConstant.customElvatedButton(context, "sign_in",
                          () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const SigninScreen()),
                          (Route route) => false,
                        );
                      }),
                    )
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 50.sp, horizontal: 20.sp),
                  child: BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      return state.loadingCart
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: AppColors.primaryColor),
                            )
                          : state.cartitems == null
                              ? Center(
                                  child: Text("empty_cart".tr(context)),
                                )
                              : state.cartitems!.cartItems!.isEmpty
                                  ? Center(
                                      child: Text("empty_cart".tr(context)),
                                    )
                                  : Column(
                                      children: [
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: state.cartitems == null
                                              ? 0
                                              : state
                                                  .cartitems!.cartItems!.length,
                                          itemBuilder: (context, index) {
                                            return CartItem(
                                                    index: index,
                                                    item: state.cartitems!
                                                        .cartItems![index])
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
  }
}
