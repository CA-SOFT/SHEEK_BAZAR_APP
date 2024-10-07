// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, deprecated_member_use, prefer_const_constructors_in_immutables, avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/Locale/cubit/locale_cubit.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
import 'package:sheek_bazar/core/utils/app_colors.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/user/cart/presentation/cubit/cart_cubit.dart';
import 'package:sheek_bazar/features/user/cart/presentation/pages/cart_screen.dart';
import 'package:sheek_bazar/features/user/home/presentation/cubit/home_cubit.dart';
import 'package:sheek_bazar/features/user/home/presentation/cubit/home_state.dart';
import 'package:sheek_bazar/features/user/home/presentation/pages/images_screen.dart';
import 'package:sheek_bazar/features/user/home/presentation/widgets/home_widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../../../../join_with_us.dart';
import '../../data/models/productDetails_model.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final bool fromProductDetails;

  VideoPlayerWidget({
    super.key,
    required this.videoUrl,
    this.fromProductDetails = false,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializedVideoPlayerFuture;
  bool _isMuted = false;
  bool _isPaused = false;

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;

      if (_isPaused) {
        _videoPlayerController.pause();
        if (widget.fromProductDetails) {
          context.read<HomeCubit>().changeIsVideoToFalse();
        }
      } else {
        _videoPlayerController.play();

        if (widget.fromProductDetails) {
          context.read<HomeCubit>().changeIsVideoToTrue();
        }
      }
    });
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _videoPlayerController.setVolume(_isMuted ? 0.0 : 1.0);
    });
  }

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _initializedVideoPlayerFuture =
        _videoPlayerController.initialize().then((_) {
      _videoPlayerController.play();
      _videoPlayerController.setLooping(true);
    });
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
        if (widget.fromProductDetails) {
          if (state.isVideo == false) {
            _videoPlayerController.pause();
          } else {
            _videoPlayerController.play();
          }
        }
        return FutureBuilder(
            future: _initializedVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(30.r),
                  child: Stack(
                      fit: widget.fromProductDetails
                          ? StackFit.expand
                          : StackFit.passthrough,
                      children: [
                        AspectRatio(
                          aspectRatio: _videoPlayerController.value.aspectRatio,
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
                                icon: Icon(widget.fromProductDetails
                                    ? state.isVideo!
                                        ? Icons.pause
                                        : Icons.play_arrow
                                    : _isPaused
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
            });
      },
    );
  }
}

