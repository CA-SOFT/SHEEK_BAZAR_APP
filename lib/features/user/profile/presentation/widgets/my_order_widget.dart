// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
import 'package:sheek_bazar/core/utils/app_colors.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/user/profile/presentation/cubit/profile_cubit.dart';

import '../../data/models/orders_model.dart';
import '../pages/orderDetails_screen.dart';

class OrderCard extends StatelessWidget {
  final Orders order;
  var myPoints;
  final bool fromLaundry;
  OrderCard(
      {super.key,
      required this.order,
      this.fromLaundry = false,
      required this.myPoints});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20),
      child: BlocBuilder<ThemesCubit, ThemesState>(
        builder: (context, theme) {
          return Container(
            decoration: BoxDecoration(
              color: theme.mode == "dark"
                  ? AppColors.primaryColor
                  : AppColors.whiteColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.greyColor,
                  offset: Offset(4, 4),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(50.0.sp),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${"invoice_number".tr(context)} : # ${order.invoiceNumber}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 40.sp),
                            ),
                            AppConstant.customSizedBox(0, 35),
                            Text(
                              "${"final_amount".tr(context)} : ${order.grandTotal}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 40.sp),
                            ),
                            AppConstant.customSizedBox(0, 35),
                            Text(
                              "${"order_status".tr(context)} : ${order.orderStatus}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 40.sp),
                            ),
                            AppConstant.customSizedBox(0, 35),
                            Text(
                              "${"order_date".tr(context)} : ${order.createdAt}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 40.sp),
                            ),
                          ],
                        ),
                      ),
                      AppConstant.customSizedBox(40, 0),
                      order.orderStatus == "pending"
                          ? Icon(
                              Icons.pending_actions_rounded,
                              size: 150.sp,
                              color: Colors.blue,
                            )
                          : order.orderStatus == "confirmed"
                              ? Icon(
                                  Icons.check_box,
                                  size: 150.sp,
                                  color: Colors.yellow,
                                )
                              : order.orderStatus == "on_the_way"
                                  ? Icon(
                                      Icons.delivery_dining,
                                      size: 150.sp,
                                      color: Colors.pink[900],
                                    )
                                  : order.orderStatus == "deliverd"
                                      ? Icon(
                                          Icons.checklist_rounded,
                                          size: 150.sp,
                                          color: Colors.green,
                                        )
                                      : Icon(
                                          Icons.cancel_rounded,
                                          size: 150.sp,
                                          color: Colors.red,
                                        )
                    ],
                  ),
                  fromLaundry
                      ? const SizedBox()
                      : AppConstant.customSizedBox(0, 50),
                  fromLaundry
                      ? const SizedBox()
                      : AppConstant.customElvatedButton(
                          context, "order_details", () {
                          AppConstant.customNavigation(context,
                              OrderDetails(orderId: order.orderId!), -1, 0);
                        }),
                  order.isPaid != "0"
                      ? const SizedBox()
                      : AppConstant.customSizedBox(0, 50),
                  order.isPaid == "0"
                      ? BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, state) {
                            return state.loadingBuy
                                ? AppConstant.customLoadingElvatedButton(
                                    context)
                                : AppConstant.customElvatedButton(
                                    context,
                                    "Pay_now",
                                    () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            WayForPay(
                                          myPoints: "${myPoints}",
                                          order: order,
                                        ),
                                      );
                                    },
                                  );
                          },
                        )
                      : Padding(
                          padding: EdgeInsets.only(top: 30.h),
                          child: Text(
                            "payment_completed_successfully".tr(context),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class WayForPay extends StatefulWidget {
  final Orders order;
  String? myPoints;
  WayForPay({super.key, required this.order, required this.myPoints});

  @override
  State<WayForPay> createState() => _WayForPayState();
}

class _WayForPayState extends State<WayForPay> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<ThemesCubit, ThemesState>(
        builder: (context, theme) {
          return Container(
            width: 300.0,
            height: 200.0,
            decoration: BoxDecoration(
              color: theme.mode == "dark" ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Choose_payment_method'.tr(context),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  AppConstant.customSizedBox(0, 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => PointsWay(
                              myPoints: widget.myPoints,
                              order: widget.order,
                            ),
                          );
                        }, // Close the popup
                        child: Text('By_points'.tr(context)),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('By_payment_methods'.tr(context)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PointsWay extends StatefulWidget {
  final Orders order;
  String? myPoints;
  PointsWay({super.key, required this.myPoints, required this.order});

  @override
  State<PointsWay> createState() => _PointsWayState();
}

class _PointsWayState extends State<PointsWay> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<ThemesCubit, ThemesState>(
        builder: (context, theme) {
          return Container(
            width: 300.0,
            height: 200.0,
            decoration: BoxDecoration(
              color: theme.mode == "dark" ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'are_you_sure_for_pay'.tr(context),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('cancel'.tr(context)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          if (double.parse(widget.order.grandTotal!) <=
                              double.parse(widget.myPoints!)) {
                            context
                                .read<ProfileCubit>()
                                .bayByPoints(context, widget.order.orderId!);
                          } else {
                            AppConstant.customAlert(
                                context, "Sorry_you_dont_have_enough_points",
                                withTranslate: true);
                          }
                        },
                        child: Text('confirm'.tr(context)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

//  Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Order #12345",
//                 style:
//                     TextStyle(fontSize: 50.0.sp, fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 "shipped".tr(context),
//                 style: TextStyle(fontSize: 30.sp),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 400.h,
//           child: ListView.builder(
//             itemCount: 2,
//             itemBuilder: (context, index) {
//               return const Item();
//             },
//           ),
//         )
//       ],
//     );
class Item extends StatelessWidget {
  const Item({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250.0.w,
            width: 250.0.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              image: const DecorationImage(
                image: AssetImage("assets/images/onbording1.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          AppConstant.customSizedBox(20.0, 0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "#1515asdf",
                  style: TextStyle(color: AppColors.greyColor, fontSize: 35.sp),
                ),
                AppConstant.customSizedBox(0, 10),
                Text(
                  "best order best order best order best rdasdfa ",
                  style: TextStyle(fontSize: 35.sp),
                ),
                AppConstant.customSizedBox(0, 10),
                Text(
                  "240 \$",
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 35.sp,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
