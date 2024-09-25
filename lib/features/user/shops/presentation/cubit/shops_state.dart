// ignore_for_file: must_be_immutable

part of 'shops_cubit.dart';

class ShopsState extends Equatable {
  ShopsState(
      {this.shops,
      this.shopsFilter,
      this.products,
      this.followers,
      this.defaultproducts,
      this.loadingProducts = false,
      this.followState = false});
  ShopModel? shops;
  ShopModel? shopsFilter;
  ProductsModel? products;
  FollowersModel? followers;
  bool? followState;
  ProductsModel? defaultproducts;
  bool loadingProducts;

  @override
  List<Object?> get props => [
        shops,
        shopsFilter,
        products,
        followers,
        defaultproducts,
        loadingProducts,
        followState
      ];
  ShopsState copyWith(
          {ShopModel? shops,
          ShopModel? shopsFilter,
          ProductsModel? products,
          FollowersModel? followers,
          ProductsModel? defaultproducts,
          bool? loadingProducts,
          bool? followState}) =>
      ShopsState(
          shops: shops ?? this.shops,
          followState: followState ?? this.followState,
          followers: followers ?? this.followers,
          loadingProducts: loadingProducts ?? this.loadingProducts,
          shopsFilter: shopsFilter ?? this.shopsFilter,
          defaultproducts: defaultproducts ?? this.defaultproducts,
          products: products ?? this.products);
}

class ShopsInitial extends ShopsState {}
