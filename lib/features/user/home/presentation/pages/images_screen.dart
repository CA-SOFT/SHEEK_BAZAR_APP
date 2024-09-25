import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_constants.dart';
import '../../data/models/productDetails_model.dart';
import '../widgets/product_details_widgets.dart';

class ImagesScreen extends StatelessWidget {
  final List<ProductAttachments>? items;
  const ImagesScreen({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              for (int i = 0; i < items!.length; i++)
                items![i].attachmentType == "img"
                    ? Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: 300,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.r),
                            child: AppConstant.customNetworkImage(
                              fit: BoxFit.cover,
                              imagePath: items![i].attachmentName!,
                              imageError: "assets/images/placeholder.png",
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: 0.5.sh,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.r),
                            child: VideoPlayerWidget(
                                videoUrl: items![i].attachmentName!),
                          ),
                        ),
                      ),
              AppConstant.customSizedBox(0, 30)
            ],
          ),
        ),
      ),
    );
  }
}
