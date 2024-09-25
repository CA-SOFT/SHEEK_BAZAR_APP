// ignore_for_file: use_build_context_synchronously, unused_local_variable, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheek_bazar/features/user/cart/data/models/cart_model.dart';
import 'package:sheek_bazar/features/user/cart/data/models/check_out_model.dart';
import 'package:sheek_bazar/features/user/cart/data/models/provinces_model.dart';
import 'package:sheek_bazar/features/user/cart/data/repositories/myAddress_repo.dart';
import 'package:sheek_bazar/features/user/laundry/presentation/cubit/laundry_cubit.dart';
import 'package:sheek_bazar/features/user/profile/presentation/pages/my_orders_screen.dart';
import 'package:http/http.dart' as http;
import 'package:sheek_bazar/sections_screen.dart';

import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/app_logger.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../../data/models/operations_model.dart';
import '../../data/models/myAddress_model.dart';
import '../../data/repositories/cart_repo.dart';
import '../../data/repositories/checkout_repo.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final MyAddressRepo myAddressRepo;
  final CartRepo cartRepo;
  final CheckoutRepo checkoutRepo;

  CartCubit(
      {required this.myAddressRepo,
      required this.cartRepo,
      required this.checkoutRepo})
      : super(CartInitial());
  clearAddressVariables() {
    emit(state.copyWith(
        addressTitle: "",
        cityId: "",
        latitude: "",
        longitude: "",
        notes: "",
        phoneNumber: ""));
  }

  ////////____ INSERT MY ADDRESS _____////////
  checkFromLaundry(bool value) {
    emit(state.copyWith(fromLaundry: value));
  }

  Future<void> insertAdress(BuildContext context) async {
    try {
      if (await fieldsValidationForInsertAddress(context)) {
        emit(state.copyWith(loading: true));

        await cacheData();
        Map<String, String> body = {};
        body['customer_id'] = state.userId!;
        body['insert_address'] = "1";
        body['address_title'] = state.addressTitle!;
        body['province_id'] = state.cityId!;
        body['address_longitude'] = state.longitude!;
        body['address_latitude'] = state.latitude!;
        body['address_notes'] = state.notes!;
        body['address_phone'] = state.phoneNumber!;

        OperationsModel data = await myAddressRepo.addressOpertion(body);
        emit(state.copyWith(loading: false));
        clearData();
        await getMyAdress(context);
        Navigator.pop(context);

        logger.i(data);
      }
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(loading: false));

      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  ////////____ FETCH MY ADDRESS _____////////
  Future<void> getMyAdress(BuildContext context) async {
    try {
      emit(state.copyWith(loadingMyAdress: true));

      await cacheData();
      Map<String, String> body = {};
      body['customer_id'] = state.userId!;
      body['fetch_addresses'] = "1";

      MyAddressModel data = await myAddressRepo.getMyAddress(body);
      emit(state.copyWith(loadingMyAdress: false));

      logger.i(data);
      emit(state.copyWith(myAddress: data));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(loadingMyAdress: false));

      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  ////////____ UPDATE MY ADDRESS _____////////

  Future<void> updateAddress(BuildContext context, String addressId) async {
    try {
      emit(state.copyWith(loading: true));
      await cacheData();
      Map<String, String> body = {};
      body['customer_id'] = state.userId!;
      body['address_id'] = addressId;
      body['update_address'] = "1";
      body['address_title'] = state.addressTitle!;
      body['province_id'] = state.cityId!;
      body['address_longitude'] = state.longitude!;
      body['address_latitude'] = state.latitude!;
      body['address_notes'] = state.notes!;
      body['address_phone'] = state.phoneNumber!;

      OperationsModel data = await myAddressRepo.addressOpertion(body);
      emit(state.copyWith(loading: false));
      clearData();
      await getMyAdress(context);
      Navigator.pop(context);

      logger.i(data);
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(loading: false));

      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  ////////____ DELETE ADDRESS _____////////

  Future<void> deleteAddress(BuildContext context, String addressID) async {
    try {
      await cacheData();
      Map<String, String> body = {};
      body['customer_id'] = state.userId!;
      body['delete_address'] = "1";
      body['address_id'] = addressID;

      OperationsModel data = await myAddressRepo.addressOpertion(body);
      emit(state.copyWith(loading: false));

      String? cachId = await CacheHelper.getData(key: "ADDRESS_ID");
      if (cachId != null) {
        if (cachId == addressID) await CacheHelper.clearData(key: "ADDRESS_ID");
      }
      List<CustomerAddresses> newCustomerAddress =
          state.myAddress!.customerAddresses!;
      newCustomerAddress
          .removeWhere((address) => address.addressId == addressID);
      emit(state.copyWith(
          myAddress: MyAddressModel(customerAddresses: newCustomerAddress)));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(loading: false));

      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  ////////____ GET USER ID _____////////

  Future<void> cacheData() async {
    String userId = await CacheHelper.getData(key: "CUSTOMER_ID");
    emit(state.copyWith(userId: userId));
  }

  ////////____ GET CITIES _____////////

  Future<void> getProvinces(BuildContext context) async {
    try {
      Map<String, String> body = {};
      body['fetch_provinces'] = "1";

      ProvincesModel data = await myAddressRepo.Getprovinces(body);
      emit(state.copyWith(provinces: data));
    } catch (e) {
      logger.e(e);
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  ////////____ FUNCTION TO CHECK VALUES IN UPDATE ADDRESS _____////////

  checkIfChangeValue(String title, String notes, String phonenumber,
      String provinceName, String lat, String log) {
    if (state.addressTitle == null) {
      emit(state.copyWith(addressTitle: title));
    } else {
      if (state.addressTitle!.isEmpty) {
        emit(state.copyWith(addressTitle: title));
      }
    }
    if (state.latitude == null) {
      emit(state.copyWith(latitude: lat));
    } else {
      if (state.latitude!.isEmpty) {
        emit(state.copyWith(latitude: lat));
      }
    }
    if (state.longitude == null) {
      emit(state.copyWith(longitude: log));
    } else {
      if (state.longitude!.isEmpty) {
        emit(state.copyWith(longitude: log));
      }
    }
    if (state.notes == null) {
      emit(state.copyWith(notes: notes));
    } else {
      if (state.notes!.isEmpty) {
        emit(state.copyWith(notes: notes));
      }
    }
    if (state.phoneNumber == null) {
      emit(state.copyWith(phoneNumber: phonenumber));
    } else {
      if (state.phoneNumber!.isEmpty) {
        emit(state.copyWith(phoneNumber: phonenumber));
      }
    }
    if (state.cityId == null) {
      for (int i = 0; i < state.provinces!.provinces!.length; i++) {
        if (state.provinces!.provinces![i].provinceNameAr == provinceName ||
            state.provinces!.provinces![i].provinceNameEn == provinceName ||
            state.provinces!.provinces![i].provinceNameKu == provinceName) {
          emit(state.copyWith(
              cityId: state.provinces!.provinces![i].provinceId));
        }
      }
    } else {
      if (state.cityId!.isEmpty) {
        for (int i = 0; i < state.provinces!.provinces!.length; i++) {
          if (state.provinces!.provinces![i].provinceNameAr == provinceName ||
              state.provinces!.provinces![i].provinceNameEn == provinceName ||
              state.provinces!.provinces![i].provinceNameKu == provinceName) {
            emit(state.copyWith(
                cityId: state.provinces!.provinces![i].provinceId));
          }
        }
      }
    }
  }

  changeNotes(String value) {
    emit(state.copyWith(notes: value));
  }

  changePhoneNumber(String value) {
    emit(state.copyWith(phoneNumber: value));
  }

  changeLatAndLong(String lat, String long) {
    emit(state.copyWith(latitude: lat, longitude: long));
  }

  changeAddressTitle(String value) {
    emit(state.copyWith(addressTitle: value));
  }

  ////////__________________INSERT INTO CART _____________////////////////

  Future<bool> fieldsValidationForInsertIntoCart(BuildContext context) async {
    if (state.productColor == null) {
      await AppConstant.customAlert(context, "select_color");
      return false;
    } else {
      if (state.productColor!.isEmpty) {
        await AppConstant.customAlert(context, "select_color");
        return false;
      }
    }

    if (state.productSize == null) {
      await AppConstant.customAlert(context, "select_size");
      return false;
    } else {
      if (state.productSize!.isEmpty) {
        await AppConstant.customAlert(context, "select_size");
        return false;
      }
    }

    return true;
  }

  Future<void> insertIntoCart(BuildContext context) async {
    try {
      if (await fieldsValidationForInsertIntoCart(context)) {
        emit(state.copyWith(loadingInsertRoCart: true));
        await cacheData();
        Map<String, String> body = {};
        body['customer_id'] = state.userId!;
        body['insert_to_cart'] = "1";
        body['product_id'] = state.productId!;
        body['product_size'] = state.productSize!;
        body['product_color'] = state.productColor!;
        body['product_quantity'] = "${state.productQuantity}";

        OperationsModel data = await cartRepo.updateItemCart(body);

        emit(state.copyWith(loadingInsertRoCart: false));

        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (context) =>
        //         const CartScreen(), // Replace with your new screen
        //   ),
        // );
        clearInsertVariables();
        await AppConstant.customAlert(
            context, "The_product_has_been_added_to_the_cart_successfully",
            withTranslate: true, second: 1, witherror: false);
      }
    } catch (e) {
      emit(state.copyWith(loadingInsertRoCart: false));

      logger.e(e);
      emit(state.copyWith(loading: false));

      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  Future<void> selectedColor(BuildContext context, int index) async {
    emit(state.copyWith(active: index));
  }

  Future<void> selectedSize(BuildContext context, int index) async {
    emit(state.copyWith(activeSize: index));
  }

  Future<void> clearInsertVariables() async {
    emit(state.copyWith(
        active: -1,
        activeSize: -1,
        showCounter: false,
        productColor: "",
        productSize: "",
        productQuantity: 1));
  }

  changeshowCounter() {
    emit(state.copyWith(showCounter: true));
  }

  changeproductId(String value) {
    emit(state.copyWith(productId: value));
  }

  changeproductColor(String value) {
    emit(state.copyWith(productColor: value));
  }

  changeproductSize(String value) {
    emit(state.copyWith(productSize: value));
  }

  changeProductQuantity(String type) {
    if (type == "add") {
      emit(state.copyWith(productQuantity: state.productQuantity + 1));
    } else {
      if (state.productQuantity != 1) {
        emit(state.copyWith(productQuantity: state.productQuantity - 1));
      }
    }
  }

  clearData() {
    emit(state.copyWith(
        addressTitle: "",
        cityId: "",
        latitude: "",
        longitude: "",
        notes: "",
        phoneNumber: "",
        selectedCity: Provinces(
            provinceId: "",
            provinceNameAr: "",
            provinceNameEn: "",
            provinceNameKu: ""),
        myAddress: MyAddressModel(customerAddresses: [])));
  }

  Future<bool> fieldsValidationForInsertAddress(BuildContext context) async {
    if (state.notes == null) {
      await AppConstant.customAlert(context, "add_notes");
      return false;
    } else {
      if (state.notes!.isEmpty) {
        await AppConstant.customAlert(context, "add_notes");
        return false;
      }
    }

    if (state.phoneNumber == null) {
      await AppConstant.customAlert(context, "Enter_phone_number");
      return false;
    } else {
      if (state.phoneNumber!.isEmpty) {
        await AppConstant.customAlert(context, "Enter_phone_number");
        return false;
      }
    }
    if (state.cityId == null) {
      await AppConstant.customAlert(context, "choose_city");
      return false;
    } else {
      if (state.cityId!.isEmpty) {
        await AppConstant.customAlert(context, "choose_city");
        return false;
      }
    }

    if (state.addressTitle == null ||
        state.longitude == null ||
        state.latitude == null) {
      await AppConstant.customAlert(context, "select_location");
      return false;
    } else {
      if (state.addressTitle!.isEmpty ||
          state.longitude!.isEmpty ||
          state.latitude!.isEmpty) {
        await AppConstant.customAlert(context, "select_location");
        return false;
      }
    }
    return true;
  }

  Future<void> changeCity(BuildContext context, String cityId) async {
    emit(state.copyWith(cityId: cityId));
    for (int i = 0; i < state.provinces!.provinces!.length; i++) {
      if (state.provinces!.provinces![i].provinceId == cityId) {
        emit(state.copyWith(selectedCity: state.provinces!.provinces![i]));
      }
    }
  }

  onFeeschange(String value) {
    emit(state.copyWith(Fees: value));
  }

  ///////////////////////////////________________________________ CART SECTION ________________________________///////////////////////////////
  Future<void> getMyCart(BuildContext context) async {
    try {
      emit(state.copyWith(loadingCart: true));

      await cacheData();
      Map<String, String> body = {};
      body['customer_id'] = state.userId!;
      body['fetch_cart'] = "1";

      CartModel data = await cartRepo.getMyCart(body);
      logger.i(data);

      emit(state.copyWith(cartitems: data));
      if (state.cartitems != null) {
        int total = 0;
        double earnedPoints = 0.0;

        for (int i = 0; i < state.cartitems!.cartItems!.length; i++) {
          int sum;
          double Points;
          sum = int.parse(state.cartitems!.cartItems![i].productFinalPrice!) *
              int.parse(state.cartitems!.cartItems![i].productQuantity!);
          Points = double.parse(state.cartitems!.cartItems![i].productPoints!) *
              double.parse(state.cartitems!.cartItems![i].productQuantity!);
          earnedPoints = earnedPoints + Points;
          total = total + sum;
        }
        emit(state.copyWith(subTotal: total, earnedPoints: earnedPoints));
      }
      emit(state.copyWith(loadingCart: false));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(loadingCart: false));
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  Future<void> clearMyCart() async {
    emit(state.copyWith(cartitems: CartModel(cartItems: [])));
  }

  //////_____UPDATE ITEM IN CART _____//////
  Future<void> updateItemCart(
      BuildContext context, String id, String quantity) async {
    try {
      await cacheData();
      Map<String, String> body = {};
      body['customer_id'] = state.userId!;
      body['id'] = id;
      body['product_quantity'] = quantity;
      body['update_cart'] = "1";

      OperationsModel data = await cartRepo.updateItemCart(body);
      // getMyCart(context);
      logger.i(data);
    } catch (e) {
      logger.e(e);
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  Future<void> updateSubTotal(int value) async {
    emit(state.copyWith(subTotal: value));
  }

  Future<void> updateearnedPoints(double value) async {
    emit(state.copyWith(earnedPoints: value));
  }

  //////_____DELETE ITEM IN CART _____//////
  Future<void> deleteItemFromCart(BuildContext context, String id) async {
    try {
      await cacheData();
      Map<String, String> body = {};
      body['customer_id'] = state.userId!;
      body['id'] = id;
      body['delete_from_cart'] = "1";
      emit(state.copyWith(loadingCart: true));

      OperationsModel data = await cartRepo.updateItemCart(body);
      List<CartItems> CartItemsAfterDelete = state.cartitems!.cartItems!;
      int? cartPrice;
      var cartPoints;
      for (int i = 0; i < state.cartitems!.cartItems!.length; i++) {
        if (state.cartitems!.cartItems![i].id == id) {
          cartPrice = state.cartitems!.cartItems![i].productGrandTotal;
          cartPoints = state.cartitems!.cartItems![i].totalPoints;
        }
      }
      CartItemsAfterDelete.removeWhere((address) => address.id == id);
      emit(state.copyWith(cartitems: CartModel(cartItems: [])));
      emit(state.copyWith(
          cartitems: CartModel(cartItems: CartItemsAfterDelete)));
      // getMyCart(context);
      double points = state.earnedPoints! - cartPoints;
      int? price = state.subTotal! - cartPrice!;

      emit(state.copyWith(subTotal: price, earnedPoints: points));
      logger.i(data);
    } catch (e) {
      logger.e(e);
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
    emit(state.copyWith(loadingCart: false));
  }

  /////////////////___________Check Out_______________//////////////////////////
  getLaundrIndo(
      List? cat, List? service, List? quantity, int? total, List? pricesArray) {
    emit(state.copyWith(
        categoryArray: cat,
        servicesArray: service,
        quantityArray: quantity,
        pricesArray: pricesArray,
        subTotal: total));
  }

  Future<void> ckeckoutForLaundry(
      BuildContext context, String paidWithPoint) async {
    try {
      emit(state.copyWith(loadingCheckOut: true));
      await cacheData();
      String? addresId = await CacheHelper.getData(key: "ADDRESS_ID");
      if (state.servicesArray != null) {
        if (state.servicesArray!.isEmpty) {
          await AppConstant.customAlert(context, "Laundry order is empty",
              withTranslate: false);
        } else {
          if (addresId != null) {
            var request = http.MultipartRequest(
              'POST',
              Uri.parse('https://sheek-bazar.com/app/api/checkout.php'),
            );
            request.fields['customer_id'] = state.userId!;
            request.fields['new_laundry_order'] = "1";
            request.fields['address_id'] = addresId;
            request.fields['paid_with_points'] = paidWithPoint;
            request.fields['service_id'] = "${state.servicesArray}";
            request.fields['category_id'] = "${state.categoryArray}";
            request.fields['item_quantity'] = "${state.quantityArray}";
            request.fields['item_price'] = "${state.pricesArray}";
            try {
              var response = await request.send();

              if (response.statusCode == 200) {
                var responseBody = await response.stream.bytesToString();
                var jsonResponse = jsonDecode(responseBody);
                var errorMessage = jsonResponse['error_msg'];
                // var message = jsonResponse['message'];
                if (errorMessage == "true") {
                  await AppConstant.customAlert(
                      context, jsonResponse['message'],
                      second: 3, withTranslate: false);
                } else {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const SectionsScreen(
                              number: 4,
                            )),
                    (Route route) => false,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyOrdersScreen(
                              initalIndex: 1,
                            )),
                  );

                  await context.read<LaundryCubit>().clearData();
                  emit(state.copyWith(
                      servicesArray: [],
                      categoryArray: [],
                      quantityArray: [],
                      pricesArray: []));
                }
              } else {
                await AppConstant.customAlert(
                    context, response.statusCode.toString(),
                    withTranslate: false);
              }
            } catch (e) {
              await AppConstant.customAlert(context, e.toString(),
                  withTranslate: false);
            }
            // body['item_total_price'] =
            //     "${state.subTotal! + int.parse(state.Fees!)}";
            // for (int i = 0; i < state.servicesArray!.length; i++) {
            //   body['service_id[$i]'] = '${state.servicesArray![i]}';
            //   body['item_quantity[$i]'] = '${state.quantityArray![i]}';
            //   body['category_id[$i]'] = '${state.categoryArray![i]}';
            // }
            // OperationsModel data = await checkoutRepo.checkout(body);
            // AppConstant.customNavigation(context, const MyOrdersScreen(), -1, 0);
          } else {
            await AppConstant.customAlert(context, "add_new_address",
                withTranslate: true);
          }
        }
      } else {
        await AppConstant.customAlert(context, "Laundry order is empty",
            withTranslate: false);
      }
      emit(state.copyWith(loadingCheckOut: false));
    } catch (e) {
      emit(state.copyWith(loadingCheckOut: false));

      logger.e(e);
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  Future<void> ckeckout(BuildContext context, String paidWithPoint) async {
    try {
      emit(state.copyWith(loadingCheckOut: true));
      await cacheData();
      String? addresId = await CacheHelper.getData(key: "ADDRESS_ID");
      if (state.subTotal != 0) {
        if (addresId != null) {
          String Note = "";
          for (int i = 0; i < state.myAddress!.customerAddresses!.length; i++) {
            if (state.myAddress!.customerAddresses![i].addressId == addresId) {
              Note = state.myAddress!.customerAddresses![i].addressNotes!;
            }
          }
          Map<String, String> body = {};
          body['customer_id'] = state.userId!;
          body['address_id'] = addresId;
          body['paid_with_points'] = paidWithPoint;
          body['order_notes'] = Note;
          body['new_order'] = "1";

          CheckOutModel data = await checkoutRepo.checkout(body);
          // AppConstant.customNavigation(context, const MyOrdersScreen(), -1, 0);
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => const SectionsScreen(
                      number: 4,
                    )),
            (Route route) => false,
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyOrdersScreen()),
          );
          if (data.paidMessage == "no enough points to make paid the order") {
            await AppConstant.customAlert(
                context, "no_enough_points_to_make_paid_the_order",
                withTranslate: true, second: 3);
          }
        } else {
          await AppConstant.customAlert(context, "add_new_address",
              withTranslate: true);
        }
      } else {
        await AppConstant.customAlert(context, "cart_is_empty",
            withTranslate: true);
      }
      emit(state.copyWith(loadingCheckOut: false));
    } catch (e) {
      emit(state.copyWith(loadingCheckOut: false));

      logger.e(e);
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }
}
