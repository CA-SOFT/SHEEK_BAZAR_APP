import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
import 'package:sheek_bazar/core/utils/app_colors.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/core/utils/cache_helper.dart';
import 'package:sheek_bazar/features/user/shops/presentation/cubit/shops_cubit.dart';
import 'package:sheek_bazar/features/user/shops/presentation/pages/shopDetails_screen.dart';

class FollwersScreen extends StatefulWidget {
  const FollwersScreen({super.key});

  @override
  State<FollwersScreen> createState() => _FollwersScreenState();
}

class _FollwersScreenState extends State<FollwersScreen> {
  String? userId;
  Future fetchData() async {
    setState(() {
      userId = CacheHelper.getData(key: "USER_ID");
    });
    if (userId != null) {
      // context.read<ProfileCubit>().getMyFavorite(context);
      context.read<ShopsCubit>().getFollowers(context);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopsCubit, ShopsState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppConstant.customAppbar(
                context,
                Text(
                  "followers_by_me".tr(context),
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
                : state.loadingProducts
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      )
                    : state.followState == null
                        ? SizedBox(
                            height: 1.sh,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/empty_data.png"),
                                  Text(
                                    "There are no follwers".tr(context),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : state.followers!.suppliers == null
                            ? SizedBox(
                                height: 1.sh,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          "assets/images/empty_data.png"),
                                      Text(
                                        "There are no follwers".tr(context),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : state.followers!.suppliers!.isEmpty
                                ? SizedBox(
                                    height: 1.sh,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                              "assets/images/empty_data.png"),
                                          Text(
                                            "There are no follwers".tr(context),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: state.followers == null
                                        ? 0
                                        : state.followers!.suppliers!.length,
                                    itemBuilder: (context, index) {
                                      return BlocBuilder<ThemesCubit,
                                          ThemesState>(
                                        builder: (context, theme) {
                                          return Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: theme.mode == "dark"
                                                    ? Colors.black
                                                    : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 5.0,
                                                    blurRadius: 7.0,
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                AppConstant
                                                                    .customNavigation(
                                                                        context,
                                                                        ShopDetailsScreen(
                                                                          supplierId:
                                                                              // ignore: unnecessary_string_interpolations
                                                                              "${state.followers!.suppliers![index].supplierId!}",
                                                                        ),
                                                                        -1,
                                                                        0);
                                                              },
                                                              child: ClipOval(
                                                                child: Container(
                                                                    decoration: BoxDecoration(
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: theme.mode ==
                                                                                "dark"
                                                                            ? Colors.white
                                                                            : AppColors.primaryColor,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    width: 120.w,
                                                                    height: 120.w,
                                                                    child: ClipOval(
                                                                      child: AppConstant
                                                                          .customNetworkImage(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        imagePath:
                                                                            state.followers!.suppliers![index].supplierLogo ??
                                                                                "",
                                                                        imageError:
                                                                            "assets/images/placeholder.png",
                                                                      ),
                                                                    )),
                                                              ),
                                                            ),
                                                            AppConstant
                                                                .customSizedBox(
                                                                    20, 0),
                                                            Text(state
                                                                    .followers!
                                                                    .suppliers![
                                                                        index]
                                                                    .supplierName ??
                                                                ""),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          context.read<ShopsCubit>().follow(
                                                              context,
                                                              state
                                                                      .followers!
                                                                      .suppliers![
                                                                          index]
                                                                      .supplierId ??
                                                                  "",
                                                              fromProfile:
                                                                  true);
                                                        },
                                                        child: Text("unfollow"
                                                            .tr(context)))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ));
      },
    );
  }
}
