// ignore_for_file: must_be_immutable

part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  ProfileState(
      {this.userId,
      this.myFavorite,
      this.loadingFavorite = false,
      this.userName,
      this.phoneNumber,
      this.customerInfo,
      this.newDate,
      this.customerId,
      this.pointsActivities,
      this.clothesOrders,
      this.profileInfo,
      this.orderDetails,
      this.laundryOrders,
      this.loadingOrders = false,
      this.loadingBuy = false,
      this.loadingCollectPoints = false,
      this.showCollectPointButton = false,
      this.loadingPoints = false,
      this.loadingOrdersDetails = false,
      this.password});
  String? userId;
  List<ProfileInfo>? profileInfo;
  Duration? newDate;
  FavoriteModel? myFavorite;
  Customer? customerInfo;
  OrdersModel? clothesOrders;
  List<Activities>? pointsActivities;
  OrderDetailsModel? orderDetails;
  OrdersModel? laundryOrders;
  bool loadingFavorite;
  bool loadingOrders;
  bool loadingOrdersDetails;
  bool loadingBuy;
  bool showCollectPointButton;
  bool loadingPoints;
  bool loadingCollectPoints;
  String? userName;
  String? phoneNumber;
  String? customerId;
  String? password;

  @override
  List<Object?> get props => [
        userId,
        myFavorite,
        loadingFavorite,
        clothesOrders,
        customerInfo,
        laundryOrders,
        customerId,
        newDate,
        profileInfo,
        loadingPoints,
        userName,
        phoneNumber,
        pointsActivities,
        loadingCollectPoints,
        showCollectPointButton,
        loadingOrders,
        loadingOrdersDetails,
        loadingBuy,
        password,
        orderDetails,
      ];
  ProfileState copyWith({
    String? userId,
    String? userName,
    String? phoneNumber,
    Duration? newDate,
    List<ProfileInfo>? profileInfo,
    String? password,
    String? customerId,
    FavoriteModel? myFavorite,
    OrdersModel? clothesOrders,
    List<Activities>? pointsActivities,
    Customer? customerInfo,
    OrdersModel? laundryOrders,
    OrderDetailsModel? orderDetails,
    bool? loadingFavorite,
    bool? loadingPoints,
    bool? loadingCollectPoints,
    bool? loadingBuy,
    bool? showCollectPointButton,
    bool? loadingOrdersDetails,
    bool? loadingOrders,
  }) =>
      ProfileState(
          userId: userId ?? this.userId,
          showCollectPointButton:
              showCollectPointButton ?? this.showCollectPointButton,
          loadingBuy: loadingBuy ?? this.loadingBuy,
          loadingCollectPoints:
              loadingCollectPoints ?? this.loadingCollectPoints,
          userName: userName ?? this.userName,
          newDate: newDate ?? this.newDate,
          profileInfo: profileInfo ?? this.profileInfo,
          loadingPoints: loadingPoints ?? this.loadingPoints,
          customerInfo: customerInfo ?? this.customerInfo,
          clothesOrders: clothesOrders ?? this.clothesOrders,
          pointsActivities: pointsActivities ?? this.pointsActivities,
          laundryOrders: laundryOrders ?? this.laundryOrders,
          customerId: customerId ?? this.customerId,
          password: password ?? this.password,
          loadingOrders: loadingOrders ?? this.loadingOrders,
          orderDetails: orderDetails ?? this.orderDetails,
          loadingOrdersDetails:
              loadingOrdersDetails ?? this.loadingOrdersDetails,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          myFavorite: myFavorite ?? this.myFavorite,
          loadingFavorite: loadingFavorite ?? this.loadingFavorite);
}

class ProfileInitial extends ProfileState {}
