// ignore_for_file: must_be_immutable, deprecated_member_use, unnecessary_null_comparison

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/Locale/cubit/locale_cubit.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/user/home/presentation/cubit/home_state.dart';
import 'package:sheek_bazar/features/user/profile/presentation/cubit/profile_cubit.dart';
import 'package:sheek_bazar/features/user/shops/presentation/pages/shopDetails_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../../core/utils/app_colors.dart';

import '../../../../../core/utils/cache_helper.dart';
import '../../../categories/presentation/pages/categories_screen.dart';
import '../../data/models/home_model.dart';
import '../cubit/home_cubit.dart';
import '../pages/product_details.dart';

class HomeBanners extends StatefulWidget {
  const HomeBanners({
    super.key,
  });

  @override
  State<HomeBanners> createState() => _HomeBannersState();
}

class _HomeBannersState extends State<HomeBanners> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var items = [];
    // if (context.select((HomeCubit cubit) => cubit.state.response) != null) {
    //   for (int i = 0;
    //       i <
    //           context.select(
    //               (HomeCubit cubit) => cubit.state.response!.banners!.length);
    //       i++) {
    //     items.add(

    //     );
    //   }
    // }
    // List<Widget> widgets = items.cast<Widget>();

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return state.response == null
            ? const SizedBox()
            : state.response!.banners == null
                ? const SizedBox()
                : state.response!.banners!.isEmpty
                    ? const SizedBox()
                    : SizedBox(
                        height: 0.27.sh,
                        child: FlutterCarousel(
                          options: FlutterCarouselOptions(
                            height: 0.5.sh,
                            initialPage: 0,
                            viewportFraction: 1,
                            aspectRatio: 1,
                            enableInfiniteScroll: false,
                            reverse: false,
                            autoPlay: false,
                            autoPlayInterval: const Duration(seconds: 2),
                            autoPlayAnimationDuration:
                                const Duration(seconds: 1),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: state.response?.banners == null
                              ? []
                              : [
                                  for (int i = 0;
                                      i < state.response!.banners!.length;
                                      i++)
                                    BlocBuilder<HomeCubit, HomeState>(
                                      builder: (context, state) {
                                        return InkWell(
                                          onTap: () {
                                            if (state.response!.banners![i]
                                                    .targetType ==
                                                "none") {
                                            } else if (state.response!
                                                    .banners![i].targetType ==
                                                "product") {
                                              AppConstant.customNavigation(
                                                  context,
                                                  ProductDetailsScreen(
                                                      productId: state
                                                          .response!
                                                          .banners![i]
                                                          .productId!),
                                                  -1,
                                                  0);
                                            } else {
                                              AppConstant.customNavigation(
                                                  context,
                                                  ShopDetailsScreen(
                                                    supplierId: state
                                                        .response!
                                                        .banners![i]
                                                        .supplierId!,
                                                  ),
                                                  -1,
                                                  0);
                                            }
                                          },
                                          child: SizedBox(
                                            width: 1.sw,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(30.r),
                                                  bottomLeft:
                                                      Radius.circular(30.r)),
                                              child: AppConstant
                                                  .customNetworkImage(
                                                width: 1.sw,
                                                fit: BoxFit.fill,
                                                imagePath: state
                                                        .response!
                                                        .banners![i]
                                                        .bannerImg ??
                                                    '',
                                                imageError:
                                                    "assets/images/placeholder.png",
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                ],
                        ),
                      );
      },
    );
  }
}

//////________ Categories Section ________//////
class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return state.response == null
            ? const SizedBox()
            : state.response!.categories == null
                ? const SizedBox()
                : state.response!.categories!.isEmpty
                    ? const SizedBox()
                    : Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Categories".tr(context),
                                  style: TextStyle(fontSize: 50.sp),
                                ),
                                InkWell(
                                  onTap: () {
                                    AppConstant.customNavigation(
                                        context, CategoriesScreen(), 0, -1);
                                  },
                                  child: Text(
                                    "All_categories".tr(context),
                                    style: TextStyle(
                                        color: AppColors.greyColor,
                                        fontSize: 30.sp),
                                  ),
                                )
                              ],
                            ),
                          ),
                          AppConstant.customSizedBox(0, 30),
                          SizedBox(
                            height: 350.h,
                            child: ListView.builder(
                              itemCount: state.response!.categories!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 30.w),
                                  child: InkWell(
                                    onTap: () {
                                      AppConstant.customNavigation(
                                          context,
                                          CategoriesScreen(initialIndex: index),
                                          -1,
                                          0);
                                    },
                                    child: Column(
                                      children: [
                                        ClipOval(
                                          child: Container(
                                              width: 150.w,
                                              height: 150.w,
                                              color: Colors.black,
                                              child: ClipOval(
                                                child: AppConstant
                                                    .customNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imagePath: state
                                                          .response!
                                                          .categories![index]
                                                          .categoryImg ??
                                                      '',
                                                  imageError:
                                                      "assets/images/placeholder.png",
                                                ),
                                              )),
                                        ),
                                        AppConstant.customSizedBox(0, 10),
                                        BlocBuilder<LocaleCubit,
                                            ChangeLocaleState>(
                                          builder: (context, value) {
                                            return Text(
                                              value.locale.languageCode == 'en'
                                                  ? state
                                                      .response!
                                                      .categories![index]
                                                      .categoryNameEn!
                                                  : value.locale.languageCode ==
                                                          'ar'
                                                      ? state
                                                          .response!
                                                          .categories![index]
                                                          .categoryNameAr!
                                                      : state
                                                          .response!
                                                          .categories![index]
                                                          .categoryNameKu!,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 40.sp),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
      },
    );
  }
}

//////________ widget to show items in Home screen ________//////
class PopularItemsWidget extends StatefulWidget {
  final bool showSearchField;
  const PopularItemsWidget({super.key, required this.showSearchField});

  @override
  State<PopularItemsWidget> createState() => _PopularItemsWidgetState();
}

class _PopularItemsWidgetState extends State<PopularItemsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return state.products == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "no_products".tr(context),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Image.asset("assets/images/empty.png"),
                ],
              )
            : state.loadingData!
                ? const CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  )
                : state.products!.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "no_products".tr(context),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Image.asset("assets/images/empty.png"),
                        ],
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "popular_items".tr(context),
                                  style: TextStyle(fontSize: 50.sp),
                                ),
                                // Text(
                                //   "view_all".tr(context),
                                //   style: TextStyle(
                                //       color: AppColors.greyColor, fontSize: 30.sp),
                                // ),
                              ],
                            ),
                          ),
                          AppConstant.customSizedBox(0, 30),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.products!.length + 1,
                            itemBuilder: (context, index) {
                              if (index < state.products!.length) {
                                return BlocBuilder<LocaleCubit,
                                    ChangeLocaleState>(
                                  builder: (context, value) {
                                    return Item(
                                      fromHomePage: true,
                                      productPoints:
                                          state.products![index].productPoints!,
                                      isUsed: state.products![index].isUsed!,
                                      supplierId:
                                          state.products![index].supplierId!,
                                      postImage: "",
                                      postsImages:
                                          state.products![index].productImg,
                                      title: value.locale.languageCode == 'en'
                                          ? state
                                              .products![index].productNameEn!
                                          : value.locale.languageCode == 'ar'
                                              ? state.products![index]
                                                  .productNameAr!
                                              : state.products![index]
                                                  .productNameKu!,
                                      description: value.locale.languageCode ==
                                              'en'
                                          ? state.products![index]
                                              .productParagraphEn!
                                          : value.locale.languageCode == 'ar'
                                              ? state.products![index]
                                                  .productParagraphAr!
                                              : state.products![index]
                                                  .productParagraphKu!,
                                      shopTitle:
                                          state.products![index].supplierName!,
                                      shopImage:
                                          state.products![index].supplierLogo!,
                                      price: state
                                          .products![index].productFinalPrice!,
                                      priceBeforeDiscount:
                                          state.products![index].productPrice,
                                      discount: state
                                          .products![index].productDiscount,
                                      productId:
                                          state.products![index].productId!,
                                      id: null,
                                    );
                                  },
                                );
                              } else {
                                return widget.showSearchField
                                    ? SizedBox(
                                        height: 100.h,
                                      )
                                    : Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 30.h),
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      );
                              }
                            },
                          ),
                        ],
                      );
      },
    );
  }
}

