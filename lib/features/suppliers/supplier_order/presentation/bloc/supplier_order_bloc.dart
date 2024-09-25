// ignore_for_file: use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/core/utils/app_logger.dart';
import 'package:sheek_bazar/core/utils/cache_helper.dart';
import 'package:sheek_bazar/features/suppliers/supplier_order/data/models/confirm_order_model.dart';
import 'package:sheek_bazar/features/suppliers/supplier_order/data/models/supplier_orders_model.dart';
import 'package:sheek_bazar/features/suppliers/supplier_order/data/repositories/confirm_order_repo.dart';
import 'package:sheek_bazar/features/suppliers/supplier_order/data/repositories/get_order_details_repo.dart';
import 'package:sheek_bazar/features/suppliers/supplier_order/data/repositories/get_orders_repo.dart';
import 'package:sheek_bazar/features/user/profile/data/models/orderDetails_model.dart';

part 'supplier_order_state.dart';

class SupplierOrderCubit extends Cubit<SupplierOrderState> {
  GetSupplierOrdersRepo getSupplierOrders;
  ConfirmRepo confirmRepo;
  GetSupplierOrderDetailsRepo getSupplierOrderDetailsRepo;
  SupplierOrderCubit(
      {required this.getSupplierOrders,
      required this.getSupplierOrderDetailsRepo,
      required this.confirmRepo})
      : super(SupplierOrderStateInitial());

  Future<void> getOrders(BuildContext context) async {
    try {
      emit(state.copyWith(loadingOrders: true));

      String supplierID = await CacheHelper.getData(key: "SUPPLIER_ID");

      Map<String, String> body = {};
      body['supplier_id'] = supplierID;
      body['fetch_orders'] = "1";
      SupplierOrders data = await getSupplierOrders.getOrders(body);
      emit(state.copyWith(orders: data.data));
      emit(state.copyWith(loadingOrders: false));

      logger.i(data);
      // logger.i(data2);
    } catch (e) {
      emit(state.copyWith(loadingOrders: false));

      logger.e(e);
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  Future<void> clearOrdersDetails() async {
    emit(state.copyWith(ordersDetails: []));
  }

  Future<void> clearOrders() async {
    emit(state.copyWith(orders: []));
  }

  Future<void> getOrderDetails(BuildContext context, String orderID) async {
    try {
      emit(state.copyWith(loadingOrders: true));

      String supplierID = await CacheHelper.getData(key: "SUPPLIER_ID");

      Map<String, String> body = {};
      body['supplier_id'] = supplierID;
      body['order_id'] = orderID;
      body['fetch_order_items'] = "1";
      OrderDetailsModel data =
          await getSupplierOrderDetailsRepo.getOrders(body);
      emit(state.copyWith(ordersDetails: data.orderItems));
      emit(state.copyWith(loadingOrders: false));

      logger.i(data);
    } catch (e) {
      emit(state.copyWith(loadingOrders: false));

      logger.e(e);
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  Future<void> confirmOrder(BuildContext context, String orderID) async {
    try {
      String supplierID = await CacheHelper.getData(key: "SUPPLIER_ID");

      Map<String, String> body = {};
      body['order_id'] = orderID;
      body['confirm_order'] = "1";
      body['supplier_id'] = supplierID;

      ConfirmOrderModel data = await confirmRepo.sendConfirm(body);
      if (data.status == true) {
        List<OneOrder>? newOrders = [];
        for (int i = 0; i < state.orders!.length; i++) {
          if (state.orders![i].orderId == orderID) {
            continue;
          } else {
            newOrders.add(state.orders![i]);
          }
        }
        emit(state.copyWith(orders: newOrders));
      }
    } catch (e) {
      logger.e(e);

      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }
}
