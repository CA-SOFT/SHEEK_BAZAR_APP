// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheek_bazar/Locale/cubit/locale_cubit.dart';
import 'package:sheek_bazar/features/user/laundry/data/repositories/laundry_repo.dart';

import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/app_logger.dart';
import '../../data/models/laundry_model.dart';

part 'laundry_state.dart';

class LaundryCubit extends Cubit<LaundryState> {
  final LundryRepo lundryRepo;
  LaundryCubit({required this.lundryRepo}) : super(LaundryInitial());
  Future<void> getLundry(BuildContext context) async {
    try {
      Map<String, String> body = {};
      body['fetch_data'] = "1";

      LundryModel data = await lundryRepo.getLundray(body);
      emit(state.copyWith(response: data));
      // List<List<dynamic>> myArray = List.generate(
      //   state.response!.clothesType!.length,
      //   (row) => List.generate(state.response!.services!.length, (column) => 0),
      // );
      // print(myArray);
      // emit(state.copyWith(counterList: myArray));
      emit(state.copyWith(serviceId: state.response!.services![0].serviceId));
      emit(state.copyWith(
          categoryId: state.response!.clothesType![0].categoryId));
      final cubit = BlocProvider.of<LocaleCubit>(context);
      if (cubit.state.locale.languageCode == "en") {
        emit(state.copyWith(
            initialValueForService:
                state.response!.services![0].serviceNameEn));
        emit(state.copyWith(
            initialValueForClothesType:
                state.response!.clothesType![0].categoryNameEn));
      } else if (cubit.state.locale.languageCode == "ar") {
        emit(state.copyWith(
            initialValueForService:
                state.response!.services![0].serviceNameAr));
        emit(state.copyWith(
            initialValueForClothesType:
                state.response!.clothesType![0].categoryNameAr));
      } else {
        emit(state.copyWith(
            initialValueForService:
                state.response!.services![0].serviceNameKu));
        emit(state.copyWith(
            initialValueForClothesType:
                state.response!.clothesType![0].categoryNameKu));
      }
    } catch (e) {
      logger.e(e);

      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  clearData() {
    emit(state.copyWith(
      orders: [],
      total: "0",
      categoryArray: [],
      servicesArray: [],
      quantityArray: [],
      pricesArray: [],
    ));
  }

  addToOrder(BuildContext context) {
    if (state.categoryArray == null) {
      List catArray = [state.categoryId];
      emit(state.copyWith(categoryArray: catArray));
    } else {
      List catArray = state.categoryArray!;
      catArray.add(state.categoryId);
      emit(state.copyWith(categoryArray: []));
      emit(state.copyWith(categoryArray: catArray));
    }
    if (state.pricesArray == null) {
      String price = "0";
      for (int i = 0; i < state.response!.laundryItems!.length; i++) {
        if (state.response!.laundryItems![i].categoryId == state.categoryId &&
            state.response!.laundryItems![i].serviceId == state.serviceId) {
          price = state.response!.laundryItems![i].itemPrice!;
        }
      }
      price = "${int.parse(price)}";
      List pricesarray = [price];
      emit(state.copyWith(pricesArray: pricesarray));
    } else {
      String price = "0";
      for (int i = 0; i < state.response!.laundryItems!.length; i++) {
        if (state.response!.laundryItems![i].categoryId == state.categoryId &&
            state.response!.laundryItems![i].serviceId == state.serviceId) {
          price = state.response!.laundryItems![i].itemPrice!;
        }
      }
      price = "${int.parse(price)}";
      List pricesArray = state.pricesArray!;
      pricesArray.add(price);
      emit(state.copyWith(pricesArray: []));
      emit(state.copyWith(pricesArray: pricesArray));
    }
    if (state.quantityArray == null) {
      List quantity = [state.quantity];
      emit(state.copyWith(quantityArray: quantity));
    } else {
      List quantityArray = state.quantityArray!;
      quantityArray.add(state.quantity);
      emit(state.copyWith(quantityArray: []));
      emit(state.copyWith(quantityArray: quantityArray));
    }
    if (state.servicesArray == null) {
      List service = [state.serviceId];
      emit(state.copyWith(servicesArray: service));
    } else {
      List serviceArray = state.servicesArray!;
      serviceArray.add(state.serviceId);
      emit(state.copyWith(servicesArray: []));
      emit(state.copyWith(servicesArray: serviceArray));
    }

    String price = "0";
    for (int i = 0; i < state.response!.laundryItems!.length; i++) {
      if (state.response!.laundryItems![i].categoryId == state.categoryId &&
          state.response!.laundryItems![i].serviceId == state.serviceId) {
        price = state.response!.laundryItems![i].itemPrice!;
      }
    }
    price = "${int.parse(price) * state.quantity!}";
    String jsonString =
        '{"service":"${state.initialValueForService}", "category": "${state.initialValueForClothesType}","price":"$price","quantity":${state.quantity.toString()}}';
    Map newJson = jsonDecode(jsonString);
    List? orders = [];
    if (state.orders != null) {
      orders = state.orders;
    }
    orders?.add(newJson);
    emit(state.copyWith(orders: []));
    emit(state.copyWith(orders: orders));
    emit(state.copyWith(
        total: (int.parse(state.total!) + int.parse(price)).toString()));
    // Navigator.pop(context);
  }

  Future deleteOrder(var order) async {
    var catArray = state.categoryArray;
    var servicesArray = state.servicesArray;
    var pricesArray = state.pricesArray;
    var quantityArray = state.quantityArray;
    String? catId;
    String? serviceId;
    for (int j = 0; j < state.response!.clothesType!.length; j++) {
      if (state.response!.clothesType![j].categoryNameAr == order['category'] ||
          state.response!.clothesType![j].categoryNameKu == order['category'] ||
          state.response!.clothesType![j].categoryNameEn == order['category']) {
        catId = state.response!.clothesType![j].categoryId!;
      }
    }

    for (int j = 0; j < state.response!.services!.length; j++) {
      if (state.response!.services![j].serviceNameAr == order['service'] ||
          state.response!.services![j].serviceNameEn == order['service'] ||
          state.response!.services![j].serviceNameKu == order['service']) {
        serviceId = state.response!.services![j].serviceId!;
      }
    }

    for (int i = 0; i < catArray!.length; i++) {
      if (catArray[i] == catId &&
          servicesArray![i] == serviceId &&
          quantityArray![i] == order['quantity'] &&
          '${int.parse(pricesArray![i]) * order['quantity']}' ==
              '${int.parse(order['price'])}') {
        catArray.removeAt(i);
        servicesArray.removeAt(i);
        quantityArray.removeAt(i);
        pricesArray.removeAt(i);
        break;
      }
    }
    emit(state.copyWith(
        categoryArray: [],
        servicesArray: [],
        quantityArray: [],
        pricesArray: []));
    emit(state.copyWith(
        categoryArray: catArray,
        servicesArray: servicesArray,
        quantityArray: quantityArray,
        pricesArray: pricesArray));

    var newOrders = state.orders!.where((item) => item != order).toList();

    emit(state.copyWith(orders: []));
    emit(state.copyWith(orders: newOrders));
    String? total = state.total;
    total = '${int.parse(total!) - int.parse(order['price'])}';
    emit(state.copyWith(total: total));
  }

  changeinitalValueForService(String newValue, var lang) {
    if (lang == "en") {
      for (int i = 0; i < state.response!.services!.length; i++) {
        if (newValue == state.response!.services![i].serviceId) {
          emit(state.copyWith(
              initialValueForService:
                  state.response!.services![i].serviceNameEn));
        }
      }
    } else if (lang == "ar") {
      for (int i = 0; i < state.response!.services!.length; i++) {
        if (newValue == state.response!.services![i].serviceId) {
          emit(state.copyWith(
              initialValueForService:
                  state.response!.services![i].serviceNameAr));
        }
      }
    } else {
      for (int i = 0; i < state.response!.services!.length; i++) {
        if (newValue == state.response!.services![i].serviceId) {
          emit(state.copyWith(
              initialValueForService:
                  state.response!.services![i].serviceNameKu));
        }
      }
    }
    emit(state.copyWith(serviceId: newValue));
  }

  changeinitalValueForClothesType(String newValue, String lang) {
    if (lang == "en") {
      for (int i = 0; i < state.response!.clothesType!.length; i++) {
        if (newValue == state.response!.clothesType![i].categoryId) {
          emit(state.copyWith(
              initialValueForClothesType:
                  state.response!.clothesType![i].categoryNameEn));
        }
      }
    } else if (lang == "ar") {
      for (int i = 0; i < state.response!.clothesType!.length; i++) {
        if (newValue == state.response!.clothesType![i].categoryId) {
          emit(state.copyWith(
              initialValueForClothesType:
                  state.response!.clothesType![i].categoryNameAr));
        }
      }
    } else {
      for (int i = 0; i < state.response!.clothesType!.length; i++) {
        if (newValue == state.response!.clothesType![i].categoryId) {
          emit(state.copyWith(
              initialValueForClothesType:
                  state.response!.clothesType![i].categoryNameKu));
        }
      }
    }
    emit(state.copyWith(categoryId: newValue));
  }

  increaseQuantity() {
    emit(state.copyWith(quantity: state.quantity! + 1));
  }

  decraseQuantity() {
    if (state.quantity! > 1) {
      emit(state.copyWith(quantity: state.quantity! - 1));
    }
  }

  // Future<void> increaseCounter(i, j, price) async {
  //   print(price);
  //   List<List<dynamic>> array = state.counterList!;
  //   array[i][j] = array[i][j] + 1;

  //   emit(state.copyWith(counterList: []));
  //   emit(state.copyWith(counterList: array));
  //   emit(
  //       state.copyWith(total: "${int.parse(state.total!) + int.parse(price)}"));
  // }

  // Future<void> decreaseCounter(i, j, price) async {
  //   List<List<dynamic>> array = state.counterList!;

  //   if (array[i][j] > 0) {
  //     array[i][j] = array[i][j] - 1;
  //     emit(state.copyWith(counterList: []));
  //     emit(state.copyWith(counterList: array));
  //     emit(state.copyWith(
  //         total: "${int.parse(state.total!) - int.parse(price)}"));
  //   }
  // }
}