//////________ one item widget that show in popular items ________//////
class Item extends StatefulWidget {
  String? postImage;
  List<ProductImg>? postsImages;
  bool? fromHomePage;
  String? isUsed;
  String? shopImage;
  String? shopTitle;
  String? description;
  String? price;
  String? title;
  String? productId;
  String? id;
  String? priceBeforeDiscount;
  String? discount;
  String? supplierId;
  String? productPoints;
  bool fromFav;
  bool fromSuggested;
  Item(
      {super.key,
      required this.postImage,
      this.postsImages,
      this.fromHomePage = false,
      this.isUsed,
      this.productPoints,
      required this.shopTitle,
      required this.supplierId,
      required this.shopImage,
      required this.price,
      required this.priceBeforeDiscount,
      required this.discount,
      required this.title,
      required this.id,
      required this.productId,
      this.fromFav = false,
      this.fromSuggested = false,
      required this.description});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  String? userId;
  Future<void> fetchData() async {
    setState(() {
      userId = CacheHelper.getData(key: "USER_ID");
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc(Match match) => '${match[1]},';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
      child: InkWell(
        onTap: () {
          widget.fromSuggested
              ? Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailsScreen(productId: widget.productId!)),
                )
              : AppConstant.customNavigation(context,
                  ProductDetailsScreen(productId: widget.productId!), -1, 0);
        },
        child: BlocBuilder<ThemesCubit, ThemesState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10.0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  color: state.mode == "dark"
                      ? AppColors.primaryColor
                      : AppColors.whiteColor),
              child: Padding(
                padding: EdgeInsets.all(50.0.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        widget.fromFav
                            ? Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      context
                                          .read<ProfileCubit>()
                                          .deleteFromMyFavorite(
                                              context, widget.id!);
                                    },
                                    child: Icon(
                                      Icons.highlight_remove_rounded,
                                      color: Colors.red,
                                      size: 75.sp,
                                    ),
                                  ),
                                  AppConstant.customSizedBox(20, 0)
                                ],
                              )
                            : const SizedBox(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            widget.shopImage == null ||
                                    widget.supplierId == null
                                ? const SizedBox()
                                : InkWell(
                                    onTap: () {
                                      AppConstant.customNavigation(
                                          context,
                                          ShopDetailsScreen(
                                            supplierId: widget.supplierId!,
                                          ),
                                          -1,
                                          0);
                                    },
                                    child: ClipOval(
                                      child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: state.mode == "dark"
                                                  ? Colors.white
                                                  : AppColors.primaryColor,
                                              width: 1.0,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          width: 120.w,
                                          height: 120.w,
                                          child: ClipOval(
                                            child:
                                                AppConstant.customNetworkImage(
                                              fit: BoxFit.cover,
                                              imagePath: widget.shopImage!,
                                              imageError:
                                                  "assets/images/placeholder.png",
                                            ),
                                          )),
                                    ),
                                  ),
                            AppConstant.customSizedBox(25.0, 0),
                            widget.shopTitle == null ||
                                    widget.supplierId == null
                                ? const SizedBox()
                                : InkWell(
                                    onTap: () {
                                      AppConstant.customNavigation(
                                          context,
                                          ShopDetailsScreen(
                                            supplierId: widget.supplierId!,
                                          ),
                                          -1,
                                          0);
                                    },
                                    child: Text(
                                      widget.shopTitle!,
                                      style: TextStyle(
                                          fontSize: 50.0.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                          ],
                        ),
                        widget.fromHomePage!
                            ? widget.isUsed == "1"
                                ? Text(
                                    "is_used".tr(context),
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  )
                                : const SizedBox()
                            : const SizedBox()
                      ],
                    ),
                    AppConstant.customSizedBox(0, 20.0),
                    // BoxFit.cover
                    widget.fromHomePage!
                        ? widget.postsImages == null
                            ? const SizedBox()
                            : BannersForPostImages(items: widget.postsImages!)
                        : SizedBox(
                            height: 0.35.sh,
                            width: double.maxFinite,
                            child: AppConstant.customNetworkImage(
                              fit: BoxFit.contain,
                              imagePath: widget.postImage!,
                              imageError: "assets/images/placeholder.png",
                            ),
                          ),
                    AppConstant.customSizedBox(0.0, 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.description == null || widget.title == null
                            ? const SizedBox()
                            : Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    widget.title == null
                                        ? const SizedBox()
                                        : Text(
                                            widget.title!,
                                            style: TextStyle(
                                                fontSize: 35.sp,
                                                height: 1.5,
                                                fontWeight: FontWeight.bold),
                                          ),
                                    AppConstant.customSizedBox(0, 20),
                                    widget.description == null
                                        ? const SizedBox()
                                        : widget.description!.length <= 75
                                            ? Text(
                                                "${widget.description}",
                                                style: TextStyle(
                                                    fontSize: 35.sp, height: 1),
                                              )
                                            : RichText(
                                                text: TextSpan(
                                                  text: widget.description!
                                                      .substring(0, 75),
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontSize: 35.sp,
                                                      height: 1),
                                                  children: [
                                                    TextSpan(
                                                      text: " .......see more",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 35
                                                            .sp, // Match previous font size
                                                        height: 1,
                                                        color: Colors
                                                            .grey, // Change color or other stylistic elements
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                  ],
                                ),
                              ),
                        AppConstant.customSizedBox(20.0, 0),
                        AppConstant.customAddFavoriteIcon(
                            fromFav: widget.fromFav,
                            productId: widget.productId,
                            userId: userId)
                      ],
                    ),
                    AppConstant.customSizedBox(0, 20.0),
                    widget.fromHomePage!
                        ? widget.productPoints == null
                            ? const SizedBox()
                            : Text(
                                "${"product_points".tr(context)}  ${widget.productPoints.toString().replaceAllMapped(reg, mathFunc)} ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 50.sp),
                              )
                        : const SizedBox(),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.discount == "0"
                            ? const SizedBox()
                            : widget.priceBeforeDiscount == null
                                ? const SizedBox()
                                : Text(
                                    "${widget.priceBeforeDiscount.toString().replaceAllMapped(reg, mathFunc)} د.ع",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 50.sp,
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.red,
                                      decorationColor: Colors.red,
                                    ),
                                  ),
                        AppConstant.customSizedBox(20, 0),
                        widget.price == null
                            ? const SizedBox()
                            : Text(
                                "${widget.price.toString().replaceAllMapped(reg, mathFunc)} د.ع",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 50.sp),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class BannersForPostImages extends StatefulWidget {
  final List<ProductImg> items;
  const BannersForPostImages({super.key, required this.items});

  @override
  State<BannersForPostImages> createState() => _BannersForPostImagesState();
}

