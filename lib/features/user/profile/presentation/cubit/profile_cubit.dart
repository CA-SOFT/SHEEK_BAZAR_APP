// ignore_for_file: use_build_context_synchronously, await_only_futures, prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/features/auth/presentation/pages/sign_in.dart';
import 'package:sheek_bazar/features/suppliers/HomeScreenForSupllier/presentation/pages/home_supplier_screen.dart';
import 'package:sheek_bazar/features/user/profile/data/models/collect_points_model.dart';
import 'package:sheek_bazar/features/user/profile/data/models/orderDetails_model.dart';
import 'package:sheek_bazar/features/user/profile/data/models/pay_by_points_model.dart';
import 'package:sheek_bazar/features/user/profile/data/models/points_model.dart';
import 'package:sheek_bazar/features/user/profile/data/models/user_info_model.dart';
import 'package:sheek_bazar/features/user/profile/data/repositories/collect_points_repo.dart';
import 'package:sheek_bazar/features/user/profile/data/repositories/favorite_repo.dart';
import 'package:sheek_bazar/features/user/profile/data/repositories/get_user_info_repo.dart';
import 'package:sheek_bazar/features/user/profile/data/repositories/pay_by_points_repo.dart';
import 'package:sheek_bazar/features/user/profile/data/repositories/points_repo.dart';
import 'package:sheek_bazar/features/user/profile/data/repositories/updateProfile_repo.dart';
import 'package:sheek_bazar/sections_screen.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/app_logger.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../../../cart/data/models/operations_model.dart';
import '../../data/models/favorite_model.dart';
import '../../data/models/orders_model.dart';
import '../../data/repositories/orderDetails_repo.dart';
import '../../data/repositories/orders_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final FavoriteRepo favoriteRepo;
  final UpdateProfileRepo updateProfileRepo;
  final OrdersRepo ordersRepo;
  final OrderDetailsRepo orderDetailsRepo;
  final PointsRepo pointsRepo;
  final CollectPointsRepo collectPointsRepo;
  final GetUserInfoRepo getUserInfoRepo;
  final PayByPointsRepo payByPointsRepo;

  ProfileCubit(
      {required this.favoriteRepo,
      required this.updateProfileRepo,
      required this.orderDetailsRepo,
      required this.pointsRepo,
      required this.getUserInfoRepo,
      required this.payByPointsRepo,
      required this.collectPointsRepo,
      required this.ordersRepo})
      : super(ProfileInitial());

  //////__________GET MY FAVORITE __________////////////////

  Future<void> getMyFavorite(BuildContext context) async {
    try {
      emit(state.copyWith(loadingFavorite: true));

      await cacheDataForFav();
      Map<String, String> body = {};
      body['customer_id'] = state.customerId!;
      body['fetch_wishlist'] = "1";

      FavoriteModel data = await favoriteRepo.getMyFavorite(body);
      logger.i(data);
      emit(state.copyWith(myFavorite: data));
      emit(state.copyWith(loadingFavorite: false));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(loadingFavorite: false));

      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }
  //////__________INSERT TO MY FAVORITE __________////////////////

  Future<void> insertToMyFavorite(
      BuildContext context, String productID) async {
    try {
      await cacheDataForFav();
      Map<String, String> body = {};
      body['customer_id'] = state.customerId!;
      body['insert_to_wishlist'] = "1";
      body['product_id'] = productID;

      OperationsModel data =
          await favoriteRepo.insertOrDeleteToMyFavorite(body);
      // List<WishlistItems> wishlistItems = state.myFavorite!.wishlistItems!;

      await getMyFavorite(context);
      // AppConstant.customNavigation(context, const FavoriteScreen(), -1, 0);
      logger.i(data);
    } catch (e) {
      logger.e(e);
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }
////// DELETE FROM MY FAVORITE __________////////////////

  Future<void> deleteFromMyFavorite(
      BuildContext context, String productID) async {
    try {
      await cacheDataForFav();
      Map<String, String> body = {};
      body['delete_from_wishlist'] = "1";
      body['id'] = productID;
      body['customer_id'] = state.customerId!;

      OperationsModel data =
          await favoriteRepo.insertOrDeleteToMyFavorite(body);
      List<WishlistItems> wishlistItems = state.myFavorite!.wishlistItems!;
      wishlistItems.removeWhere((item) => item.id == productID);
      emit(state.copyWith(
          myFavorite: FavoriteModel(wishlistItems: wishlistItems)));
      logger.i(data);
    } catch (e) {
      logger.e(e);
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  Future<void> cacheData() async {
    String userId = await CacheHelper.getData(key: "USER_ID");
    emit(state.copyWith(userId: userId));
  }

  Future<void> cacheDataForFav() async {
    String customerId = await CacheHelper.getData(key: "CUSTOMER_ID");
    emit(state.copyWith(customerId: customerId));
  }

  Future<void> clearMyFavorite() async {
    emit(state.copyWith(myFavorite: FavoriteModel(wishlistItems: [])));
  }

  /////////////////////////_________________UPDATE PROFILE_________________________________/////////////////////////////
  onUserNameChange(String value) => emit(state.copyWith(userName: value));
  onPhoneNumberChange(String value) => emit(state.copyWith(phoneNumber: value));
  onPasswordChange(String value) => emit(state.copyWith(password: value));
  Future<void> clearMyInfo() async {
    emit(state.copyWith(userName: "", password: "", phoneNumber: ""));
  }

  Future<void> updateProfile(BuildContext context, String name, String password,
      String phoneNumber, bool fromSupplier) async {
    try {
      await cacheData();
      if (state.userName == null) {
        emit(state.copyWith(userName: name));
      }
      if (state.userName != null) {
        if (state.userName!.isEmpty) {
          emit(state.copyWith(userName: name));
        }
      }
      if (state.password == null) {
        emit(state.copyWith(password: password));
      }
      if (state.password != null) {
        if (state.password!.isEmpty) {
          emit(state.copyWith(password: password));
        }
      }
      if (state.phoneNumber == null) {
        emit(state.copyWith(phoneNumber: phoneNumber));
      }
      if (state.phoneNumber != null) {
        if (state.phoneNumber!.isEmpty) {
          emit(state.copyWith(phoneNumber: phoneNumber));
        }
      }
      Map<String, String> body = {};
      body['update_profile'] = "1";
      body['user_id'] = state.userId!;
      body['user_name'] = state.userName!;
      body['user_phone'] = state.phoneNumber!;
      body['user_password'] = state.password!;

      OperationsModel data = await updateProfileRepo.updateProfile(body);
      if (data.errorMsg == "false") {
        cacheDataForUpdate(
            state.userName!, state.password!, state.phoneNumber!);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.primaryColor,
            padding: EdgeInsets.only(
                bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
            content: Text(
              'save_changes'.tr(context),
              style: const TextStyle(color: Colors.green),
            ),
            duration: const Duration(seconds: 2), // Optional duration
          ),
        );
        if (fromSupplier == false) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => const SectionsScreen(
                      number: 4,
                    )),
            (Route route) => false,
          );
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => const HomeSupplier(
                      number: 2,
                    )),
            (Route route) => false,
          );
        }
        // await AppConstant.customAlert(context, "save_changes",
        //     withTranslate: true, witherror: false);
        logger.i(data);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.primaryColor,
            padding: EdgeInsets.only(
                bottom: 150.h, top: 50.h, left: 50.w, right: 50.w),
            content: Text(
              '${data.status}',
              style: const TextStyle(color: Colors.red),
            ),
            duration: const Duration(seconds: 2), // Optional duration
          ),
        );
        // await AppConstant.customAlert(context, "${data.status}",
        //     withTranslate: false, witherror: true);
      }
      emit(state.copyWith(userName: "", password: "", phoneNumber: ""));
    } catch (e) {
      logger.e(e);
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  cacheDataForUpdate(
      String userName, String password, String phonenumber) async {
    await CacheHelper.saveData(key: "USER_NAME", value: userName);
    await CacheHelper.saveData(key: "USER_PASSWORD", value: password);
    await CacheHelper.saveData(key: "USER_PHONENUMBER", value: phonenumber);
  }

  Future<void> deletePRofile(BuildContext context) async {
    try {
      await cacheData();

      Map<String, String> body = {};
      body['delete_profile'] = "1";
      body['user_id'] = state.userId!;

      OperationsModel data = await updateProfileRepo.updateProfile(body);
      await CacheHelper.clearData(
        key: "USER_NAME",
      );
      await CacheHelper.clearData(
        key: "USER_ID",
      );
      await CacheHelper.clearData(
        key: "CUSTOMER_ID",
      );
      await CacheHelper.clearData(
        key: "SUPPLIER_ID",
      );
      await CacheHelper.clearData(
        key: "USER_PASSWORD",
      );
      await CacheHelper.clearData(
        key: "USER_PHONENUMBER",
      );
      clearMyFavorite();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SigninScreen()),
        (Route route) => false,
      );
      logger.i(data);
    } catch (e) {
      logger.e(e);
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  ////////////////////////////////////////////// Orders Sections //////////////////////////////////
  Future<void> getOrders(BuildContext context) async {
    try {
      emit(state.copyWith(loadingOrders: true));
      await cacheDataForFav();

      Map<String, String> body = {};
      body['customer_id'] = state.customerId!;
      body['fetch_orders'] = "1";
      OrdersModel data = await ordersRepo.getOrders(body);
      emit(state.copyWith(clothesOrders: data));

      // Map<String, String> body2 = {};
      // body2['customer_id'] = state.customerId!;
      // body2['fetch_laundry_orders'] = "1";
      // OrdersModel data2 = await ordersRepo.getOrders(body2);
      // emit(state.copyWith(laundryOrders: data2));

      logger.i(data);
      // logger.i(data2);
      emit(state.copyWith(loadingOrders: false));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(loadingOrders: false));
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  Future<void> getLaundryOrders(BuildContext context) async {
    try {
      emit(state.copyWith(loadingOrders: true));
      await cacheDataForFav();

      Map<String, String> body = {};
      body['customer_id'] = state.customerId!;
      body['fetch_laundry_orders'] = "1";
      OrdersModel data = await ordersRepo.getOrders(body);
      emit(state.copyWith(laundryOrders: data));

      // Map<String, String> body2 = {};
      // body2['customer_id'] = state.customerId!;
      // body2['fetch_laundry_orders'] = "1";
      // OrdersModel data2 = await ordersRepo.getOrders(body2);
      // emit(state.copyWith(laundryOrders: data2));

      logger.i(data);
      // logger.i(data2);
      emit(state.copyWith(loadingOrders: false));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(loadingOrders: false));
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  Future<void> getOrdersDetails(BuildContext context, String orderId) async {
    try {
      emit(state.copyWith(loadingOrdersDetails: true));
      await cacheDataForFav();

      Map<String, String> body = {};
      body['customer_id'] = state.customerId!;
      body['fetch_order_details'] = "1";
      body['order_id'] = orderId;
      OrderDetailsModel data = await orderDetailsRepo.getOrderDetails(body);
      emit(state.copyWith(orderDetails: data));
      logger.i(data);
      // logger.i(data2);
      emit(state.copyWith(loadingOrdersDetails: false));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(loadingOrdersDetails: false));
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  ///////////////////GEt Points////////////////////////
  Future<void> getPoints(BuildContext context) async {
    try {
      await cacheDataForFav();
      Map<String, String> body = {};
      body['customer_id'] = state.customerId!;
      body['fetch_activities'] = "1";

      emit(state.copyWith(loadingPoints: true));

      PointsModel data = await pointsRepo.getpoints(body);
      if (data.status == true) {
        emit(state.copyWith(customerInfo: data.data!.customer));
        emit(state.copyWith(pointsActivities: data.data!.activities));
        DateTime dateTimeNow = await DateTime.now();
        DateTime dateTimeGiven = await DateTime.parse(data.newDate ?? "");
        Duration difference = await dateTimeGiven.difference(dateTimeNow);
        emit(state.copyWith(newDate: difference));
      }
      emit(state.copyWith(loadingPoints: false));
    } catch (e) {
      emit(state.copyWith(loadingPoints: false));

      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  Future<void> collectPoints(BuildContext context) async {
    try {
      await cacheDataForFav();
      Map<String, String> body = {};
      body['customer_id'] = state.customerId!;
      body['collect_points'] = "1";
      emit(state.copyWith(loadingCollectPoints: true));
      CollectPointsModel data = await collectPointsRepo.collectPoints(body);
      emit(state.copyWith(loadingCollectPoints: false));

      if (data.message == "points collected Successfully") {
        Navigator.pop(context);
        List<ProfileInfo>? newProfileInfo = state.profileInfo;
        if (newProfileInfo![0].myPoints is int) {
          newProfileInfo[0].myPoints =
              (newProfileInfo[0].myPoints + 100).toString();
        } else {
          newProfileInfo[0].myPoints =
              (int.parse(newProfileInfo[0].myPoints) + 100).toString();
        }

        emit(state.copyWith(profileInfo: newProfileInfo));
        AppConstant.customAlert(context, "Congratulations",
            withTranslate: true, witherror: false);
        emit(state.copyWith(showCollectPointButton: false));
        emit(state.copyWith(
            newDate: Duration(hours: 10, minutes: 10, seconds: 10)));
      }
    } catch (e) {
      emit(state.copyWith(loadingCollectPoints: false));

      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  Future<void> clearDataForPoints() async {
    emit(state.copyWith(customerInfo: Customer(), pointsActivities: []));
  }

  Future<void> changeShowCollectPointButton(bool value) async {
    emit(state.copyWith(showCollectPointButton: value));
  }

  Future<void> getUserInfo(BuildContext context) async {
    try {
      String userId = await CacheHelper.getData(key: "USER_ID");

      Map<String, String> body = {};
      body['user_id'] = userId;
      body['fetch_profile'] = "1";
      UserIndoModel data = await getUserInfoRepo.getUserInfo(body);
      emit(state.copyWith(profileInfo: data.profileInfo));
      logger.i(data);
    } catch (e) {
      logger.e(e);
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  Future<void> bayByPoints(BuildContext context, String orderId) async {
    try {
      emit(state.copyWith(loadingBuy: true));
      String customerId = await CacheHelper.getData(key: "CUSTOMER_ID");

      Map<String, String> body = {};
      body['customer_id'] = customerId;
      body['paid_with_points'] = "1";
      body['order_id'] = orderId;
      BayByPointsModel data = await payByPointsRepo.pay(body);
      if (data.message == "paid successfully") {
        // emit(state.copyWith(laundryOrders: ,clothesOrders: []))
        getOrders(context);
        getLaundryOrders(context);
      }
      logger.i(data);
      emit(state.copyWith(loadingBuy: false));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(loadingBuy: false));

      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }
}
