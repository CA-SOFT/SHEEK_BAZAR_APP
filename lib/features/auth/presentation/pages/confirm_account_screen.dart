// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
// import 'package:sheek_bazar/core/utils/app_colors.dart';
// import 'package:sheek_bazar/core/utils/app_constants.dart';
// import 'package:sheek_bazar/features/auth/presentation/cubit/auth_cubit.dart';
// import 'package:sheek_bazar/features/auth/presentation/pages/whatsapp_confirm_screen.dart';
// import 'package:sheek_bazar/features/auth/presentation/pages/forget_password_screen.dart';

// class ConfirmAccountScreen extends StatelessWidget {
//   const ConfirmAccountScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 // "choose_type".tr(context),
//                 "Choose Type for Confirm account",
//                 style: TextStyle(fontSize: 45.sp, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           BlocBuilder<ThemesCubit, ThemesState>(
//             builder: (context, theme) {
//               return BlocBuilder<AuthCubit, AuthState>(
//                 builder: (context, state) {
//                   return InkWell(
//                     onTap: () async {
//                       AppConstant.customNavigation(
//                           context, const WhatsappConfirmScreen(), -1, 0);
//                     },
//                     child: Container(
//                       width: 0.9.sw,
//                       height: 0.1.sh,
//                       padding: EdgeInsets.symmetric(
//                           horizontal: 50.w, vertical: 25.h),
//                       margin: EdgeInsets.symmetric(
//                           horizontal: 10.w, vertical: 50.h),
//                       decoration: BoxDecoration(
//                         color: theme.mode == "dark"
//                             ? AppColors.primaryColor
//                             : AppColors.whiteColor,
//                         borderRadius: BorderRadius.circular(10.0.sp),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.2),
//                             offset: const Offset(2.0, 2.0),
//                             blurRadius: 8.0,
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Image.asset(
//                             "assets/images/whatsapp_logo.jpeg",
//                             height: 100.h,
//                           ),
//                           Text(
//                             "Whatsapp",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 50.sp),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//           BlocBuilder<ThemesCubit, ThemesState>(
//             builder: (context, theme) {
//               return InkWell(
//                 onTap: () {
//                   AppConstant.customNavigation(
//                       context, ForgetPasswordScreen(fromSignUp: true), -1, 0);
//                 },
//                 child: Container(
//                   width: 0.5.sw,
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 75.w, vertical: 25.h),
//                   margin:
//                       EdgeInsets.symmetric(horizontal: 10.w, vertical: 50.h),
//                   decoration: BoxDecoration(
//                     color: theme.mode == "dark"
//                         ? AppColors.primaryColor
//                         : AppColors.whiteColor,
//                     borderRadius: BorderRadius.circular(10.0.sp),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.2),
//                         offset: const Offset(2.0, 2.0),
//                         blurRadius: 8.0,
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       CircleAvatar(
//                         backgroundColor: AppColors.primaryColor,
//                         radius: 50.sp,
//                         child: Icon(
//                           Icons.mail,
//                           color: AppColors.whiteColor,
//                           size: 50.sp,
//                         ),
//                       ),
//                       Text(
//                         "SMS",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 50.sp),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           )
//         ],
//       )),
//     );
//   }
// }