class ColorsSections extends StatelessWidget {
  ColorsSections({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(50.0.sp),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "select_color".tr(context),
                style: TextStyle(fontSize: 50.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          AppConstant.customSizedBox(0, 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
              builder: (context, state) {
                return Row(
                  children: [
                    for (int i = 0;
                        i < state.productDetails!.productColors!.length;
                        i++)
                      Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: InkWell(
                          onTap: () {
                            context.read<CartCubit>().selectedColor(context, i);
                            context.read<CartCubit>().changeproductColor(state
                                .productDetails!.productColors![i].colorHex!);
                          },
                          child: BlocBuilder<CartCubit, CartState>(
                            builder: (context, value) {
                              return CircleAvatar(
                                radius: 80.sp,
                                backgroundColor: AppColors.primaryColor,
                                child: CircleAvatar(
                                  radius: 75.sp,
                                  backgroundColor: AppConstant.getColorFromHex(
                                      state.productDetails!.productColors![i]
                                          .colorHex!),
                                  child: value.active == i
                                      ? CircleAvatar(
                                          radius: 55.sp,
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          child: CircleAvatar(
                                            radius: 50.sp,
                                            backgroundColor:
                                                AppColors.whiteColor,
                                            child: Icon(
                                              Icons.check,
                                              size: 50.sp,
                                              color: state
                                                          .productDetails!
                                                          .productColors![i]
                                                          .colorHex ==
                                                      "#ffffff"
                                                  ? AppColors.primaryColor
                                                  : AppConstant.getColorFromHex(
                                                      state
                                                          .productDetails!
                                                          .productColors![i]
                                                          .colorHex!),
                                            ),
                                          ),
                                        )
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class SizesSections extends StatelessWidget {
  SizesSections({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(50.0.sp),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "select_size".tr(context),
                style: TextStyle(fontSize: 50.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          AppConstant.customSizedBox(0, 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0;
                        i < state.productDetails!.productSizes!.length;
                        i++)
                      Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: InkWell(
                          onTap: () {
                            context.read<CartCubit>().selectedSize(context, i);
                            context.read<CartCubit>().changeproductSize(state
                                .productDetails!.productSizes![i].sizeName!);
                          },
                          child: BlocBuilder<CartCubit, CartState>(
                            builder: (context, value) {
                              return CircleAvatar(
                                  backgroundColor: value.activeSize == i
                                      ? AppColors.greyColor
                                      : AppColors.primaryColor,
                                  radius: 75.sp,
                                  child: Text(
                                    state.productDetails!.productSizes![i]
                                        .sizeName!,
                                    style: TextStyle(
                                      color: value.activeSize == i
                                          ? AppColors.primaryColor
                                          : AppColors.whiteColor,
                                      fontWeight: value.activeSize == i
                                          ? FontWeight.bold
                                          : FontWeight.w300,
                                    ),
                                  ));
                            },
                          ),
                        ),
                      )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class SuggestionProduct extends StatelessWidget {
  List<SimilarProducts>? similarProducts;
  SuggestionProduct({super.key, required this.similarProducts});

  @override
  Widget build(BuildContext context) {
    return similarProducts == null
        ? const SizedBox()
        : Padding(
            padding: EdgeInsets.all(50.0.sp),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "suggested_product".tr(context),
                      style: TextStyle(
                          fontSize: 50.sp, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                AppConstant.customSizedBox(0, 15),
                for (int i = 0; i < similarProducts!.length; i++)
                  BlocBuilder<LocaleCubit, ChangeLocaleState>(
                    builder: (context, value) {
                      return Item(
                          supplierId: similarProducts![i].supplierId,
                          discount: similarProducts![i].productDiscount,
                          priceBeforeDiscount: similarProducts![i].productPrice,
                          fromSuggested: true,
                          title: value.locale.languageCode == "en"
                              ? similarProducts![i].productNameEn
                              : value.locale.languageCode == "ar"
                                  ? similarProducts![i].productNameAr
                                  : similarProducts![i].productNameKu,
                          postImage: similarProducts![i].productImg,
                          shopTitle: similarProducts![i].supplierName,
                          shopImage: similarProducts![i].supplierLogo,
                          price: similarProducts![i].productFinalPrice,
                          id: null,
                          productId: similarProducts![i].productId,
                          description: value.locale.languageCode == "en"
                              ? similarProducts![i].productParagraphEn
                              : value.locale.languageCode == "ar"
                                  ? similarProducts![i].productParagraphAr
                                  : similarProducts![i].productParagraphKu);
                    },
                  )
              ],
            ),
          );
  }
}

class CustomBottomNavigation extends StatelessWidget {
  bool isNotGuest;
  BuildContext newContext;
  CustomBottomNavigation(
      {super.key, required this.isNotGuest, required this.newContext});

  Future<void> openWhatsApp(
      String whatsappNumber, String encodedMessage, String ImageUrl) async {
    if (whatsappNumber.startsWith('0')) {
      whatsappNumber = whatsappNumber.replaceFirst('0', '+964');
    }
    String url = Uri.encodeFull(
        'https://wa.me/$whatsappNumber?text=$encodedMessage \n \n $ImageUrl');
    await canLaunch(url) ? launch(url) : print('WhatsApp not installed');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(25.0.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  return SizedBox(
                    height: 150.h,
                    width: 750.w,
                    child: state.loadingInsertRoCart
                        ? AppConstant.customLoadingElvatedButton(context)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(50.r),
                            child: BlocBuilder<ProductDetailsCubit,
                                ProductDetailsState>(
                              builder: (context, value) {
                                return ElevatedButton(
                                    onPressed: () {
                                      if (value.productDetails!.mainInfo![0]
                                              .isOutOfStock! ==
                                          "1") {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor:
                                                AppColors.primaryColor,
                                            padding: EdgeInsets.only(
                                                bottom: 150.h,
                                                top: 50.h,
                                                left: 50.w,
                                                right: 50.w),
                                            content: Text(
                                                'out_of_stock'.tr(context)),
                                            duration: const Duration(
                                                seconds:
                                                    2), // Optional duration
                                          ),
                                        );
                                      } else {
                                        if (isNotGuest == false) {
                                          AppConstant.customNavigation(context,
                                              const JoinWithUsScreen(), -1, 0);
                                        } else {
                                          if (state.showCounter) {
                                            print(value
                                                .productDetails!.productColors);
                                            print(value
                                                .productDetails!.productSizes);
                                            if (value.productDetails!
                                                    .productColors ==
                                                null) {
                                              context
                                                  .read<CartCubit>()
                                                  .changeproductColor("-");
                                            }
                                            if (value.productDetails!
                                                    .productSizes ==
                                                null) {
                                              context
                                                  .read<CartCubit>()
                                                  .changeproductSize("-");
                                            }
                                            context
                                                .read<CartCubit>()
                                                .insertIntoCart(newContext);
                                          } else {
                                            context
                                                .read<CartCubit>()
                                                .changeshowCounter();
                                          }
                                        }
                                      }
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        AppColors.primaryColor,
                                      ),
                                    ),
                                    child: Text(
                                      "Add_to_cart".tr(context),
                                      style: const TextStyle(
                                          color: AppColors.whiteColor),
                                    ));
                              },
                            ),
                          ),
                  );
                },
              ),
              state.showCounter
                  ? Row(
                      children: [
                        InkWell(
                          onTap: () {
                            context
                                .read<CartCubit>()
                                .changeProductQuantity("add");
                          },
                          child: CircleAvatar(
                            backgroundColor: AppColors.primaryColor,
                            radius: 50.sp,
                            child: const Center(
                                child: Icon(
                              Icons.add,
                              color: AppColors.whiteColor,
                            )),
                          ),
                        ),
                        AppConstant.customSizedBox(15, 0),
                        Text(
                          "${state.productQuantity}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 50.sp),
                        ),
                        AppConstant.customSizedBox(15, 0),
                        InkWell(
                          onTap: () {
                            context
                                .read<CartCubit>()
                                .changeProductQuantity("remove");
                          },
                          child: CircleAvatar(
                            backgroundColor: AppColors.primaryColor,
                            radius: 50.sp,
                            child: const Center(
                                child: Icon(
                              Icons.remove,
                              color: AppColors.whiteColor,
                            )),
                          ),
                        ),
                      ],
                    )
                  : BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BlocBuilder<ThemesCubit, ThemesState>(
                              builder: (context, theme) {
                                return InkWell(
                                    onTap: () async {
                                      await openWhatsApp(
                                          state.productDetails!.mainInfo![0]
                                                  .supplierPhone ??
                                              "",
                                          "اريد الاستفسار عن هذا المنتج",
                                          state.productDetails!
                                                      .productAttachments ==
                                                  null
                                              ? ""
                                              : state
                                                      .productDetails!
                                                      .productAttachments![0]
                                                      .attachmentName ??
                                                  "");
                                    },
                                    child: Image.asset(
                                      "assets/images/whatsapp_logo.png",
                                      height: 125.h,
                                    ));
                              },
                            ),
                            AppConstant.customSizedBox(25, 0),
                            Container(
                              width: 125.w,
                              height: 125.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.primaryColor, width: 5.sp),
                              ),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    AppConstant.customNavigation(
                                        context, const CartScreen(), -1, 0);
                                  },
                                  child: Icon(
                                    Icons.shopping_cart,
                                    size: 75.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    )
            ],
          ),
        );
      },
    );
  }
}

////////////////////

class BannersForProductImage extends StatefulWidget {
  final List<ProductAttachments> items;
  const BannersForProductImage({super.key, required this.items});

  @override
  State<BannersForProductImage> createState() => _BannersForProductImageState();
}

class _BannersForProductImageState extends State<BannersForProductImage> {
  List items = [];

  @override
  void initState() {
    super.initState();
    addToItems();
  }

  Future addToItems<List>() async {
    for (int i = 0; i < widget.items.length; i++) {
      items.add(widget.items[i].attachmentType == "img"
          ? InkWell(
              onTap: () {
                AppConstant.customNavigation(
                    context, ImagesScreen(items: widget.items), 0, -1);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.r),
                child: AppConstant.customNetworkImage(
                  width: 0.55.sw,
                  fit: BoxFit.cover,
                  imagePath: widget.items[i].attachmentName!,
                ),
              ),
            )
          : InkWell(
              onTap: () {
                AppConstant.customNavigation(
                    context, ImagesScreen(items: widget.items), 0, -1);
              },
              child: SizedBox(
                width: 0.55.sw,
                child: Center(
                  child: VideoPlayerWidget(
                    fromProductDetails: true,
                    videoUrl: widget.items[i].attachmentName!,
                  ),
                ),
              ),
            ));
    }
  }

  String initialPage = "1";

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = items.cast<Widget>();

    return Padding(
      padding: EdgeInsets.all(30.sp),
      child: SizedBox(
        width: 0.8.sw,
        height: 0.45.sh,
        child: Column(
          children: [
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return FlutterCarousel(
                  options: FlutterCarouselOptions(
                    height: 0.4.sh,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    reverse: false,
                    autoPlay: false,
                    autoPlayInterval: const Duration(seconds: 2),
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      if (widget.items[index].attachmentType == "img") {
                        context.read<HomeCubit>().changeIsVideoToFalse();
                      } else {
                        context.read<HomeCubit>().changeIsVideoToTrue();
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
                  "$initialPage / ${widget.items.length}",
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