class _BannersForPostImagesState extends State<BannersForPostImages> {
  List items = [];
  @override
  void initState() {
    super.initState();
    addToItems();
  }

  String? lengthOfItems;
  Future addToItems<List>() async {
    items = [];
    setState(() {
      lengthOfItems = widget.items.length.toString();
      for (int i = 0; i < widget.items.length; i++) {
        items.add(widget.items[i].attachmentType == "img"
            ? ClipRRect(
                borderRadius: BorderRadius.circular(30.r),
                child: AppConstant.customNetworkImage(
                  imagePath: widget.items[i].attachmentName!,
                ),
              )
            : SizedBox(
                child: Center(
                  child: VideoPlayerWidgetForPost(
                      videoUrl: widget.items[i].attachmentName!,
                      uniqueNumber: i.toString()),
                ),
              ));
      }
    });
  }

  String initialPage = "1";

  @override
  Widget build(BuildContext context) {
    addToItems();

    List<Widget> widgets = items.cast<Widget>();
    setState(() {
      widgets = items.cast<Widget>();
    });
    return widget.items == null
        ? const SizedBox()
        : widget.items.isEmpty
            ? const SizedBox()
            : Padding(
                padding: EdgeInsets.all(30.sp),
                child: SizedBox(
                  width: 0.9.sw,
                  child: Column(
                    children: [
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          return FlutterCarousel(
                            options: FlutterCarouselOptions(
                              height: 0.5.sh,
                              initialPage: 0,
                              viewportFraction: 1,
                              aspectRatio: 1,
                              enableInfiniteScroll: false,
                              reverse: false,
                              autoPlay: false,
                              autoPlayInterval: const Duration(seconds: 2),
                              autoPlayAnimationDuration:
                                  const Duration(seconds: 1),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                              onPageChanged: (index, reason) {
                                if (widget.items[index].attachmentType ==
                                    "img") {
                                  context
                                      .read<HomeCubit>()
                                      .changeIsVideoToFalse();
                                } else {
                                  context
                                      .read<HomeCubit>()
                                      .changeIsVideoToTrue();
                                }
                                setState(() {
                                  initialPage = "${index + 1}";
                                });
                              },
                            ),
                            items: widgets,
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "$initialPage / $lengthOfItems",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
  }
}

class VideoPlayerWidgetForPost extends StatefulWidget {
  final String videoUrl, uniqueNumber;

  const VideoPlayerWidgetForPost({
    super.key,
    required this.videoUrl,
    required this.uniqueNumber,
  });

  @override
  State<VideoPlayerWidgetForPost> createState() =>
      _VideoPlayerWidgetForPostState();
}

class _VideoPlayerWidgetForPostState extends State<VideoPlayerWidgetForPost> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializedVideoPlayerFuture;
  bool _isMuted = true;
  bool _isPaused = true;

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;

      if (_isPaused) {
        _videoPlayerController.play();
      } else {
        _videoPlayerController.pause();
      }
      context.read<HomeCubit>().changeplayVideoStatus(_isPaused);
    });
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _videoPlayerController.setVolume(_isMuted ? 0.0 : 1.0);
      context.read<HomeCubit>().changemuteVideoStatus(_isMuted);
    });
  }

  int randomNumber = 0;
  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _initializedVideoPlayerFuture =
        _videoPlayerController.initialize().then((_) {
      _videoPlayerController.setLooping(true);
    });
    final random = Random();
    randomNumber = random.nextInt(1000);

    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return VisibilityDetector(
              key: Key(widget.videoUrl + randomNumber.toString()),
              onVisibilityChanged: (visibilityInfo) {
                if (visibilityInfo.visibleFraction == 1) {
                  setState(() {
                    _isPaused = state.playVideo!;
                    _isMuted = state.muteVideo!;
                  });
                  state.playVideo!
                      ? _videoPlayerController.play()
                      : _videoPlayerController.pause();
                  state.muteVideo!
                      ? _videoPlayerController.setVolume(0.0)
                      : _videoPlayerController.setVolume(1.0);
                } else {
                  _videoPlayerController.pause();
                  setState(() {
                    _isPaused = false;
                  });
                }
              },
              child: FutureBuilder(
                  future: _initializedVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(30.r),
                        child: Stack(fit: StackFit.expand, children: [
                          AspectRatio(
                            aspectRatio:
                                _videoPlayerController.value.aspectRatio,
                            child: VideoPlayer(_videoPlayerController),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Column(
                              children: [
                                IconButton(
                                  icon: Icon(_isMuted
                                      ? Icons.volume_off
                                      : Icons.volume_up),
                                  onPressed: () {
                                    _toggleMute();
                                  },
                                ),
                                IconButton(
                                  icon: Icon(!_isPaused
                                      ? Icons.play_arrow
                                      : Icons.pause),
                                  onPressed: _togglePause,
                                ),
                              ],
                            ),
                          ),
                        ]),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      );
                    }
                  }),
            );
          },
        );
      },
    );
  }
}
