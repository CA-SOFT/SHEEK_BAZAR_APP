// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:equatable/equatable.dart';
import 'package:sheek_bazar/features/user/home/data/models/use_app_model.dart';

import '../../data/models/home_model.dart';
import '../../data/models/productDetails_model.dart';

class HomeState extends Equatable {
  HomeState(
      {this.fetchHome = "1",
      this.pageNumber = "1",
      this.loadingData = false,
      this.fetchFromTab = false,
      this.isVideo = true,
      this.response,
      this.products,
      this.tutorialVideos,
      this.playVideo = true,
      this.muteVideo = true,
      this.loadingtutorialVideos = false,
      this.productsold,
      this.orginalProoducts,
      this.fetchData = false});

  String fetchHome, pageNumber;
  HomeModel? response;
  bool? loadingData;
  bool? fetchFromTab;
  bool? playVideo;
  bool? muteVideo;
  bool? isVideo;
  bool? loadingtutorialVideos;
  List<tutorialVideo>? tutorialVideos;
  List<Products>? products;
  List<Products>? productsold;
  List<Products>? orginalProoducts;
  bool fetchData;
  @override
  List<Object?> get props => [
        fetchHome,
        pageNumber,
        loadingData,
        isVideo,
        response,
        playVideo,
        products,
        muteVideo,
        fetchFromTab,
        tutorialVideos,
        productsold,
        loadingtutorialVideos,
        orginalProoducts,
        fetchData
      ];
  HomeState copyWith(
          {String? fetchHome,
          String? pageNumber,
          bool? loadingData,
          bool? isVideo,
          bool? loadingtutorialVideos,
          bool? playVideo,
          bool? muteVideo,
          List<tutorialVideo>? tutorialVideos,
          List<Products>? products,
          List<Products>? productsold,
          List<Products>? orginalProoducts,
          bool? fetchData,
          bool? fetchFromTab,
          HomeModel? response}) =>
      HomeState(
        fetchHome: fetchHome ?? this.fetchHome,
        loadingtutorialVideos:
            loadingtutorialVideos ?? this.loadingtutorialVideos,
        muteVideo: muteVideo ?? this.muteVideo,
        isVideo: isVideo ?? this.isVideo,
        tutorialVideos: tutorialVideos ?? this.tutorialVideos,
        playVideo: playVideo ?? this.playVideo,
        orginalProoducts: orginalProoducts ?? this.orginalProoducts,
        loadingData: loadingData ?? this.loadingData,
        pageNumber: pageNumber ?? this.pageNumber,
        fetchFromTab: fetchFromTab ?? this.fetchFromTab,
        products: products ?? this.products,
        productsold: productsold ?? this.productsold,
        response: response ?? this.response,
        fetchData: fetchData ?? this.fetchData,
      );
}

class ProductDetailsState extends Equatable {
  ProductDetailsState({this.productDetails, this.loading = false});

  ProductDetailsModel? productDetails;
  bool loading;

  @override
  List<Object?> get props => [productDetails, loading];

  ProductDetailsState copyWith(
          {ProductDetailsModel? productDetails, bool? loading}) =>
      ProductDetailsState(
        productDetails: productDetails ?? this.productDetails,
        loading: loading ?? this.loading,
      );
}

class CartInitial extends ProductDetailsState {}
