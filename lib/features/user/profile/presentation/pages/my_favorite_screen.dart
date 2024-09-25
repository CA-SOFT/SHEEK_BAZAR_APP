// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/Locale/cubit/locale_cubit.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/core/utils/cache_helper.dart';
import 'package:sheek_bazar/features/user/profile/presentation/cubit/profile_cubit.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../home/presentation/widgets/home_widgets.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  String? userId;
  Future fetchData() async {
    setState(() {
      userId = CacheHelper.getData(key: "USER_ID");
    });
    if (userId != null) {
      context.read<ProfileCubit>().getMyFavorite(context);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppConstant.customAppbar(
          context,
          Text(
            "favorite".tr(context),
            style: TextStyle(fontSize: 50.sp),
          ),
          [],
          true),
      body: userId == null
          ? Center(
              child: Text(
                "log_in_to_enjoy_these_benefits".tr(context),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          : BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                return state.loadingFavorite
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      )
                    : state.myFavorite == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/empty.png"),
                              Center(
                                child: Text(
                                  "empty_favorite".tr(context),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )
                        : state.myFavorite!.wishlistItems!.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/empty.png"),
                                  Center(
                                    child: Text(
                                      "empty_favorite".tr(context),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              )
                            : BlocBuilder<LocaleCubit, ChangeLocaleState>(
                                builder: (context, value) {
                                  return ListView.builder(
                                    itemCount: state.myFavorite == null
                                        ? 0
                                        : state
                                            .myFavorite!.wishlistItems!.length,
                                    itemBuilder: (context, index) {
                                      return Item(
                                        fromFav: true,
                                        supplierId: state.myFavorite!
                                            .wishlistItems![index].supplierId,
                                        discount: state
                                            .myFavorite!
                                            .wishlistItems![index]
                                            .productDiscount,
                                        priceBeforeDiscount: state.myFavorite!
                                            .wishlistItems![index].productPrice,
                                        postImage: state.myFavorite!
                                            .wishlistItems![index].productImg!,
                                        title: value.locale.languageCode == 'en'
                                            ? state
                                                .myFavorite!
                                                .wishlistItems![index]
                                                .productNameEn!
                                            : value.locale.languageCode == 'ar'
                                                ? state
                                                    .myFavorite!
                                                    .wishlistItems![index]
                                                    .productNameAr!
                                                : state
                                                    .myFavorite!
                                                    .wishlistItems![index]
                                                    .productNameKu!,
                                        description:
                                            value.locale.languageCode == 'en'
                                                ? state
                                                    .myFavorite!
                                                    .wishlistItems![index]
                                                    .productParagraphEn!
                                                : value.locale.languageCode ==
                                                        'ar'
                                                    ? state
                                                        .myFavorite!
                                                        .wishlistItems![index]
                                                        .productParagraphAr!
                                                    : state
                                                        .myFavorite!
                                                        .wishlistItems![index]
                                                        .productParagraphKu!,
                                        shopTitle: state
                                            .myFavorite!
                                            .wishlistItems![index]
                                            .supplierName!,
                                        shopImage: state
                                            .myFavorite!
                                            .wishlistItems![index]
                                            .supplierLogo!,
                                        price: state
                                            .myFavorite!
                                            .wishlistItems![index]
                                            .productFinalPrice!,
                                        productId: state.myFavorite!
                                            .wishlistItems![index].productId,
                                        id: state.myFavorite!
                                            .wishlistItems![index].id,
                                      )
                                          .animate()
                                          .fade(duration: 500.ms)
                                          .scale(delay: 500.ms);
                                    },
                                  );
                                },
                              );
              },
            ),
    );
  }
}
