// ignore_for_file: must_be_immutable

part of 'supplier_order_bloc.dart';

class SupplierOrderState extends Equatable {
  SupplierOrderState({
    this.orders,
    this.ordersDetails,
    this.loadingOrders = false,
  });
  List<OneOrder>? orders;
  List<OrderItems>? ordersDetails;
  bool loadingOrders;
  @override
  List<Object?> get props => [
        orders,
        loadingOrders,
        ordersDetails,
      ];
  SupplierOrderState copyWith(
          {List<OneOrder>? orders,
          List<OrderItems>? ordersDetails,
          bool? loadingOrders}) =>
      SupplierOrderState(
        orders: orders ?? this.orders,
        loadingOrders: loadingOrders ?? this.loadingOrders,
        ordersDetails: ordersDetails ?? this.ordersDetails,
      );
}

class SupplierOrderStateInitial extends SupplierOrderState {}
