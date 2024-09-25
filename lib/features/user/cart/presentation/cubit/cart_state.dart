// ignore_for_file: must_be_immutable, non_constant_identifier_names

part of 'cart_cubit.dart';

class CartState extends Equatable {
  CartState({
    this.counter = 1,
    this.myAddress,
    this.Fees = "",
    this.subTotal = 0,
    this.earnedPoints = 0.0,
    this.userId,
    this.provinces,
    this.subTotalForLaundry,
    this.fromLaundry,
    this.selectedCity,
    this.categoryArray,
    this.quantityArray,
    this.cityId,
    this.notes,
    this.phoneNumber,
    this.latitude,
    this.longitude,
    this.addressTitle,
    this.cartitems,
    this.servicesArray,
    this.productId,
    this.loading = false,
    this.loadingMyAdress = false,
    this.loadingCart = false,
    this.productQuantity = 1,
    this.productSize,
    this.pricesArray,
    this.productColor,
    this.showCounter = false,
    this.active = -1,
    this.activeSize = -1,
    this.loadingInsertRoCart = false,
    this.loadingCheckOut = false,
  });
  int counter;
  List? categoryArray;
  List? servicesArray;
  List? quantityArray;
  List? pricesArray;
  int active;
  bool? fromLaundry;
  int? subTotal;
  double? earnedPoints;
  int? subTotalForLaundry;
  int activeSize;
  String? userId;
  MyAddressModel? myAddress;
  ProvincesModel? provinces;
  CartModel? cartitems;
  Provinces? selectedCity;
  String? cityId;
  String? Fees;
  String? notes;
  String? phoneNumber;
  String? productSize;
  String? productId;
  String? latitude;
  String? longitude;
  String? productColor;
  String? addressTitle;
  bool loading;
  bool showCounter;
  int productQuantity;
  bool loadingMyAdress;
  bool loadingCart;
  bool loadingInsertRoCart;
  bool loadingCheckOut;
  @override
  List<Object?> get props => [
        activeSize,
        active,
        counter,
        quantityArray,
        myAddress,
        earnedPoints,
        categoryArray,
        loadingCheckOut,
        userId,
        loadingInsertRoCart,
        provinces,
        fromLaundry,
        servicesArray,
        Fees,
        subTotalForLaundry,
        selectedCity,
        subTotal,
        cityId,
        showCounter,
        notes,
        productSize,
        productColor,
        productId,
        phoneNumber,
        latitude,
        productQuantity,
        longitude,
        pricesArray,
        addressTitle,
        loading,
        cartitems,
        loadingMyAdress,
        loadingCart
      ];

  CartState copyWith(
          {int? counter,
          int? activeSize,
          int? active,
          int? subTotalForLaundry,
          List? categoryArray,
          List? pricesArray,
          List? quantityArray,
          List? servicesArray,
          int? subTotal,
          bool? fromLaundry,
          MyAddressModel? myAddress,
          double? earnedPoints,
          String? userId,
          Provinces? selectedCity,
          String? cityId,
          String? Fees,
          String? productId,
          String? notes,
          String? productSize,
          CartModel? cartitems,
          String? phoneNumber,
          String? latitude,
          String? longitude,
          String? productColor,
          String? addressTitle,
          bool? loading,
          bool? loadingMyAdress,
          bool? showCounter,
          bool? loadingCheckOut,
          bool? loadingCart,
          bool? loadingInsertRoCart,
          int? productQuantity,
          ProvincesModel? provinces}) =>
      CartState(
        counter: counter ?? this.counter,
        quantityArray: quantityArray ?? this.quantityArray,
        categoryArray: categoryArray ?? this.categoryArray,
        subTotal: subTotal ?? this.subTotal,
        fromLaundry: fromLaundry ?? this.fromLaundry,
        activeSize: activeSize ?? this.activeSize,
        pricesArray: pricesArray ?? this.pricesArray,
        earnedPoints: earnedPoints ?? this.earnedPoints,
        servicesArray: servicesArray ?? this.servicesArray,
        active: active ?? this.active,
        cartitems: cartitems ?? this.cartitems,
        Fees: Fees ?? this.Fees,
        subTotalForLaundry: subTotalForLaundry ?? this.subTotalForLaundry,
        loadingCheckOut: loadingCheckOut ?? this.loadingCheckOut,
        userId: userId ?? this.userId,
        loadingInsertRoCart: loadingInsertRoCart ?? this.loadingInsertRoCart,
        myAddress: myAddress ?? this.myAddress,
        productColor: productColor ?? this.productColor,
        provinces: provinces ?? this.provinces,
        productSize: productSize ?? this.productSize,
        productId: productId ?? this.productId,
        productQuantity: productQuantity ?? this.productQuantity,
        selectedCity: selectedCity ?? this.selectedCity,
        cityId: cityId ?? this.cityId,
        notes: notes ?? this.notes,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        addressTitle: addressTitle ?? this.addressTitle,
        showCounter: showCounter ?? this.showCounter,
        loading: loading ?? this.loading,
        loadingMyAdress: loadingMyAdress ?? this.loadingMyAdress,
        loadingCart: loadingCart ?? this.loadingCart,
      );
}

class CartInitial extends CartState {}
