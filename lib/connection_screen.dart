// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lottie/lottie.dart';
// import 'package:sheek_bazar/Locale/app_localization.dart';
// import 'package:sheek_bazar/core/utils/app_colors.dart';
// import 'package:sheek_bazar/sections_screen.dart';

// import 'config/internet/cubit/internet_cubit.dart';

// class NoConnectionScreen extends StatelessWidget {
//   const NoConnectionScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<InternetCubit, InternetState>(
//       listener: (context, state) {
//         if (state.message == "connected") {
//           Navigator.of(context).pushAndRemoveUntil(
//             MaterialPageRoute(builder: (context) => const SectionsScreen()),
//             (Route route) => false,
//           );
//         }
//       },
//       child: Scaffold(
//         backgroundColor: AppColors.primaryColor,
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Lottie.asset(
//                 'assets/icons/no_internet.json',
//                 width: 0.6.sw,
//                 height:
//                     MediaQuery.of(context).size.height > 680 ? 0.3.sh : 0.2.sh,
//               ),
//               Text(
//                 "not_connected".tr(context),
//                 style: const TextStyle(
//                     color: AppColors.whiteColor, fontWeight: FontWeight.bold),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
