// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sheek_bazar/Locale/app_localization.dart';

// import '../../../connection_screen.dart';
// import '../../../core/utils/app_colors.dart';

// part 'internet_state.dart';

// class InternetCubit extends Cubit<InternetState> {
//   InternetCubit() : super(InternetInitial());
//   StreamSubscription? _subscription;

//   void connected() {
//     emit(state.copyWith(message: "connected"));
//   }

//   void notConnected() {
//     emit(state.copyWith(message: "not connected"));
//   }

//   // void checkConnection() {
//   //   _subscription = Connectivity()
//   //       .onConnectivityChanged
//   //       .listen((ConnectivityResult result) {
//   //     if (result == ConnectivityResult.wifi ||
//   //         result == ConnectivityResult.mobile) {
//   //       if (state.firstTime) {
//   //         emit(state.copyWith(firstTime: false));
//   //       } else {
//   //         connected();
//   //       }
//   //     } else {
//   //       if (state.firstTime) {
//   //         emit(state.copyWith(firstTime: false));
//   //       }
//   //       notConnected();
//   //     }
//   //   });
//   // }

//   @override
//   Future<void> close() {
//     _subscription!.cancel();
//     return super.close();
//   }

//   Future whenOpenApp(context) async {
//     var result = await Connectivity().checkConnectivity();
//     if (result.name == "none") {
//       emit(state.copyWith(firstTime: false));

//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => const NoConnectionScreen()),
//         (Route route) => false,
//       );
//     }
//   }

//   showSnackBarForStatus(BuildContext context) {
//     if (state.message == "not connected") {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           showCloseIcon: true,
//           closeIconColor: AppColors.whiteColor,
//           backgroundColor: Colors.red,
//           padding: EdgeInsets.only(
//               bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
//           content: Text(
//             "not_connected".tr(context),
//             style: const TextStyle(color: AppColors.whiteColor),
//           ),
//         ),
//       );
//     } else if (state.message == "connected") {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           showCloseIcon: true,
//           closeIconColor: AppColors.whiteColor,
//           backgroundColor: Colors.green,
//           padding: EdgeInsets.only(
//               bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
//           content: Text(
//             "connected".tr(context),
//             style: const TextStyle(color: AppColors.whiteColor),
//           ),
//         ),
//       );
//     }
//   }
// }
