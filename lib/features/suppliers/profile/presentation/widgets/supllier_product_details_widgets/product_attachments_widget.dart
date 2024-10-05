// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously, must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/suppliers/add_product/presentation/pages/attachment_screen.dart';
import 'package:sheek_bazar/features/suppliers/profile/presentation/cubit/profile_cubit.dart';
import 'package:sheek_bazar/features/user/home/data/models/productDetails_model.dart';

class SupllierProductAttachments extends StatefulWidget {
  List<ProductAttachments>? productAttachments;

  SupllierProductAttachments({super.key, required this.productAttachments});

  @override
  State<SupllierProductAttachments> createState() => _ProductAttachmentsState();
}

class _ProductAttachmentsState extends State<SupllierProductAttachments> {
  String initialPage = "1";
  String initialNewPage = "1";
  List<SelectedMedia?> selectedMedia = [];
  final picker = ImagePicker();
  bool allowsImages = true;
  bool allowsVideos = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<SupplierProfileCubit, ProfileState>(
          builder: (context, state) {
            return state.bannerItems == null
                ? const SizedBox()
                : state.bannerItems!.isEmpty
                    ? const SizedBox()
                    : Padding(
                        padding: EdgeInsets.all(30.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "old_attachment".tr(context),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 50.sp),
                            ),
                            AppConstant.customSizedBox(0, 10),
                            SizedBox(
                              width: 0.9.sw,
                              child: Column(
                                children: [
                                  FlutterCarousel(
                                    options: FlutterCarouselOptions(
                                      height: 0.5.sh,
                                      initialPage: 0,
                                      viewportFraction: 1,
                                      aspectRatio: 1,
                                      enableInfiniteScroll: false,
                                      reverse: false,
                                      autoPlay: false,
                                      autoPlayInterval:
                                          const Duration(seconds: 2),
                                      autoPlayAnimationDuration:
                                          const Duration(seconds: 1),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      enlargeCenterPage: true,
                                      scrollDirection: Axis.horizontal,
                                      onPageChanged: (index, reason) {
                                        if (widget.productAttachments![index]
                                                .attachmentType ==
                                            "img") {
                                        } else {}
                                        setState(() {
                                          initialPage = "${index + 1}";
                                        });
                                      },
                                    ),
                                    items: state.bannerItems,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "$initialPage / ${state.lengthOfBannerItems}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const Divider(),
                          ],
                        ),
                      );
          },
        ),
        BlocBuilder<SupplierProfileCubit, ProfileState>(
          builder: (context, state) {
            return state.newProductAttachments == null
                ? const SizedBox()
                : state.newProductAttachments!.isEmpty
                    ? const SizedBox()
                    : Padding(
                        padding: EdgeInsets.all(30.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "new_attachment".tr(context),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 50.sp),
                            ),
                            AppConstant.customSizedBox(0, 10),
                            SizedBox(
                              width: 0.9.sw,
                              child: Column(
                                children: [
                                  FlutterCarousel(
                                    options: FlutterCarouselOptions(
                                      height: 0.5.sh,
                                      initialPage: 0,
                                      viewportFraction: 1,
                                      aspectRatio: 1,
                                      enableInfiniteScroll: false,
                                      reverse: false,
                                      autoPlay: false,
                                      autoPlayInterval:
                                          const Duration(seconds: 2),
                                      autoPlayAnimationDuration:
                                          const Duration(seconds: 1),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      enlargeCenterPage: true,
                                      scrollDirection: Axis.horizontal,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          initialNewPage = "${index + 1}";
                                        });
                                      },
                                    ),
                                    items: state.loadedeAttachment,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "$initialNewPage / ${state.lengthNewOfBannerItems}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
          },
        ),
        BlocBuilder<SupplierProfileCubit, ProfileState>(
          builder: (context, state) {
            return state.canEdite!
                ? ElevatedButton(
                    child: Text('select_image_or_video'.tr(context)),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SafeArea(
                            child: Wrap(
                              children: <Widget>[
                                ListTile(
                                  leading: const Icon(Icons.photo_library),
                                  title: const Text('Gallery (Image)'),
                                  onTap: () {
                                    allowsImages = true;
                                    allowsVideos = false;
                                    selectMedia(ImageSource.gallery);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.camera_alt),
                                  title: const Text('Camera (Image)'),
                                  onTap: () {
                                    allowsImages = true;
                                    allowsVideos = false;
                                    selectMedia(ImageSource.camera);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.videocam),
                                  title: const Text('Gallery (Video)'),
                                  onTap: () {
                                    allowsImages = false;
                                    allowsVideos = true;
                                    selectMedia(ImageSource.gallery);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(
                                      Icons.video_camera_back_rounded),
                                  title: const Text('Camera (Video)'),
                                  onTap: () {
                                    allowsImages = false;
                                    allowsVideos = true;
                                    selectMedia(ImageSource.camera);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  )
                : const SizedBox();
          },
        ),
      ],
    );
  }

  Future selectMedia(ImageSource source) async {
    XFile? pickedFile;
    if (allowsImages && allowsVideos) {
      pickedFile = await picker.pickImage(source: source);
    } else if (allowsImages && !allowsVideos) {
      pickedFile = await picker.pickImage(source: source);
    } else {
      pickedFile = await picker.pickVideo(
        source: source,
        preferredCameraDevice: CameraDevice.front,
        maxDuration: const Duration(minutes: 10),
      );
    }
    if (pickedFile != null) {
      setState(() {
        selectedMedia.add(SelectedMedia(File(pickedFile!.path),
            allowsImages ? MediaType.image : MediaType.video));
      });
      context.read<SupplierProfileCubit>().addAttachmentToList(
          File(pickedFile.path), allowsImages ? "img" : "video", context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selection cancelled')),
      );
    }
  }
}
