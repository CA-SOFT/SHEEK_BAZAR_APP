// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sheek_bazar/core/utils/cache_helper.dart';
import 'package:sheek_bazar/features/user/shops/data/models/follow_model.dart';
import 'package:sheek_bazar/features/user/shops/data/models/followers_model.dart';
import 'package:sheek_bazar/features/user/shops/data/models/products_model.dart';
import 'package:sheek_bazar/features/user/shops/data/repositories/follow_repo.dart';
import 'package:sheek_bazar/features/user/shops/data/repositories/followers_repo.dart';
import 'package:sheek_bazar/features/user/shops/data/repositories/shops_repo.dart';

import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/app_logger.dart';
import '../../data/models/shops_model.dart';
import '../../data/repositories/getProducts_repo.dart';

part 'shops_state.dart';

class ShopsCubit extends Cubit<ShopsState> {
  final ShopsRepo shopsRepo;
  final GetProductsRepo getProductsRepo;
  final FollowRepo followRepo;
  final FollowersRepo followersRepo;

  ShopsCubit({
    required this.shopsRepo,
    required this.getProductsRepo,
    required this.followRepo,
    required this.followersRepo,
  }) : super(ShopsInitial());

  Future<void> getShops(BuildContext context) async {
    try {
      Map<String, String> body = {};
      body['fetch_shops'] = "1";
      ShopModel data = await shopsRepo.getShops(body);
      emit(state.copyWith(shops: data));
      emit(state.copyWith(shopsFilter: data));
      logger.i(data);
    } catch (e) {
      logger.e(e);
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  Future<void> getFollowers(BuildContext context) async {
    emit(state.copyWith(loadingProducts: true));
    try {
      String customerId = await CacheHelper.getData(key: "CUSTOMER_ID");

      Map<String, String> body = {};
      body['fetch_followers'] = "1";
      body['customer_id'] = customerId;

      FollowersModel data = await followersRepo.getFollowers(body);
      emit(state.copyWith(followers: data));
      logger.i(data);
    } catch (e) {
      logger.e(e);
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
    emit(state.copyWith(loadingProducts: false));
  }

  changeFilter(List<Suppliers> value) =>
      emit(state.copyWith(shopsFilter: ShopModel(suppliers: value)));

  Future<void> getProducts(BuildContext context, String supplierID,
      String categoryId, String subcategoryId) async {
    try {
      emit(state.copyWith(loadingProducts: true));

      String? customerId = await CacheHelper.getData(key: "CUSTOMER_ID");

      Map<String, String> body = {};
      body['fetch_products'] = "1";
      if (supplierID != "-1") {
        body['supplier_id'] = supplierID;
        if (customerId != null) {
          body['customer_id'] = customerId;
        }
      }
      if (categoryId != "-1") {
        body['category_id'] = categoryId;
      }
      if (subcategoryId != "-1") {
        body['sub_category_id'] = subcategoryId;
      }
      ProductsModel data = await getProductsRepo.getProducts(body);
      emit(state.copyWith(products: data));
      emit(state.copyWith(defaultproducts: data));
      emit(state.copyWith(loadingProducts: false));

      logger.i(data);
    } catch (e) {
      emit(state.copyWith(loadingProducts: false));

      logger.e(e);
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  Future<void> follow(BuildContext context, String supplierID,
      {bool fromProfile = false}) async {
    try {
      emit(state.copyWith(followState: true));
      String customerId = await CacheHelper.getData(key: "CUSTOMER_ID");
      Map<String, String> body = {};

      body['toggle_follow'] = "1";
      body['customer_id'] = customerId;
      body['supplier_id'] = supplierID;

      FollowModel data = await followRepo.followSupplier(body);
      emit(state.copyWith(followState: false));
      if (data.message == "followed Successfully ") {
        ProductsModel? newProduct = state.products;
        newProduct!.supplierInfo![0].isFollowing = true;
        newProduct.supplierInfo![0].totalFollowers =
            (int.parse(newProduct.supplierInfo![0].totalFollowers!) + 1)
                .toString();
        emit(state.copyWith(products: newProduct));
        AppConstant.customAlert(context, "followed Successfully".toString(),
            withTranslate: false, witherror: false);
      } else {
        if (fromProfile) {
          FollowersModel? followers = state.followers;
          FollowersModel? newfollowers = FollowersModel(suppliers: []);
          for (int i = 0; i < followers!.suppliers!.length; i++) {
            if (followers.suppliers![i].supplierId == supplierID) {
              continue;
            } else {
              newfollowers.suppliers!.add(followers.suppliers![i]);
            }
          }
          emit(state.copyWith(followers: newfollowers));
        } else {
          ProductsModel? newProduct = state.products;
          newProduct!.supplierInfo![0].isFollowing = false;
          newProduct.supplierInfo![0].totalFollowers =
              (int.parse(newProduct.supplierInfo![0].totalFollowers!) - 1)
                  .toString();
          emit(state.copyWith(products: newProduct));
          AppConstant.customAlert(context, "unfollowed Successfully".toString(),
              withTranslate: false, witherror: false);
        }
      }
      logger.i(data);
    } catch (e) {
      emit(state.copyWith(followState: false));
      logger.e(e);
      await AppConstant.customAlert(context, e.toString(),
          withTranslate: false);
    }
  }

  changeSearch(List<Products> value) => emit(state.copyWith(
      products: ProductsModel(
          products: value,
          supplierAttachments: state.products!.supplierAttachments,
          supplierInfo: state.products!.supplierInfo)));

  Future<void> clearproducts() async {
    emit(state.copyWith(
        products: ProductsModel(
            products: [], supplierAttachments: [], supplierInfo: [])));
  }

  Future<void> filterProducts(BuildContext context, double startPrice,
      double endPrice, String? radioValue) async {
    if (radioValue == null) {
      List<Products> filteredProducts =
          state.defaultproducts!.products!.where((product) {
        String priceString = product.productPrice!;
        int price = int.parse(priceString);

        return price >= startPrice && price <= endPrice;
      }).toList();
      emit(state.copyWith(
          products: ProductsModel(
              products: filteredProducts,
              supplierAttachments: state.products!.supplierAttachments,
              supplierInfo: state.products!.supplierInfo)));
      Navigator.pop(context);
    } else {
      List<Products> filteredProducts =
          state.defaultproducts!.products!.where((product) {
        String priceString = product.productFinalPrice!;
        int price = int.parse(priceString);

        return price >= startPrice && price <= endPrice;
      }).toList();
      if (radioValue == "from cheapest") {
        filteredProducts.sort((a, b) => int.parse(a.productFinalPrice!)
            .compareTo(int.parse(b.productFinalPrice!)));
        emit(state.copyWith(
            products: ProductsModel(
                products: filteredProducts,
                supplierAttachments: state.products!.supplierAttachments,
                supplierInfo: state.products!.supplierInfo)));
        Navigator.pop(context);
      } else if (radioValue == "from expansive") {
        filteredProducts.sort((a, b) => int.parse(b.productFinalPrice!)
            .compareTo(int.parse(a.productFinalPrice!)));
        emit(state.copyWith(
            products: ProductsModel(
                products: filteredProducts,
                supplierAttachments: state.products!.supplierAttachments,
                supplierInfo: state.products!.supplierInfo)));
        Navigator.pop(context);
      } else if (radioValue == "from newest") {
        filteredProducts.sort((a, b) => DateTime.parse(a.createdAt!)
            .compareTo(DateTime.parse(b.createdAt!)));
        emit(state.copyWith(
            products: ProductsModel(
                products: filteredProducts,
                supplierAttachments: state.products!.supplierAttachments,
                supplierInfo: state.products!.supplierInfo)));
        Navigator.pop(context);
      } else if (radioValue == "from oldest") {
        filteredProducts.sort((a, b) => DateTime.parse(b.createdAt!)
            .compareTo(DateTime.parse(a.createdAt!)));
        emit(state.copyWith(
            products: ProductsModel(
                products: filteredProducts,
                supplierAttachments: state.products!.supplierAttachments,
                supplierInfo: state.products!.supplierInfo)));
        Navigator.pop(context);
      } else if (radioValue == "with discount") {
        List<Products> sortedFilteredProducts = filteredProducts
            .where((product) => product.productDiscount != "0")
            .toList();
        emit(state.copyWith(
            products: ProductsModel(
                products: sortedFilteredProducts,
                supplierAttachments: state.products!.supplierAttachments,
                supplierInfo: state.products!.supplierInfo)));
        Navigator.pop(context);
      } else if (radioValue == "without discount") {
        List<Products> sortedFilteredProducts = filteredProducts
            .where((product) => product.productDiscount == "0")
            .toList();
        emit(state.copyWith(
            products: ProductsModel(
                products: sortedFilteredProducts,
                supplierAttachments: state.products!.supplierAttachments,
                supplierInfo: state.products!.supplierInfo)));
        Navigator.pop(context);
      } else if (radioValue == "new") {
        List<Products> sortedFilteredProducts =
            filteredProducts.where((product) => product.isUsed == "0").toList();
        emit(state.copyWith(
            products: ProductsModel(
                products: sortedFilteredProducts,
                supplierAttachments: state.products!.supplierAttachments,
                supplierInfo: state.products!.supplierInfo)));
        Navigator.pop(context);
      } else if (radioValue == "old") {
        List<Products> sortedFilteredProducts =
            filteredProducts.where((product) => product.isUsed != "0").toList();
        emit(state.copyWith(
            products: ProductsModel(
                products: sortedFilteredProducts,
                supplierAttachments: state.products!.supplierAttachments,
                supplierInfo: state.products!.supplierInfo)));
        Navigator.pop(context);
      } else if (radioValue == "all products") {
        emit(state.copyWith(
          products: state.defaultproducts,
        ));
        Navigator.pop(context);
      }
    }
  }
}
