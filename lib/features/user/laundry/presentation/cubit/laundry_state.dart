// ignore_for_file: must_be_immutable

part of 'laundry_cubit.dart';

class LaundryState extends Equatable {
  LaundryState({
    this.response,
    this.total = "0",
    this.orders,
    this.categoryArray,
    this.servicesArray,
    this.pricesArray,
    this.quantityArray,
    this.initialValueForService,
    this.initialValueForClothesType,
    this.quantity = 1,
    this.serviceId,
    this.categoryId,
  });
  LundryModel? response;
  String? total;
  List? categoryArray;
  List? quantityArray;
  List? pricesArray;
  List? servicesArray;
  List? orders;
  String? initialValueForService;
  String? initialValueForClothesType;
  int? quantity;
  String? serviceId;
  String? categoryId;

  @override
  List<Object?> get props => [
        response,
        total,
        orders,
        categoryArray,
        serviceId,
        pricesArray,
        servicesArray,
        initialValueForService,
        quantityArray,
        initialValueForClothesType,
        quantity,
        categoryId,
      ];
  LaundryState copyWith(
          {LundryModel? response,
          List? orders,
          List? categoryArray,
          List? servicesArray,
          List? pricesArray,
          List? quantityArray,
          String? initialValueForService,
          String? initialValueForClothesType,
          String? serviceId,
          String? categoryId,
          int? quantity,
          String? total}) =>
      LaundryState(
        response: response ?? this.response,
        pricesArray: pricesArray ?? this.pricesArray,
        quantityArray: quantityArray ?? this.quantityArray,
        servicesArray: servicesArray ?? this.servicesArray,
        serviceId: serviceId ?? this.serviceId,
        categoryArray: categoryArray ?? this.categoryArray,
        initialValueForClothesType:
            initialValueForClothesType ?? this.initialValueForClothesType,
        initialValueForService:
            initialValueForService ?? this.initialValueForService,
        orders: orders ?? this.orders,
        categoryId: categoryId ?? this.categoryId,
        total: total ?? this.total,
        quantity: quantity ?? this.quantity,
      );
}

class LaundryInitial extends LaundryState {}
